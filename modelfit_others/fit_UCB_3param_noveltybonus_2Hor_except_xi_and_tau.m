function fit_UCB_3param_noveltybonus_2Hor_except_xi_and_tau(ID, optim_algo)
 
holly = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_gamma = [10^-8,10]; % information bonus
param_bounds_tau = [10^-8,7]; % inverse temperature
param_bounds_xi = [10^-8,0.5]; % epsilon greedy
param_bounds_eta = [0,5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    algo = 'UCB_noveltybonus';
    n_param = 4;
    
    if holly == 1
        results_dir = strcat('/home/mdubois/data/participant_data/',algo,'/',int2str(n_param), 'params_2Hor_1tau1xi/results/', optim_algo,'/');
    else
        results_dir = strcat('D:\MaggiesFarm\modeling_28_02\participant_data\',algo,'\', int2str(n_param), 'params_2Hor_1tau1xi\results\',optim_algo,'\');
    end
    
    iter_selected = 0;
    
    %% settings
    settings = [];
    settings.task.N_games = 400;
    settings.task.N_hor = 2;
    settings.task.Ngames_per_hor = settings.task.N_games / settings.task.N_hor;
    settings.task.N_trees = 3; % Changed
    settings.opts.TLT       = [];
    settings.funs.decfun        = @softmax;
    settings.funs.valuefun      = @UCB_noveltybonus; 
    settings.funs.priorfun      = [];
    settings.funs.learningfun   = @kalman_filt;
    settings.desc = ['UCB'];    % description of model (settings, etc)
    settings.params.param_names = {'gamma'   ''         'tau'   'xi'   'eta'};   % is same param name as prev, write ''
    settings.params.lb          = [param_bounds_gamma(1)   param_bounds_gamma(1) param_bounds_tau(1) param_bounds_xi(1) param_bounds_eta(1)];    % lower bound
    settings.params.ub          = [param_bounds_gamma(2)   param_bounds_gamma(2) param_bounds_tau(2) param_bounds_xi(2) param_bounds_eta(2)];    % upper bound
    
    %% get data
    data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\';
    [data,gameIDs] = aggregateData(ID,data_dir);

    %% fit model
    
    modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed_lapse_eta(x,settings.params.param_names,ID,settings,data,gameIDs);   

    %%%%%%%% fmincon %%%%%%%%
    options = optimoptions('fmincon','Display','off');
    a = settings.params.lb;
    b = settings.params.ub;
    tic

   mEmatparams = nan(8,5);
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
        toc

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
    save_func_data(ID, settings, results_dir, mEparams, mEmle,[], mEexitflag, mEsubj, [], [], mEmatparams, mEmatmle)

    disp(strcat(int2str(iter_selected), 32,'fmincon better iterations in participant: ',int2str(ID)))

end