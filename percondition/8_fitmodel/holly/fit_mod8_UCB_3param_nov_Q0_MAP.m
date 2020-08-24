function fit_mod8_UCB_3param_nov_Q0_MAP(ID, data_fol)
 
    algo = 'UCB_prior1normal';
    results_dir = strcat(data_fol, '/modelfit/',algo,'/results/');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    param_bounds_Q0 = [1,10];
    param_bounds_gamma = [10^-8,10]; % information bonus
    param_bounds_tau = [10^-8,7]; % inverse temperature
    param_bounds_xi = [10^-8,0.5]; % epsilon greedy
    param_bounds_eta = [0,5];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % settings
    settings = [];
    settings.task.N_games        = 400; 
    settings.task.N_hor          = 2;
    settings.task.Ngames_per_hor = settings.task.N_games / settings.task.N_hor;
    settings.task.N_trees        = 3; 
    settings.opts.TLT            = [];
    settings.funs.decfun         = @softmax;
    settings.funs.valuefun       = @UCB_noveltybonus; 
    settings.funs.priorfun       = [];
    settings.funs.learningfun    = @kalman_filt;
    settings.desc                = ['UCB'];    % description of model (settings, etc)
    settings.params.param_names  = {'Q0' 'gamma'   ''         'tau'      ''      'xi'   ''   'eta' ''};   % is same param name as prev, write ''
    settings.params.lb           = [param_bounds_Q0(1) param_bounds_gamma(1)   param_bounds_gamma(1) param_bounds_tau(1) param_bounds_tau(1) param_bounds_xi(1) param_bounds_xi(1) param_bounds_eta(1) param_bounds_eta(1)];    % lower bound
    settings.params.ub           = [param_bounds_Q0(2) param_bounds_gamma(2)   param_bounds_gamma(2) param_bounds_tau(2) param_bounds_tau(2) param_bounds_xi(2) param_bounds_xi(2) param_bounds_eta(2) param_bounds_eta(2)];    % upper bound

    % get data
    data_dir = strcat(data_fol, '/data/');
    [data,gameIDs] = aggregateData(ID,data_dir);
    
    % prior
    load(strcat(data_fol,'/modelfit/priors/ucb_q0_norm/empirical_prior.mat'),'prior') 

    % fit model    
    modelfunLL = @(x) modelMF_S0fixed_sgm0fixed_eta(x,settings.params.param_names,ID,settings,data,gameIDs);   
    modelfun = @(x) modelMF_S0fixed_sgm0fixed_eta_MAP(x,settings.params.param_names,ID,settings,data,gameIDs, prior);

    % fmincon
    options = optimoptions('fmincon','Display','off');
    a = settings.params.lb;
    b = settings.params.ub;

    mEmatparams = nan(8,9);
    mEmatmle = nan(8,1);
    mEexitflag = nan(8,1);
       
    tic
    for iter=1:8
        xo_fmincon = (b-a).*rand(1,1) + a; % random value in this interval     
        [mEparams, mEMAP, mEexitflag] = fmincon(modelfun,xo_fmincon,[],[],[],[],...
            settings.params.lb,settings.params.ub,[],options);
        mEmatparams(iter,:) = mEparams;
        mEmatMAP(iter,:) = mEMAP;
        mEexitflag(iter,:) = mEexitflag;
    end     
    toc
        
    % tidy up
    mEsubj = ID;
    [mEMAP, ind]= min(mEmatMAP);
    mEparams  = mEmatparams(ind,:);
    mEexitflag = mEexitflag(ind);
    mEprior = prior;
    
    [mEmle, ~, ~] = modelfunLL(mEparams); %find likelihood
    
    if ~exist(results_dir)
        mkdir(results_dir)
    end

    % save
    save_func_data(ID, settings, results_dir, mEparams, mEmle, mEMAP, mEexitflag, mEsubj, [], [], mEmatparams, [], mEprior)
    
end