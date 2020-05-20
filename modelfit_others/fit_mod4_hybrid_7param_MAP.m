function fit_mod4_hybrid_7param_MAP(ID)

holly = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_Q0 = [1,10];
param_bounds_gamma = [10^-8,10]; % information bonus
param_bounds_tau = [10^-8,7]; % inverse temperature
param_bounds_sgm0 = [0.01,6];        
param_bounds_xi = [10^-8,0.5];  % epsilon greedy
param_bounds_w_hyb = [0,1]; % arbitrates between thompson and UCB
param_bounds_eta = [0,5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    algo = 'hybrid_noveltybonus_both_2nov_MAP';
    n_param = 5;
    
    if holly == 1
        results_dir = strcat('/home/mdubois/data/participant_data/',algo,'/',int2str(n_param), 'params/results/');
    else
        results_dir = strcat('D:\MaggiesFarm\modeling_28_02\participant_data\',algo,'\', int2str(n_param), 'params\results\');
    end
        
    %% settings
    settings = [];
    settings.task.N_games = 400;
    settings.task.N_hor = 2;
    settings.task.Ngames_per_hor = settings.task.N_games / settings.task.N_hor;
    settings.task.N_trees = 3; % Changed
    settings.opts.TLT       = [];
    settings.funs.decfun        = @softmax;
    settings.funs.valuefun      = @hybrid_noveltybonus_onboth; 
    settings.funs.priorfun      = [];
    settings.funs.learningfun   = @kalman_filt;
    settings.desc = ['hybrid'];    % description of model (settings, etc)
    settings.params.param_names = {'Q0' 'gamma' '' 'tau' '' 'xi'  '' 'sgm0' '' 'eta' '' 'w_hyb'};   % is same param name as prev, write ''
    settings.params.lb          = [param_bounds_Q0(1) param_bounds_gamma(1) param_bounds_gamma(1) param_bounds_tau(1) param_bounds_tau(1) param_bounds_xi(1) param_bounds_xi(1) param_bounds_sgm0(1) param_bounds_sgm0(1)  param_bounds_eta(1) param_bounds_eta(1) param_bounds_w_hyb(1)];    % lower bound
    settings.params.ub          = [param_bounds_Q0(2) param_bounds_gamma(2) param_bounds_gamma(2) param_bounds_tau(2) param_bounds_tau(2) param_bounds_xi(2) param_bounds_xi(2) param_bounds_sgm0(2) param_bounds_sgm0(2)  param_bounds_eta(2) param_bounds_eta(2) param_bounds_w_hyb(2)];    % upper bound


    %% get data
    data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\';
    [data,gameIDs] = aggregateData(ID,data_dir);

    %% fit model
    
    modelfunLL = @(x) modelMF_S0fixed_eta(x,settings.params.param_names,ID,settings,data,gameIDs);
    modelfun = @(x) modelMF_S0fixed_eta_MAP(x,settings.params.param_names,ID,settings,data,gameIDs);
    
        %%%%%%%% fmincon %%%%%%%%
        options = optimoptions('fmincon','Display','off');
        a = settings.params.lb;
        b = settings.params.ub;
        tic

       mEmatparams = nan(8,12);
       mEmatmle = nan(8,1);
       mEexitflag = nan(8,1);

            parfor iter=1:8
                disp(iter)
            % starting point
                xo_fmincon = (b-a).*rand(1,1) + a; % random value in this interval     
                [mEparams, mEMAP, mEexitflag] = fmincon(modelfun,...
                    xo_fmincon,[],[],[],[],...
                    settings.params.lb,settings.params.ub,...
                    [],options);
                mEmatparams(iter,:) = mEparams;
                mEmatMAP(iter,:) = mEMAP;
                mEexitflag(iter,:) = mEexitflag;
            end
        toc
        

    % tidy up
    mEsubj = ID;
    
    
    %mEmatmle
    [mEMAP, ind]= min(mEmatMAP);
    mEparams  = mEmatparams(ind,:);
    mEexitflag = mEexitflag(ind);
    
    [nLogL, ~, ~] = modelfunLL(mEparams); %find likelihood 
    
    %%
     %HeY = [] %NumHessianYtest(modelfunLL,mEparams);
    
    if ~exist(results_dir)
        mkdir(results_dir)
    end

    % save
    save_func_data(ID, settings, results_dir, mEparams, nLogL, mEMAP, mEexitflag, mEsubj, [], [], mEmatparams, mEmatmle);
    
end