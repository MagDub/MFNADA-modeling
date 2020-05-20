% function sim_thompson_3param_noveltybonus_parhor(ID)
ID = 501;

    %% load parameter values
    params_dir = 'D:\MaggiesFarm\modeling_28_02\participant_data\thompson_noveltybonus_2nov_MAP\3params_2Hor_Q01_2sgm0\results\';
    tmp_res=load(strcat(params_dir,'res_thompson_',num2str(501),'_results.mat'));
    para_vals = tmp_res.mEparams;
   
    %% settings
    settings = [];
    settings.task.N_games = 400;
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
    mo = initialise_model_MF_S0fixed_eta(settings);

    %% fill in parameters, model-funs etc
    mo = prep_model_MF(mo,settings,para_vals,settings.params.param_names);
    
    %% fill in priors if not constant
    if ~isempty(mo.funs.priorfun)
        mo = mo.funs.priorfun(mo);
    end

    %     % Generate apple sequences
    %     [params, user] = apple_params_for_mod(); 
    %     
    %     % Write the log file needed for aggregation
    %     for b = 1:params.task.exp.n_blocks
    %         for g = 1:params.task.exp.n_trialPB
    %             [user, params] = present_applesSIM(params, user, b, g);
    %         end
    %     end
    % 
    %     [data,gameIDs] = aggregateDataSIM(params, user);
    
    %% get data
    data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\';
    [data,gameIDs] = aggregateData(ID,data_dir);

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
                if t == 1 % plug in priors
                    mo.mat.Q{c,g}(:,t) = mo.params.Q0(1);
                    mo.mat.sgm{c,g}(:,t) = mo.params.sgm0(1);
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

            % make choice based on policy
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
    
    pi_SH_average(ID-500) = nanmean(pi_SH,1);
    pi_LH_average(ID-500) = nanmean(pi_SH,1);

% end