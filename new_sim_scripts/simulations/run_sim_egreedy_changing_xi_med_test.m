
xi_range = 1;
Q0 = 5;

part_num = 200;

sim_folder = strcat('../../../data/simulation_data/sim_prob_egreedy_med/changing_xi/Q0_',num2str(Q0),'/');

addpath('../../fit/holly/')

xi_iter = 1;
xi = xi_range(xi_iter);

para_vals_desc = {'Q0' 'xi'};

para_vals = [Q0, xi]; 

ID = 1;

% settings
settings = [];
settings.task.N_games           = 200; %changed
settings.task.N_hor             = 1;
settings.task.Ngames_per_hor    = settings.task.N_games / settings.task.N_hor;
settings.task.N_trees           = 3; 
settings.opts.TLT               = [];
settings.funs.decfun            = @argmax;
settings.funs.valuefun          = @heuristics; 
settings.funs.priorfun          = [];
settings.funs.learningfun       = @kalman_filt;
settings.desc                   = ['sim_argmax' int2str(ID)];    
settings.params.param_names     = para_vals_desc;   

% initialise model
mo = initialise_model_MF_S0fixed_sgm0fixed_eta(settings);

% fill in parameters, model-funs etc
mo = prep_model_MF(mo,settings,para_vals,settings.params.param_names);

% Generate apple sequences
[params, user] = apple_params_for_mod_med();

% Write the log file needed for aggregation
for b = 1:params.task.exp.n_blocks
    for g = 1:params.task.exp.n_trialPB
        [user, params] = present_applesSIM(params, user, b, g);
    end
end

[data,gameIDs] = aggregateDataSIM(params, user);

% 1 horizon
data = data(1,:);
gameIDs = gameIDs(1,:);

