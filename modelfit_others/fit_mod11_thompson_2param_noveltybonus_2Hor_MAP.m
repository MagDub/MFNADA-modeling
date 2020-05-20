function fit_mod11_thompson_2param_noveltybonus_2Hor_MAP(ID)

holly = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_sgm0 = [0.01,6];
param_bounds_Q0 = [1,10]; 
param_bounds_eta = [0,5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    algo = 'thompson_noveltybonus_2nov_MAP';
    n_param = 2;
    
    if holly == 1
        results_dir = strcat('/home/mdubois/data/participant_data/',algo,'/',int2str(n_param), 'params_2Hor_Q01_2sgm0_xi_eta_uni/results/');
    else
        results_dir = strcat('D:\MaggiesFarm\modeling_28_02\participant_data\',algo,'\', int2str(n_param), 'params_2Hor_Q01_2sgm0_xi_eta_uni\results\');
    end
    
    % settings
    settings = [];
    settings.task.N_games = 400;
    settings.task.N_hor = 2;
    settings.task.Ngames_per_hor = settings.task.N_games / settings.task.N_hor;
    settings.task.N_trees = 3;
    settings.opts.TLT       = [];
    settings.funs.decfun        = @softmax;
    settings.funs.valuefun      = @mvnorm_Thompson_noveltybonus_new; %@hybrid; % @UCB; % 
    settings.funs.priorfun      = [];
    settings.funs.learningfun   = @kalman_filt;
    settings.desc = ['thompson'];    % description of model (settings, etc)
    settings.params.param_names = {'sgm0', '', 'Q0','eta', ''};   % is same param name as prev, write ''
    settings.params.lb          = [param_bounds_sgm0(1) param_bounds_sgm0(1)  param_bounds_Q0(1) param_bounds_eta(1) param_bounds_eta(1)];    % lower bound
    settings.params.ub          = [param_bounds_sgm0(2) param_bounds_sgm0(2)  param_bounds_Q0(2) param_bounds_eta(2) param_bounds_eta(2)];    % upper bound


    %% get data
    data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\';
    [data,gameIDs] = aggregateData(ID,data_dir);

    %% fit model
        
    modelfunLL = @(x) modelMF_S0fixed_eta(x,settings.params.param_names,ID,settings,data,gameIDs);
    modelfun = @(x) modelMF_S0fixed_eta_thomp3param_MAP_2sgm0(x,settings.params.param_names,ID,settings,data,gameIDs);
    
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
    
    [mEmle, ~, ~] = modelfunLL(mEparams); %find likelihood 
     
%%
    if ~exist(results_dir)
        mkdir(results_dir)
    end

    % save
    save_func_data(ID, settings, results_dir, mEparams, mEmle, mEMAP, mEexitflag, mEsubj, [], [], mEmatparams, [])

end