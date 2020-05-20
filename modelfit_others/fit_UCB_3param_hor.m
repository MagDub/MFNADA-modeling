%function fit_UCB_3param_hor(ID, optim_algo)
ID = 501;
optim_algo = 'fmincon';

holly = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_gamma = [0.01,5]; % information bonus
param_bounds_tau = [0.1,7]; % inverse temperature
param_bounds_xi = [0,0.8]; % epsilon greedy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    algo = 'UCB';
    n_param = 3;
    
    if holly == 1
        results_dir = strcat('/home/mdubois/data/participant_data/',algo,'/',int2str(n_param), 'params/results/', optim_algo,'/');
    else
        results_dir = strcat('D:\MaggiesFarm\modeling_28_02\participant_data\',algo,'\', int2str(n_param), 'params\results\',optim_algo,'\');
    end
    
    iter_selected = 0;
    
    %% settings
    settings = [];
    settings.task.N_games = 200;
    settings.task.N_hor = 1;
    settings.task.Ngames_per_hor = settings.task.N_games / settings.task.N_hor;
    settings.task.N_trees = 3; % Changed
    settings.opts.TLT       = [];
    settings.funs.decfun        = @softmax;
    settings.funs.valuefun      = @UCB; 
    settings.funs.priorfun      = [];
    settings.funs.learningfun   = @kalman_filt;
    settings.desc = ['UCB'];    % description of model (settings, etc)
    settings.params.param_names = {'gamma',                   'tau'         'xi'};   % is same param name as prev, write ''
    settings.params.lb          = [param_bounds_gamma(1)    param_bounds_tau(1) param_bounds_xi(1)];    % lower bound
    settings.params.ub          = [param_bounds_gamma(2)    param_bounds_tau(2) param_bounds_xi(2)];    % upper bound
    
    %% get data
    data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\';
    [tmpdata,gameIDs] = aggregateData(ID,data_dir);
    
    data = tmpdata(1,:);
    
%     data(1,:) = short horizon
%     data(2,:) = long horizon

    %% fit model
    
    modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed_lapse_hor(x,settings.params.param_names,ID,settings,data,gameIDs);   
    
    if strcmp(optim_algo,'fmincon')
        %%%%%%%% fmincon %%%%%%%%
        options = optimoptions('fmincon','Display','off');
        a = settings.params.lb;
        b = settings.params.ub;
        tic
            for iter=1:20%00               
            % starting point
            xo_fmincon = (b-a).*rand(1,1) + a; % random value in this interval     
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
        toc
        
    elseif strcmp(optim_algo,'genetic')    
        
        %%%%% Genetic Algorithm %%%%%
        opts_GA = gaoptimset('Generations',300,'UseParallel','never','TolFun',1e-5,'CrossoverFcn',@crossoverheuristic,'EliteCount',4);
        tic
        [mEparams, mEmle, mEexitflag] = ga(modelfun,length(settings.params.lb),[],[],[],[],settings.params.lb,settings.params.ub,[],[],opts_GA);
        fprintf( 'done.\n')
        toc
    
    end

    %% tidy up  
    mEsubj = ID;
    [nLogL, mo, logL] = modelfun(mEparams);
    
    if ~exist(results_dir)
        mkdir(results_dir)
    end

    % save
    save_func_data(ID, settings, results_dir, mEparams, mEmle, mEexitflag, mEsubj);

    disp(strcat(int2str(iter_selected), 32,'fmincon better iterations in participant: ',int2str(ID)))

%end