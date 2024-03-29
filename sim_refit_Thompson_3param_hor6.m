function sim_refit_Thompson_3param_hor6(ID)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
holly = 1;
n_per_dim = 10;
param_bounds_xi = [0.01,0.5];
param_bounds_sgm0 = [1,10]; 
param_bounds_Q0 = [0.1,10]; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    iter_selected = 0;

    % settings
    settings = [];
    settings.task.N_games = 200;
    settings.task.N_hor = 1;
    settings.task.Ngames_per_hor = settings.task.N_games / settings.task.N_hor;
    settings.task.N_trees = 3;
    settings.opts.TLT       = [];
    settings.funs.decfun        = @softmax;
    settings.funs.valuefun      = @mvnorm_Thompson; %@hybrid; % @UCB; % 
    settings.funs.priorfun      = [];
    settings.funs.learningfun   = @kalman_filt;
    settings.desc = ['sim_thompson_' int2str(ID)];    % description of model (settings, etc)
    settings.params.param_names = {'sgm0','Q0','xi'};   % is same param name as prev, write ''
    settings.params.lb          = [param_bounds_sgm0(1)    param_bounds_Q0(1)  param_bounds_xi(1)];    % lower bound
    settings.params.ub          = [param_bounds_sgm0(2)    param_bounds_Q0(2)  param_bounds_xi(2)];    % upper bound

    
    if holly == 1
        sim_dir = strcat('/home/mdubois/data/simulation_data/thompson/3params/', int2str(n_per_dim), 'perdim/hor6/');
    else
        sim_dir = strcat('D:\MaggiesFarm\modeling_28_02\simulation_data\thompson\3params\', int2str(n_per_dim), 'perdim\hor6\');
    end


    %% load parameter values
    tmp = load([sim_dir 'inp_params_thompson.mat']);
    para_vals = tmp.inp_params(ID,:);

    %% initialise model
    mo = initialise_model_MF_S0fixed(settings);

    %% fill in parameters, model-funs etc
    mo = prep_model_MF(mo,settings,para_vals,settings.params.param_names);

    %% fill in priors if not constant
    if ~isempty(mo.funs.priorfun)
        mo = mo.funs.priorfun(mo);
    end

    % Generate apple sequences
    [params, user] = apple_params_for_mod_hor6(); % TODO -> add unused tree to the log
    %[params, user] = apple_params_for_mod_const(7,8,5,2); %same trial

    % Write the log file needed for aggregation
    for b = 1:params.task.exp.n_blocks
        for g = 1:params.task.exp.n_trialPB
            [user, params] = present_applesSIM(params, user, b, g);
        end
    end

    [data,gameIDs] = aggregateDataSIM(params, user);


    %% loop through trials (and conditions) to generate behaviour
    for c = 1%:settings.task.N_hor
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
            for t = 1:size(tmp_dat.alltrees,1) %CHANGED
                if t == 1 % plug in priors
                    mo.mat.Q{c,g}(:,t) = mo.params.Q0(1);
                    mo.mat.sgm{c,g}(:,t) = mo.params.sgm0(1);
                end

                % see outcome and learn
                if t < size(tmp_dat.alltrees,1) %CHANGED
                    mo = mo.funs.learningfun(mo,tmp_dat,c,g,t);

                else
                    % calculate values & policy
                    mo = mo.funs.valuefun(mo,c,g,t);

                    % add lapse if needed
                    if ~isempty(mo.params.xi)
                        mo = lapse(mo,c,g,t);
                    end


                end

            end

            % make choice based on policy
            tmp_pi = nanmean(mo.mat.pi{c,g},2); %Changed (takes the column with no nan - column change because number of apple shown changes)
            
            tmp_chosen = [];
            while isempty(tmp_chosen)
                r = rand(1);    % random choice seed
                tmp_cPi = cumsum(tmp_pi);
                tmp_chosen = find(tmp_cPi>=r,1,'first');
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
        results_dir = strcat('/home/mdubois/data/simulation_data/thompson/3params/', int2str(n_per_dim), 'perdim/hor6/results/');
    else
        results_dir = strcat('D:\MaggiesFarm\modeling_28_02\simulation_data\thompson\3params\', int2str(n_per_dim), 'perdim\hor6\results\');
    end
        
    % save
    save_sim(results_dir, ID, settings, data, gameIDs, para_vals, mo)


    %% fit model
    a = settings.params.lb;
    b = settings.params.ub;
    
    for iter=1:100
        
        % starting point of fmincon
        xo_fmincon = (b-a).*rand(1,1) + a; % random value in this interval

        % fit model
        modelfun = @(x) modelMF_S0fixed(x,settings.params.param_names,ID,settings,data,gameIDs);

        options = optimoptions('fmincon','Display','off');

        if iter == 1
            [mEparams, mEmle, mEexitflag] = fmincon(modelfun,...
                xo_fmincon,[],[],[],[],...
                settings.params.lb,settings.params.ub,...
                [],options);
        else
            [tmp_mEparams, tmp_mEmle, tmp_mEexitflag] = fmincon(modelfun,...
                xo_fmincon,[],[],[],[],...
                settings.params.lb,settings.params.ub,...
                [],options);
            if tmp_mEmle < mEmle
                iter_selected = iter_selected+1;
                mEparams = tmp_mEparams;
                mEmle = tmp_mEmle;
                mEexitflag = tmp_mEexitflag;
            end
        end
    end

    %% tidy up
    mEsubj = ID;
    [nLogL, mo, logL] = modelfun(mEparams);

    save_func(ID, settings, results_dir, mEparams, mEmle, mEexitflag, mEsubj);

    if holly == 0
        if mod(ID,2)==0
            disp(strcat(int2str(iter_selected), 32,'fmincon better iterations on simulation ID: ',int2str(ID), 32, 'of', 32, int2str(n_per_dim^n_param)))
        end
    end

end