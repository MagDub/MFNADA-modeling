function HOLLY_crossvalidation_UCB_3param_2Hor_1tau(ID)

    % k-fold validation indexes
    range_test_mat = nan(10,20);
    range_train_mat = nan(10,180);

    for i =1:10
        k=i-1;
        range_train_mat(i,:) = [1:20*k, 20*k+21:200];
        range_test_mat(i,:) = [20*k+1:20*k+20];
    end

    
    holly = 1;

    for k = 1:10

        range_test = range_test_mat(k,:);
        range_train = range_train_mat(k,:);


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        param_bounds_gamma = [10^-8,10]; % information bonus
        param_bounds_tau = [10^-8,7]; % inverse temperature
        param_bounds_xi = [10^-8,0.5]; % epsilon greedy
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            algo = 'crossval_UCB';
            n_param = 3;

            if holly == 1
                results_dir = strcat('/home/mdubois/data/participant_data/',algo,'/',int2str(n_param), 'params_2Hor_1tau/results/');
            else
                results_dir = strcat('D:\MaggiesFarm\modeling_28_02\participant_data\',algo,'\', int2str(n_param), 'params_2Hor_1tau\results\');
            end


            %% settings
            settings = [];
            settings.task.N_games = 400; % %400/10*9; 
            settings.task.N_hor = 2;
            settings.task.Ngames_per_hor = settings.task.N_games / settings.task.N_hor;
            settings.task.N_trees = 3; % Changed
            settings.opts.TLT       = [];
            settings.funs.decfun        = @softmax;
            settings.funs.valuefun      = @UCB; 
            settings.funs.priorfun      = [];
            settings.funs.learningfun   = @kalman_filt;
            settings.desc = ['UCB'];    % description of model (settings, etc)
            settings.params.param_names = {'gamma'    ''     'tau'    'xi' '' };   % is same param name as prev, write ''
            settings.params.lb          = [param_bounds_gamma(1) param_bounds_gamma(1)   param_bounds_tau(1) param_bounds_xi(1) param_bounds_xi(1)];    % lower bound
            settings.params.ub          = [param_bounds_gamma(2) param_bounds_gamma(2)  param_bounds_tau(2) param_bounds_xi(2) param_bounds_xi(2)];    % upper bound

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

            modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed_lapse_crossval(x,settings.params.param_names,ID,settings,data_train,gameIDs_train, 1, 180);   

            %%%%%%%% fmincon %%%%%%%%
            options = optimoptions('fmincon','Display','off');
            a = settings.params.lb;
            b = settings.params.ub;

               mEmatparams = nan(8,5);
               mEmatmle = nan(8,1);
               mEexitflag = nan(8,1);

                for iter=1:8
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
            %[nLogL, mo, logL] = modelfun(mEparams);

            [mEmle, ind]= min(mEmatmle);
            mEparams  = mEmatparams(ind,:);
            mEexitflag = mEexitflag(ind);
            if ~exist(results_dir)
                mkdir(results_dir)
            end

            % save
            save_func_data(ID+k*1000, settings, results_dir, mEparams, mEmle, [], mEexitflag, mEsubj, [], [], mEmatparams, mEmatmle)


            %% test model

            data_test = data(1:2,range_test);
            gameIDs_test = gameIDs(1:2,range_test);

            [test_nLogL, ~, ~] = modelMF_S0fixed_Q0fixed_sgm0fixed_lapse_eta_crossval(mEparams,settings.params.param_names,ID,settings,data_test,gameIDs_test, 1, 20);
            average_prob(k) = exp(-test_nLogL/40);
    end

    save([results_dir 'aver_prob_' settings.desc '_' int2str(ID) '.mat'],'average_prob')

end