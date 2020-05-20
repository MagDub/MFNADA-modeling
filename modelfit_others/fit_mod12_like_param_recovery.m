function fit_mod12_like_param_recovery(ID)

addpath('D:\MaggiesFarm\modeling_28_02')

holly = 0;

% like: sim_refit_thompson_3param_noveltybonus_parhor_MAP

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_sgm0 = [0.01,6];
param_bounds_Q0 = [1,10]; 
param_bounds_xi = [10^-8,0.5];  
param_bounds_eta = [0,5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    algo = 'thompson_like_param_recovery_test';
    
    if holly == 1
        results_dir = strcat('/home/mdubois/data/participant_data/',algo,'/results/');
    else
        results_dir = strcat('D:\MaggiesFarm\modeling_28_02\participant_data\',algo,'\results\');
    end
    
    % settings
    settings = [];
    settings.task.N_games = 400;
    settings.task.N_hor = 2;
    settings.task.Ngames_per_hor = settings.task.N_games / settings.task.N_hor;
    settings.task.N_trees = 3;
    settings.opts.TLT       = [];
    settings.funs.decfun        = @softmax;
    settings.funs.valuefun      = @mvnorm_Thompson_noveltybonus_new; 
    settings.funs.priorfun      = [];
    settings.funs.learningfun   = @kalman_filt;
    settings.desc = ['thompson'];    % description of model (settings, etc)
    settings.params.param_names = {'sgm0', '', 'Q0','xi', '', 'eta', ''};   % is same param name as prev, write ''
    settings.params.lb          = [param_bounds_sgm0(1) param_bounds_sgm0(1)  param_bounds_Q0(1)  param_bounds_xi(1) param_bounds_xi(1) param_bounds_eta(1) param_bounds_eta(1)];    % lower bound
    settings.params.ub          = [param_bounds_sgm0(2) param_bounds_sgm0(2)  param_bounds_Q0(2)  param_bounds_xi(2) param_bounds_xi(2) param_bounds_eta(2) param_bounds_eta(2)];    % upper bound


    %% get data
    data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\';
    [data,gameIDs] = aggregateData(ID,data_dir);
    
    %% prior
    if holly == 1
        load('/home/mdubois/data/participant_data/priors/thompson_4params_sgm0_xi_eta_uni/empirical_prior.mat'); %from generate_empirical_priors.mend
    else
        load('D:/MaggiesFarm/modeling_28_02/participant_data/priors/thompson_4params_sgm0_xi_eta_uni/empirical_prior.mat','prior') %from generate_empirical_priors.mend
    end

    %% fit model
        
    modelfunLL = @(x) modelMF_S0fixed_eta_2sgm0(x,settings.params.param_names,ID,settings,data,gameIDs);
    modelfun = @(x) modelMF_S0fixed_eta_thomp4param_MAP_2sgm0(x,settings.params.param_names,ID,settings,data,gameIDs, prior);
    
        %%%%%%%% fmincon %%%%%%%%
        options = optimoptions('fmincon','Display','off');
        a = settings.params.lb;
        b = settings.params.ub;
        tic
        
       mEmatparams = nan(8,7);
       mEmatmle = nan(8,1);
       mEexitflag = nan(8,1);
       
            for iter=1:8
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
    save_func_data(ID, settings, results_dir, mEparams, mEmle, mEMAP, mEexitflag, mEsubj, [], [], mEmatparams, [], prior)

end