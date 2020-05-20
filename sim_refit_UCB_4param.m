function sim_refit_UCB_4param(ID)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
holly = 1;
n_per_dim = 3;
param_bounds_gamma = [0.01,10]; % information bonus
param_bounds_tau = [0.1,2]; % inverse temperature
param_bounds_xi = [0,0.3]; % epsilon greedy
param_bounds_sgm0 = [1,5]; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    
    iter_selected = 0;
    
    % settings
    settings = [];
    settings.task.N_games = 200;
    settings.task.N_hor = 1;
    settings.task.Ngames_per_hor = settings.task.N_games / settings.task.N_hor;
    settings.task.N_trees = 3; % Changed
    settings.opts.TLT       = [];
    settings.funs.decfun        = @softmax;
    settings.funs.valuefun      = @UCB; 
    settings.funs.priorfun      = [];
    settings.funs.learningfun   = @kalman_filt;
    settings.desc = ['sim_UCB_' int2str(ID)];    % description of model (settings, etc)
    settings.params.param_names = {'gamma',   'tau',    'xi', 'sgm0'};   % is same param name as prev, write ''
    settings.params.lb          = [param_bounds_gamma(1)    param_bounds_tau(1) param_bounds_xi(1) param_bounds_sgm0(1)];    % lower bound
    settings.params.ub          = [param_bounds_gamma(2)    param_bounds_tau(2) param_bounds_xi(2) param_bounds_sgm0(2)];    % upper bound
    
    if holly == 1
        sim_dir = strcat('/home/mdubois/data/simulation_data/UCB/4params/', int2str(n_per_dim), 'perdim/');
    else
        sim_dir = strcat('D:\MaggiesFarm\modeling_28_02\simulation_data\UCB\4params\', int2str(n_per_dim), 'perdim\');
    end

    %% load parameter values
    tmp = load([sim_dir 'inp_params_UCB.mat']);
    para_vals = tmp.inp_params(ID,:);

    %% initialise model
    mo = initialise_model_MF_S0fixed_Q0fixed_lapse(settings);

    %% fill in parameters, model-funs etc
    mo = prep_model_MF(mo,settings,para_vals,settings.params.param_names);
    
    %% fill in priors if not constant
    if ~isempty(mo.funs.priorfun)
        mo = mo.funs.priorfun(mo);
    end

    % Generate apple sequences
    [params, user] = apple_params_for_mod(); % TODO -> add unused tree to the log
    %[params, user] = apple_params_for_mod_const(7,8,5,2); %same trial

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
            tmp_pi = nanmean(mo.mat.pi{c,g},2); %Changed (takes the column with no nan - column change because number of apple shown changes)
            r = rand(1);    % random choice seed
            tmp_cPi = cumsum(tmp_pi);
            tmp_chosen = find(tmp_cPi>=r,1,'first');
            
            if isempty(tmp_chosen)
                disp('tmp_chosen is empty in test_3_params')
            end

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

    %% make results directory
    results_dir = strcat(sim_dir, 'results');

    if exist(results_dir, 'dir') == 0
        mkdir(results_dir)
    end

    if holly == 1
        results_dir = strcat('/home/mdubois/data/simulation_data/UCB/4params/', int2str(n_per_dim), 'perdim/results/');
    else
        results_dir = strcat('D:\MaggiesFarm\modeling_28_02\simulation_data\UCB\4params\', int2str(n_per_dim), 'perdim\results\');
    end
    
    % save
    save_sim(results_dir, ID, settings, data, gameIDs, para_vals, mo);

    %% fit model
    
    modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed_lapse(x,settings.params.param_names,ID,settings,data,gameIDs);   
        
%     %%%%%%%% fmincon %%%%%%%%
%     options = optimoptions('fmincon','Display','off');
%     a = settings.params.lb;
%     b = settings.params.ub;
%     tic
%         for iter=1:20 %100 %:20 %100
%         % starting point
%         xo_fmincon = (b-a).*rand(1,1) + a; % random value in this interval     
%             if iter == 1
%                 [mEparams, mEmle, mEexitflag] = fmincon(modelfun,...
%                     xo_fmincon,[],[],[],[],...
%                     settings.params.lb,settings.params.ub,...
%                     [],options);
%             else
%                 [tmp_mEparams, tmp_mEmle, tmp_mEexitflag] = fmincon(modelfun,...
%                     xo_fmincon,[],[],[],[],...
%                     settings.params.lb,settings.params.ub,...
%                     [],options);
%                 if tmp_mEmle < mEmle
%                     iter_selected = iter_selected+1;
%                     mEparams = tmp_mEparams;
%                     mEmle = tmp_mEmle;
%                     mEexitflag = tmp_mEexitflag;
%                 end
%             end 
%         end
%     toc



        %%%%%%%% fmincon %%%%%%%%
        options = optimoptions('fmincon','Display','off');
        a = settings.params.lb;
        b = settings.params.ub;
        tic
        
       mEmatparams = nan(8,4);
       mEmatmle = nan(8,1);
       mEexitflag = nan(8,1);
       
            for iter=1:8 %:20%:100%:2 %:3%:20 %:100
                %disp(iter)
            % starting point
            xo_fmincon = (b-a).*rand(1,1) + a; % random value in this interval     
                [mEparams, mEmle, mEexitflag] = fmincon(modelfun,...
                    xo_fmincon,[],[],[],[],...
                    settings.params.lb,settings.params.ub,...
                    [],options);
                mEmatparams(iter,:) = mEparams;
                mEmatmle(iter,:) = mEmle;
                mEexitflag(iter,:) = mEexitflag;
            end
        toc

    if mod(ID,2)==0
        disp(strcat(int2str(iter_selected), 32,'fmincon better iterations on simulation ID: ',int2str(ID), 32, 'of', 32, int2str(n_per_dim^3)))
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
%     %%%%% Genetic Algorithm %%%%%
%     opts_GA = gaoptimset('Generations',300,'UseParallel','never','TolFun',1e-5,'CrossoverFcn',@crossoverheuristic,'EliteCount',4);
%     tic
%     [mEparams, mEmle, mEexitflag] = ga(modelfun,length(settings.params.lb),[],[],[],[],settings.params.lb,settings.params.ub,[],[],opts_GA);
%     fprintf( 'done.\n')
%     toc
%     
%     if mod(ID,2)==0
%         disp(strcat('simulation ID: ',int2str(ID), 32, 'of', 32, int2str(n_per_dim^3)))
%     end
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

    %% tidy up
    mEsubj = ID;
    %[nLogL, mo, logL] = modelfun(mEparams);
    
    [mEmle, ind]= min(mEmatmle);
    mEparams  = mEmatparams(ind,:);
    mEexitflag = mEexitflag(ind);
    mEsubj = ID;
    
    save_func(ID, settings, results_dir, mEparams, mEmle, mEexitflag, mEsubj);   

end