% loop through trials (and conditions) to generate behaviour
for g = 1:settings.task.Ngames_per_hor       

    data(1,g).gameID = gameIDs(1,g);

    % data
    tmp_dat = data(1,g);

    if tmp_dat.unshown_tree == 1
        tmp_dat = rmfield(tmp_dat,'a');
    elseif tmp_dat.unshown_tree == 2
        tmp_dat = rmfield(tmp_dat,'b');
    elseif tmp_dat.unshown_tree == 3
        tmp_dat = rmfield(tmp_dat,'c');
    elseif tmp_dat.unshown_tree == 4
        tmp_dat = rmfield(tmp_dat,'d');
    end

    % loop through trials of game
    for t = 1:size(tmp_dat.alltrees,1)+1 %CHANGED

        mo.mat.appleA{1,g} = data(1,g).a;
        mo.mat.appleB{1,g} = data(1,g).b;
        mo.mat.appleD{1,g} = data(1,g).d;

        if tmp_dat.unshown_tree == 1
            exploitTree(g,1)=2;
        elseif tmp_dat.unshown_tree == 2
            exploitTree(g,1)=1;
        elseif tmp_dat.unshown_tree == 3 || tmp_dat.unshown_tree == 4
            valueA = mean(data(1,g).a)';
            valueB = mo.mat.appleB{1,g};
            values = [valueA, valueB];
            [maxValues,IndmaxValues] = max(values'); %problem sometimes both have the same value
            exploitTree(g,1)=IndmaxValues;
        end

        if t == 1 % plug in priors
            mo.mat.Q{1,g}(:,t) = mo.params.Q0(1); 
            mo.mat.sgm{1,g}(:,t) = mo.params.sgm0(1);
        end

        % see outcome and learn
        if t <= size(tmp_dat.alltrees,1) %CHANGED
            mo = mo.funs.learningfun(mo,tmp_dat,1,g,t);
        else
            % calculate values & policy
            mo = mo.funs.valuefun(mo,1,g,t);

            % add lapse if needed
            if ~isempty(mo.params.xi) %epsilon greedy
                mo = lapse(mo,1,g,t);
            end
        end
    end

    tmp_pi = nanmean(mo.mat.pi{1,g},2);

    %  policy
    tmp_pi_SH = nanmean(mo.mat.pi{1,g},2)'; 

    if tmp_dat.unshown_tree == 3

        pi_SH(g,:) = [tmp_pi_SH(1:2) nan tmp_pi_SH(3)];

        if exploitTree(g,1)==1
            pi_exploit_SH(g,1) = tmp_pi_SH(1);
            pi_explore_SH(g,1) = tmp_pi_SH(2);
        elseif exploitTree(g,1)==2
            pi_exploit_SH(g,1) = tmp_pi_SH(2);
            pi_explore_SH(g,1) = tmp_pi_SH(1);
        end

        pi_novel_SH(g,1) = nan;
        pi_bad_SH(g,1) = tmp_pi_SH(3);

    elseif tmp_dat.unshown_tree == 4

        pi_SH(g,:) = [tmp_pi_SH(1:3) nan];

        if exploitTree(g,1)==1
            pi_exploit_SH(g,1) = tmp_pi_SH(1);
            pi_explore_SH(g,1) = tmp_pi_SH(2);
        elseif exploitTree(g,1)==2
            pi_exploit_SH(g,1) = tmp_pi_SH(2);
            pi_explore_SH(g,1) = tmp_pi_SH(1);
        end                   

        pi_novel_SH(g,1) = tmp_pi_SH(3);
        pi_bad_SH(g,1) = nan;

    else

        pi_SH(g,:) = [nan nan nan nan];

        pi_exploit_SH(g,1) = nan;
        pi_explore_SH(g,1) = nan;
        pi_novel_SH(g,1) = nan;
        pi_bad_SH(g,1) = nan;

    end 


    % make choice based on policy
    r = rand(1);    % random choice seed
    tmp_cPi = cumsum(tmp_pi);
    tmp_chosen = find(tmp_cPi>=r,1,'first');

    if data(1,g).unshown_tree == 1
        tree_vec = [2, 3, 4];
    elseif data(1,g).unshown_tree == 2
        tree_vec = [1, 3, 4];
    elseif data(1,g).unshown_tree == 3
        tree_vec = [1, 2, 4];
    elseif data(1,g).unshown_tree == 4
        tree_vec = [1, 2, 3];
    end

    data(1,g).chosen = tree_vec(tmp_chosen); % Changed    

end        

pi_SH_average = nansum(pi_SH,1)/(settings.task.N_games);

pi_SH_exploit = [pi_exploit_SH, pi_explore_SH, pi_novel_SH, pi_bad_SH];

pi_SH_average_exploit = nansum(pi_SH_exploit,1)/(settings.task.N_games);

xi_file = strcat('xi_',num2str(xi_range(xi_iter)));

sim_data_dir = strcat(sim_folder,xi_file,'/participant_',int2str(ID),'/');

if ~exist(sim_data_dir)
    mkdir(sim_data_dir)
end

save(strcat(sim_data_dir,'/data.mat'), 'data')

[sim_consistency_freq, sim_consistency_freq_desc] = make_consistency_from_sim(sim_data_dir);      
mat_consistency(ID,:) = sim_consistency_freq*100; 

mat_trees_desc = {'exploit', 'explore', 'C', 'D'};
mat_trees(ID,:) = pi_SH_average_exploit*100;

mat_trees_bandits_desc = {'A', 'B', 'C', 'D'};
mat_trees_bandits(ID,:) = pi_SH_average*100; 

mat_mean_SEM_consistency(xi_iter,:) = [xi mean(mat_consistency) std(mat_consistency)/sqrt(part_num-1)];

mat_mean_SEM_tree_high(xi_iter,:) = [xi mean(mat_trees(:,1)) std(mat_trees(:,1))/sqrt(part_num-1)];
mat_mean_SEM_tree_medium(xi_iter,:) = [xi mean(mat_trees(:,2)) std(mat_trees(:,2))/sqrt(part_num-1)];
mat_mean_SEM_tree_novel(xi_iter,:) = [xi mean(mat_trees(:,3)) std(mat_trees(:,3))/sqrt(part_num-1)];
mat_mean_SEM_tree_low(xi_iter,:) = [xi mean(mat_trees(:,4)) std(mat_trees(:,4))/sqrt(part_num-1)];

mat_mean_SEM_tree_standard_certain(xi_iter,:) = [xi mean(mat_trees_bandits(:,1)) std(mat_trees_bandits(:,1))/sqrt(part_num-1)];
mat_mean_SEM_tree_standard(xi_iter,:) = [xi mean(mat_trees_bandits(:,2)) std(mat_trees_bandits(:,2))/sqrt(part_num-1)];


% save(strcat(sim_folder,'mat_mean_SEM_consistency.mat'), 'mat_mean_SEM_consistency');    
% save(strcat(sim_folder,'mat_mean_SEM_tree_high.mat'), 'mat_mean_SEM_tree_high');  
% save(strcat(sim_folder,'mat_mean_SEM_tree_medium.mat'), 'mat_mean_SEM_tree_medium');  
% save(strcat(sim_folder,'mat_mean_SEM_tree_novel.mat'), 'mat_mean_SEM_tree_novel');  
% save(strcat(sim_folder,'mat_mean_SEM_tree_low.mat'), 'mat_mean_SEM_tree_low'); 
% save(strcat(sim_folder,'mat_mean_SEM_tree_standard_certain.mat'), 'mat_mean_SEM_tree_standard_certain');  
% save(strcat(sim_folder,'mat_mean_SEM_tree_standard.mat'), 'mat_mean_SEM_tree_standard'); 
    
 

