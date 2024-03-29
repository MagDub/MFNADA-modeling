function fit_hybrid_3param_MAP(ID, optim_algo)

holly = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_gamma = [10^-8,10]; % information bonus
param_bounds_tau = [10^-8,7]; % inverse temperature
param_bounds_w_hyb = [0,1]; % arbitrates between thompson and UCB
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    algo = 'hybrid_MAP';
    n_param = 3;
    
    if holly == 1
        results_dir = strcat('/home/mdubois/data/participant_data/',algo,'/',int2str(n_param), 'params/results/', optim_algo,'/');
    else
        results_dir = strcat('D:\MaggiesFarm\modeling_28_02\participant_data\',algo,'\', int2str(n_param), 'params\results\',optim_algo,'\');
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
    settings.funs.valuefun      = @hybrid; 
    settings.funs.priorfun      = [];
    settings.funs.learningfun   = @kalman_filt;
    settings.desc = ['hybrid'];    % description of model (settings, etc)
    settings.params.param_names = {'gamma' '' 'tau' '' 'w_hyb' ''};   % is same param name as prev, write ''
    settings.params.lb          = [param_bounds_gamma(1) param_bounds_gamma(1) param_bounds_tau(1) param_bounds_tau(1)  param_bounds_w_hyb(1) param_bounds_w_hyb(1)];    % lower bound
    settings.params.ub          = [param_bounds_gamma(2) param_bounds_gamma(2)  param_bounds_tau(2) param_bounds_tau(2)  param_bounds_w_hyb(2) param_bounds_w_hyb(2)];    % upper bound
%     settings.params.param_names = {'gamma'              'tau'    'xi'     'sgm0'     'w_hyb' };   % is same param name as prev, write ''
%     settings.params.lb          = [param_bounds_gamma(1)    param_bounds_tau(1) param_bounds_xi(1) param_bounds_sgm0(1)    param_bounds_w_hyb(1) ];    % lower bound
%     settings.params.ub          = [param_bounds_gamma(2)    param_bounds_tau(2) param_bounds_xi(2)   param_bounds_sgm0(2)     param_bounds_w_hyb(2) ];    % upper bound
%   

    %% get data
    data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\';
    [data,gameIDs] = aggregateData(ID,data_dir);

    %% fit model
    
    modelfunLL = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed(x,settings.params.param_names,ID,settings,data,gameIDs);
    modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed_MAP_hybrid(x,settings.params.param_names,ID,settings,data,gameIDs);
    
    if strcmp(optim_algo,'fmincon')
        %%%%%%%% fmincon %%%%%%%%
        options = optimoptions('fmincon','Display','off');
        a = settings.params.lb;
        b = settings.params.ub;
        tic
        
       mEmatparams = nan(8,6);
       mEmatmle = nan(8,1);
       mEexitflag = nan(8,1);
       
            parfor iter=1:8%:20%:100%:2 %:3%:20 %:100
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
        
    elseif strcmp(optim_algo,'genetic')    
        
        %%%%% Genetic Algorithm %%%%%
        opts_GA = gaoptimset('Generations',300,'UseParallel','never','TolFun',1e-5,'CrossoverFcn',@crossoverheuristic,'EliteCount',4);
        tic
        [mEparams, mEmle, mEexitflag] = ga(modelfun,length(settings.params.lb),[],[],[],[],settings.params.lb,settings.params.ub,[],[],opts_GA);
        fprintf( 'done.\n')
        toc
    
    end

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
    save_func_data(ID, settings, results_dir, mEparams, nLogL, mEMAP, mEexitflag, mEsubj, [], []);
    
    disp(strcat(int2str(iter_selected), 32,'fmincon better iterations in participant: ',int2str(ID)))

end