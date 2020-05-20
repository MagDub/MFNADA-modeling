function crossvalidation_thompson_3param_nov_2Hor_2nov_Q01_2sgm0_new(ID)

    trials_trained_on = 180;

    % k-fold validation indexes
    range_test_mat = nan(10,20);
    range_train_mat = nan(10,180);

    for i =1:10
        k=i-1;
        range_train_mat(i,:) = [1:20*k, 20*k+21:200];
        range_test_mat(i,:) = [20*k+1:20*k+20];
    end

    holly = 0;
    
    for k = 1:10

        range_test = range_test_mat(k,:);
        range_train = range_train_mat(k,:);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        param_bounds_sgm0 = [0.01,6];
        param_bounds_Q0 = [1,10]; 
        param_bounds_xi = [10^-8,0.5]; 
        param_bounds_eta = [0,5];
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        algo = 'crossval_thompson_noveltybonus_2nov';
        n_param = 3;

        if holly == 1
            results_dir = strcat('/home/mdubois/data/participant_data/',algo,'/',int2str(n_param), 'params_2Hor_Q01_2sgm0_new/results/');
        else
            results_dir = strcat('D:\MaggiesFarm\modeling_28_02\participant_data\',algo,'\', int2str(n_param), 'params_2Hor_Q01_2sgm0_new\results\');
        end

        % settings
        settings = [];
        settings.task.N_games = 400;
        settings.task.N_hor = 2;
        settings.task.Ngames_per_hor = settings.task.N_games / settings.task.N_hor;
        settings.task.N_trees = 3;
        settings.opts.TLT       = [];
        settings.funs.decfun        = @softmax;
        settings.funs.valuefun      = @mvnorm_Thompson_noveltybonus_test; %@hybrid; % @UCB; % 
        settings.funs.priorfun      = [];
        settings.funs.learningfun   = @kalman_filt;
        settings.desc = ['thompson'];    % description of model (settings, etc)
        settings.params.param_names = {'sgm0', '', 'Q0','xi', '', 'eta', ''};   % is same param name as prev, write ''
        settings.params.lb          = [param_bounds_sgm0(1) param_bounds_sgm0(1)  param_bounds_Q0(1)  param_bounds_xi(1) param_bounds_xi(1) param_bounds_eta(1) param_bounds_eta(1)];    % lower bound
        settings.params.ub          = [param_bounds_sgm0(2) param_bounds_sgm0(2)  param_bounds_Q0(2)  param_bounds_xi(2) param_bounds_xi(2) param_bounds_eta(2) param_bounds_eta(2)];    % upper bound


        %% get data
        if holly == 1
            data_dir = '/data/mdubois/MaggiesFarm/data/';
        else
            data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\';
        end
        [data,gameIDs] = aggregateData(ID,data_dir);

        %% fit model

        data_train = data(1:2,range_train);
        gameIDs_train = gameIDs(1:2,range_train);
    
        modelfun = @(x) modelMF_S0fixed_crossval_eta_2sgm0(x,settings.params.param_names,ID,settings,data_train,gameIDs_train, 1, trials_trained_on);  

        %%%%%%%% fmincon %%%%%%%%
        options = optimoptions('fmincon','Display','off');
        a = settings.params.lb;
        b = settings.params.ub;
        
        mEmatparams = nan(8,7);
        mEmatmle = nan(8,1);
        mEexitflag = nan(8,1);
       
        parfor iter=1:8
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

        %% tidy up  
        mEsubj = ID;

        [mEmle, ind]= min(mEmatmle);
        mEparams  = mEmatparams(ind,:);
        mEexitflag = mEexitflag(ind);
        if ~exist(results_dir)
            mkdir(results_dir)
        end

        % save
        save_func_data(ID+k*1000, settings, results_dir, mEparams, mEmle, [], mEexitflag, mEsubj, [], [], mEmatparams, mEmatmle, [])

        %% test model

        data_test = data(1:2,range_test);
        gameIDs_test = gameIDs(1:2,range_test);

        [test_nLogL, ~, ~] = modelMF_S0fixed_crossval_eta(mEparams,settings.params.param_names,ID,settings,data_test,gameIDs_test, 1, 20);
        average_prob(k) = exp(-test_nLogL/40);
    end

save([results_dir 'aver_prob_' settings.desc '_' int2str(ID) '.mat'],'average_prob')

end