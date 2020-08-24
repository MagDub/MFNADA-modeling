function fit_mod12_AB(ID, data_fol)

    algo = 'thompson_AB';
    results_dir = strcat(data_fol, '/modelfit/',algo,'/results/');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    param_bounds_Q0 = [1,10]; 
    param_bounds_sgm0 = [0.01,6];
    param_bounds_xi = [10^-8,0.5];  
    param_bounds_eta = [0,5];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % settings
    settings = [];
    settings.task.N_games           = 100;
    settings.task.N_hor             = 2;
    settings.task.Ngames_per_hor    = settings.task.N_games / settings.task.N_hor;
    settings.task.N_trees           = 3;
    settings.opts.TLT               = [];
    settings.funs.decfun            = @softmax;
    settings.funs.valuefun          = @mvnorm_Thompson_noveltybonus_new; 
    settings.funs.priorfun          = [];
    settings.funs.learningfun       = @kalman_filt;
    settings.desc                   = ['thompson'];    
    settings.params.param_names     = {'sgm0', '', 'Q0','xi', '', 'eta', ''}; 
    settings.params.lb              = [param_bounds_sgm0(1) param_bounds_sgm0(1)  param_bounds_Q0(1)  param_bounds_xi(1) param_bounds_xi(1) param_bounds_eta(1) param_bounds_eta(1)];    
    settings.params.ub              = [param_bounds_sgm0(2) param_bounds_sgm0(2)  param_bounds_Q0(2)  param_bounds_xi(2) param_bounds_xi(2) param_bounds_eta(2) param_bounds_eta(2)];    

    % get data
    data_dir = strcat(data_fol, '/data/');
    [data,gameIDs] = aggregateData(ID,data_dir);
    
    % Select only AB trials
    tmp_unshown = nan(1,size(data,2));
    
    for i_ = 1:size(data,2)    
        tmp_unshown(1,i_) = data(1,i_).unshown_tree;
    end
    
    id_keep = find(tmp_unshown==4); % when unshown tree is D
    
    gameIDs_new = nan(2,50);
    for i = 1:size(id_keep,2) 
        id_ = id_keep(i);
        data_new(1,i) = data(1,id_);
        data_new(2,i) = data(2,id_);
        gameIDs_new(1,i) = gameIDs(1,id_);
        gameIDs_new(2,i) = gameIDs(2,id_);
    end    
    
    % prior
    load(strcat(data_fol,'/modelfit/priors/thompson_q0_norm/empirical_prior.mat'),'prior') 

    % fit model
    modelfunLL = @(x) modelMF_S0fixed_eta_2sgm0(x,settings.params.param_names,ID,settings,data_new,gameIDs_new);
    modelfun = @(x) modelMF_S0fixed_eta_thomp4param_MAP_2sgm0(x,settings.params.param_names,ID,settings,data_new,gameIDs_new, prior);

    % fmincon
    options = optimoptions('fmincon','Display','off');
    a = settings.params.lb;
    b = settings.params.ub;

    mEmatparams = nan(8,7);
    mEmatmle = nan(8,1);
    mEexitflag = nan(8,1);

    tic
    parfor iter=1:8
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