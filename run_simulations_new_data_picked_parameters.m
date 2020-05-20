
sgm0 = [1, 1]; % SH, LH
Q_0 = 10;
xi = [0,0];  % SH, LH

xi_range = 0.02:0.02:1;

for i = 1:10

%   % xi = xi + 0.02;
    xi = [xi_range(i) 0.2+xi_range(i)];
   % xi = [0 0.42];

    eta = [2.5, 2.5];

    para_vals_desc = {'sgm0_SH', 'sgm0_LH', 'Q', 'xi_SH', 'xi_LH', 'eta_SH', 'eta_LH'};
    para_vals = [sgm0, Q_0, xi, eta]; 

    n_try = i;

    for ID = 1:3

%         disp(ID)

    %% load parameter values
    %     params_dir = 'D:\MaggiesFarm\modeling_28_02\participant_data\thompson_noveltybonus_2nov_MAP\3params_2Hor_Q01_2sgm0\results\';
    %     tmp_res=load(strcat(params_dir,'res_thompson_',num2str(ID),'_results.mat'));


        n_trials = 400; %  normal: 400

        %% settings
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

        %% initialise model
        mo = initialise_model_MF_S0fixed_eta_new(settings);

        %% fill in parameters, model-funs etc
        mo = prep_model_MF(mo,settings,para_vals,settings.params.param_names);

        %% fill in priors if not constant
    %     if ~isempty(mo.funs.priorfun)
    %         mo = mo.funs.priorfun(mo);
    %     end

            % Generate apple sequences
            [params, user] = apple_params_for_mod_for_sim(n_trials); 

            % Write the log file needed for aggregation
            for b = 1:params.task.exp.n_blocks
                for g = 1:params.task.exp.n_trialPB
                    [user, params] = present_applesSIM(params, user, b, g);
                end
            end

            [data,gameIDs] = aggregateDataSIM(params, user);

    %     %% get data
    %     data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\';
    %     [data,gameIDs] = aggregateData(ID,data_dir);

        %% loop through trials (and conditions) to generate behaviour
        for c = 1:settings.task.N_hor
            for g = 1:settings.task.Ngames_per_hor         

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

                %  policy
                if c == 1
                    tmp_pi_SH = nanmean(mo.mat.pi{c,g},2)'; 
                    if tmp_dat.unshown_tree == 1
                        pi_SH(g,:) = [nan tmp_pi_SH(1:3)];
                    elseif tmp_dat.unshown_tree == 2
                        pi_SH(g,:) = [tmp_pi_SH(1) nan tmp_pi_SH(2:3)];
                    elseif tmp_dat.unshown_tree == 3
                        pi_SH(g,:) = [tmp_pi_SH(1:2) nan tmp_pi_SH(3)];
                    elseif tmp_dat.unshown_tree == 4
                        pi_SH(g,:) = [tmp_pi_SH(1:3) nan];
                    end 
                elseif c ==2 
                    tmp_pi_LH = nanmean(mo.mat.pi{c,g},2)'; 
                    if tmp_dat.unshown_tree == 1
                        pi_LH(g,:) = [nan tmp_pi_LH(1:3)];
                    elseif tmp_dat.unshown_tree == 2
                        pi_LH(g,:) = [tmp_pi_LH(1) nan tmp_pi_LH(2:3)];
                    elseif tmp_dat.unshown_tree == 3
                        pi_LH(g,:) = [tmp_pi_LH(1:2) nan tmp_pi_LH(3)];
                    elseif tmp_dat.unshown_tree == 4
                        pi_LH(g,:) = [tmp_pi_LH(1:3) nan];
                    end  
                end
            end
        end

        pi_SH_average(ID,:) = nansum(pi_SH,1)/(n_trials/2);
        pi_LH_average(ID,:) = nansum(pi_LH,1)/(n_trials/2);

    end

    sim_prob_choosing_trees_new_data_desc = {'A_SH', 'B_SH', 'C_SH', 'D_SH', 'A_LH', 'B_LH', 'C_LH', 'D_LH'};
    sim_prob_choosing_trees_new_data = [pi_SH_average, pi_LH_average];


%     while exist(strcat('D:\writing\MF\data_for_figs\sim_picked_parameters',int2str(n_try)))
%         n_try = n_try + 1;
%     end

    mkdir(strcat('D:\writing\MF\data_for_figs\sim_picked_parameters',int2str(n_try)))

    save(strcat('D:\writing\MF\data_for_figs\sim_picked_parameters',int2str(n_try),'\para_vals.mat'), 'para_vals');
    save(strcat('D:\writing\MF\data_for_figs\sim_picked_parameters',int2str(n_try),'\para_vals_desc.mat'), 'para_vals_desc');
    save(strcat('D:\writing\MF\data_for_figs\sim_picked_parameters',int2str(n_try),'\sim_prob_choosing_trees_new_data.mat'), 'sim_prob_choosing_trees_new_data');
    save(strcat('D:\writing\MF\data_for_figs\sim_picked_parameters',int2str(n_try),'\sim_prob_choosing_trees_new_data_desc.mat'), 'sim_prob_choosing_trees_new_data_desc');


   
    mean_pickedD = mean(sim_prob_choosing_trees_new_data(:,[4,8]),1)*100
end