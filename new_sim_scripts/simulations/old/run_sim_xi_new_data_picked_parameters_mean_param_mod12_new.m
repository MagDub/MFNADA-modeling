

sgm0 = 1.312;
eta = 2.625;
Q0 = 3.200;

part_num = 200;

xi_range = 0:0.01:0.5;

sim_folder = strcat('../../../data/simulation_data/sim_prob_mod12/changing_xi/sgm0_',num2str(sgm0),'_Q0_',num2str(Q0),'_eta_',num2str(eta),'/');

addpath('../../fit/holly/')

for xi_iter = 1:size(xi_range,2)-1

    xi = [xi_range(xi_iter) 0.5+xi_range(xi_iter)];

    eta = [eta, eta];

    para_vals_desc = {'sgm0_SH', 'sgm0_LH', 'Q', 'xi_SH', 'xi_LH', 'eta_SH', 'eta_LH'};
    para_vals = [sgm0, Q0, xi, eta]; 

    for ID = 1:part_num

        n_trials = 400; 

        % settings
        settings = [];
        settings.task.N_games = n_trials;
        settings.task.N_hor = 2;
        settings.task.Ngames_per_hor = settings.task.N_games / settings.task.N_hor;
        settings.task.N_trees = 3; % Changed
        settings.opts.TLT       = [];
        settings.funs.decfun        = @softmax;
        settings.funs.valuefun      = @mvnorm_Thompson_noveltybonus_new; %@hybrid; % @thompson; % 
        settings.funs.priorfun      = [];
        settings.funs.learningfun   = @kalman_filt;
        settings.desc = ['sim_thompson_noveltybonus' int2str(ID)];    % description of model (settings, etc)
        settings.params.param_names = {'sgm0', '', 'Q0','xi', '', 'eta', ''};   % is same param name as prev, write ''

        % initialise model
        mo = initialise_model_MF_S0fixed_eta_2sgm0(settings);

        % fill in parameters, model-funs etc
        mo = prep_model_MF(mo,settings,para_vals,settings.params.param_names);

        % Generate apple sequences
        [params, user] = apple_params_for_mod();

        % Write the log file needed for aggregation
        for b = 1:params.task.exp.n_blocks
            for g = 1:params.task.exp.n_trialPB
                [user, params] = present_applesSIM(params, user, b, g);
            end
        end

     [data,gameIDs] = aggregateDataSIM(params, user);

    %% loop through trials (and conditions) to generate behaviour
    for c = 1:settings.task.N_hor
        for g = 1:settings.task.Ngames_per_hor       
            
            data(c,g).gameID = gameIDs(c,g);
        
            % data
            tmp_dat = data(c,g);

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
                
            mo.mat.appleA{c,g} = data(c,g).a;
            mo.mat.appleB{c,g} = data(c,g).b;
            mo.mat.appleD{c,g} = data(c,g).d;
            
            if tmp_dat.unshown_tree == 1
                exploitTree(g,c)=2;
            elseif tmp_dat.unshown_tree == 2
                exploitTree(g,c)=1;
            elseif tmp_dat.unshown_tree == 3 || tmp_dat.unshown_tree == 4
                valueA = mean(data(c,g).a)';
                valueB = mo.mat.appleB{c,g};
                values = [valueA, valueB];
                [maxValues,IndmaxValues] = max(values'); %problem sometimes both have the same value
                exploitTree(g,c)=IndmaxValues;
            end
    
                if t == 1 % plug in priors
                    mo.mat.Q{c,g}(:,t) = mo.params.Q0(1); 
                    mo.mat.sgm{c,g}(:,t) = mo.params.sgm0(c);
                end
                
                % see outcome and learn
                if t <= size(tmp_dat.alltrees,1) %CHANGED
                    mo = mo.funs.learningfun(mo,tmp_dat,c,g,t);
                else
                    % calculate values & policy
                    mo = mo.funs.valuefun(mo,c,g,t);
                    
                        % add lapse if needed
                        if ~isempty(mo.params.xi) %epsilon greedy
                            mo = lapse(mo,c,g,t);
                        end
                end
            end

            tmp_pi = nanmean(mo.mat.pi{c,g},2);
            
            %  policy
            if c == 1
                
                tmp_pi_SH = nanmean(mo.mat.pi{c,g},2)'; 
                
                if tmp_dat.unshown_tree == 1
                    pi_SH(g,:) = [nan tmp_pi_SH(1:3)];
                    
                    pi_exploit_SH(g,1) = tmp_pi_SH(1);
                    pi_explore_SH(g,1) = nan;
                    pi_novel_SH(g,1) = tmp_pi_SH(2);
                    pi_bad_SH(g,1) = tmp_pi_SH(3);
                
                elseif tmp_dat.unshown_tree == 2
                    pi_SH(g,:) = [tmp_pi_SH(1) nan tmp_pi_SH(2:3)];
                    
                    pi_exploit_SH(g,1) = tmp_pi_SH(1);
                    pi_explore_SH(g,1) = nan;
                    pi_novel_SH(g,1) = tmp_pi_SH(2);
                    pi_bad_SH(g,1) = tmp_pi_SH(3);
                    
                elseif tmp_dat.unshown_tree == 3
                    
                    pi_SH(g,:) = [tmp_pi_SH(1:2) nan tmp_pi_SH(3)];
                    
                    if exploitTree(g,c)==1
                        pi_exploit_SH(g,1) = tmp_pi_SH(1);
                        pi_explore_SH(g,1) = tmp_pi_SH(2);
                    elseif exploitTree(g,c)==2
                        pi_exploit_SH(g,1) = tmp_pi_SH(2);
                        pi_explore_SH(g,1) = tmp_pi_SH(1);
                    end
                    
                    pi_novel_SH(g,1) = nan;
                    pi_bad_SH(g,1) = tmp_pi_SH(3);
                    
                elseif tmp_dat.unshown_tree == 4
                    
                    pi_SH(g,:) = [tmp_pi_SH(1:3) nan];
                    
                    if exploitTree(g,c)==1
                        pi_exploit_SH(g,1) = tmp_pi_SH(1);
                        pi_explore_SH(g,1) = tmp_pi_SH(2);
                    elseif exploitTree(g,c)==2
                        pi_exploit_SH(g,1) = tmp_pi_SH(2);
                        pi_explore_SH(g,1) = tmp_pi_SH(1);
                    end                   
                    
                    pi_novel_SH(g,1) = tmp_pi_SH(3);
                    pi_bad_SH(g,1) = nan;
                    
                end 
                
            elseif c==2 
                
                 tmp_pi_LH = nanmean(mo.mat.pi{c,g},2)'; 
                
                if tmp_dat.unshown_tree == 1
                    
                    pi_LH(g,:) = [nan tmp_pi_LH(1:3)];
                    pi_exploit_LH(g,1) = tmp_pi_LH(1);
                    pi_explore_LH(g,1) = nan;
                    pi_novel_LH(g,1) = tmp_pi_LH(2);
                    pi_bad_LH(g,1) = tmp_pi_LH(3);
                
                elseif tmp_dat.unshown_tree == 2
                    
                    pi_LH(g,:) = [tmp_pi_LH(1) nan tmp_pi_LH(2:3)];
                    
                    pi_exploit_LH(g,1) = tmp_pi_LH(1);
                    pi_explore_LH(g,1) = nan;
                    pi_novel_LH(g,1) = tmp_pi_LH(2);
                    pi_bad_LH(g,1) = tmp_pi_LH(3);
                    
                elseif tmp_dat.unshown_tree == 3
                    
                    pi_LH(g,:) = [tmp_pi_LH(1:2) nan tmp_pi_LH(3)];
                    
                    if exploitTree(g,c)==1
                        pi_exploit_LH(g,1) = tmp_pi_LH(1);
                        pi_explore_LH(g,1) = tmp_pi_LH(2);
                    elseif exploitTree(g,c)==2
                        pi_exploit_LH(g,1) = tmp_pi_LH(2);
                        pi_explore_LH(g,1) = tmp_pi_LH(1);
                    end
                    
                    pi_novel_LH(g,1) = nan;
                    pi_bad_LH(g,1) = tmp_pi_LH(3);
                    
                elseif tmp_dat.unshown_tree == 4
                    
                    pi_LH(g,:) = [tmp_pi_LH(1:3) nan];
                    
                    if exploitTree(g,c)==1
                        pi_exploit_LH(g,1) = tmp_pi_LH(1);
                        pi_explore_LH(g,1) = tmp_pi_LH(2);
                    elseif exploitTree(g,c)==2
                        pi_exploit_LH(g,1) = tmp_pi_LH(2);
                        pi_explore_LH(g,1) = tmp_pi_LH(1);
                    end                   
                    
                    pi_novel_LH(g,1) = tmp_pi_LH(3);
                    pi_bad_LH(g,1) = nan;
                    
                end  
            end
            
            % make choice based on policy
            r = rand(1);    % random choice seed
            tmp_cPi = cumsum(tmp_pi);
            tmp_chosen = find(tmp_cPi>=r,1,'first');

            if data(c,g).unshown_tree == 1
                tree_vec = [2, 3, 4];
            elseif data(c,g).unshown_tree == 2
                tree_vec = [1, 3, 4];
            elseif data(c,g).unshown_tree == 3
                tree_vec = [1, 2, 4];
            elseif data(c,g).unshown_tree == 4
                tree_vec = [1, 2, 3];
            end

            data(c,g).chosen = tree_vec(tmp_chosen); % Changed    
            
        end
    end
        

        pi_SH_average = nansum(pi_SH,1)/(n_trials/2);
        pi_LH_average = nansum(pi_LH,1)/(n_trials/2);

        pi_SH_exploit = [pi_exploit_SH, pi_explore_SH, pi_novel_SH, pi_bad_SH];
        pi_LH_exploit = [pi_exploit_LH, pi_explore_LH, pi_novel_LH, pi_bad_LH];

        pi_SH_average_exploit = nansum(pi_SH_exploit,1)/(n_trials/2);
        pi_LH_average_exploit = nansum(pi_LH_exploit,1)/(n_trials/2);
        
        xi_file = strcat('xiSH_',num2str(xi_range(xi_iter)),'_xiLH_',num2str(xi_range(xi_iter)+0.5));

        sim_data_dir = strcat(sim_folder,xi_file,'/participant_',int2str(ID),'/');
        
        if ~exist(sim_data_dir)
            mkdir(sim_data_dir)
        end
        
        save(strcat(sim_data_dir,'/data.mat'), 'data')
        
        [sim_consistency_freq, sim_consistency_freq_desc] = make_consistency_from_sim(sim_data_dir);

        sim_prob_choosing_trees_new_data_desc = {'A_SH', 'B_SH', 'C_SH', 'D_SH', 'A_LH', 'B_LH', 'C_LH', 'D_LH'};
        sim_prob_choosing_trees_new_data = [pi_SH_average, pi_LH_average];

        sim_prob_choosing_exploit_trees_new_data_desc = {'exploit_SH', 'explore_SH', 'C_SH', 'D_SH', 'exploit_LH', 'explore_LH', 'C_LH', 'D_LH'};
        sim_prob_choosing_exploit_trees_new_data = [pi_SH_average_exploit, pi_LH_average_exploit];

        save(strcat(sim_data_dir,'/sim_consistency_freq.mat'),'sim_consistency_freq');
        save(strcat(sim_data_dir,'/sim_consistency_freq_desc.mat'),'sim_consistency_freq_desc');
        save(strcat(sim_data_dir,'/sim_prob_choosing_trees_new_data.mat'),'sim_prob_choosing_trees_new_data');
        save(strcat(sim_data_dir,'/sim_prob_choosing_trees_new_data_desc.mat'),'sim_prob_choosing_trees_new_data_desc');
        save(strcat(sim_data_dir,'/sim_prob_choosing_exploit_trees_new_data.mat'),'sim_prob_choosing_exploit_trees_new_data');
        save(strcat(sim_data_dir,'/sim_prob_choosing_exploit_trees_new_data_desc.mat'),'sim_prob_choosing_exploit_trees_new_data_desc');
        
    end

end


