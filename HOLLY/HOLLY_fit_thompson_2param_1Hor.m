function HOLLY_fit_thompson_2param_1Hor(ID, optim_algo)

holly = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_sgm0 = [0.01,6];
param_bounds_Q0 = [2,10]; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    algo = 'thompson';
    n_param = 2;
    
    if holly == 1
        results_dir = strcat('/home/mdubois/data/participant_data/',algo,'/',int2str(n_param), 'params_1Hor/results/', optim_algo,'/');
    else
        results_dir = strcat('D:\MaggiesFarm\modeling_28_02\participant_data\',algo,'\', int2str(n_param), 'params_1Hor\results\',optim_algo,'\');
    end
    
    iter_selected = 0;

    % settings
    settings = [];
    settings.task.N_games = 400;
    settings.task.N_hor = 2;
    settings.task.Ngames_per_hor = settings.task.N_games / settings.task.N_hor;
    settings.task.N_trees = 3;
    settings.opts.TLT       = [];
    settings.funs.decfun        = @softmax;
    settings.funs.valuefun      = @mvnorm_Thompson; %@hybrid; % @UCB; % 
    settings.funs.priorfun      = [];
    settings.funs.learningfun   = @kalman_filt;
    settings.desc = ['thompson'];    % description of model (settings, etc)
    settings.params.param_names = {'sgm0', 'Q0'};   % is same param name as prev, write ''
    settings.params.lb          = [param_bounds_sgm0(1)  param_bounds_Q0(1)];    % lower bound
    settings.params.ub          = [param_bounds_sgm0(2)  param_bounds_Q0(2)];    % upper bound


    %% get data
    data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\';
    [data,gameIDs] = aggregateData(ID,data_dir);

    %% fit model
    
    modelfun = @(x) modelMF_S0fixed(x,settings.params.param_names,ID,settings,data,gameIDs);
    
    if strcmp(optim_algo,'fmincon')
        %%%%%%%% fmincon %%%%%%%%
        options = optimoptions('fmincon','Display','off');
        a = settings.params.lb;
        b = settings.params.ub;
        tic
        
       mEmatparams = nan(8,2);
       mEmatmle = nan(8,1);
       mEexitflag = nan(8,1);
       
            parfor iter=1:8%:20%:100%:2 %:3%:20 %:100
                disp(iter)
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
    %[nLogL, mo, logL] = modelfun(mEparams);
    
    %mEmatmle
    [mEmle, ind]= min(mEmatmle);
    mEparams  = mEmatparams(ind,:)
    mEexitflag = mEexitflag(ind);
    
    %%
     
    %%%% Calculate the Hessian %%%%
     % x is the parameter estimate 
%      x = mEparams; 
%      % f is the posterior log probability of parameters, which is basically: log likelihood + prior       
%      modelfun_LL = @(x) modelMF_S0fixed_LL(x,settings.params.param_names,ID,settings,data,gameIDs);  
%      %f = modelfun_LL;  %+ param(k).logpdf(x(:,k)); either use the logpdf of beta / normal distrib or don't put anything, which sous-entend a uniform distribution 
%      %He = [];
%      %He = NumHessian(f,x);   
     HeY = NumHessianYtest(modelfun,mEparams); 
     
%%
    if ~exist(results_dir)
        mkdir(results_dir)
    end

    % save
    %save_func_data(ID, settings, results_dir, mEparams, mEmle, mEexitflag, mEsubj, [], HeY, []);
    save_func_data(ID, settings, results_dir, mEparams, mEmle,[], mEexitflag, mEsubj, [], HeY)

    disp(strcat(int2str(iter_selected), 32,'fmincon better iterations in participant: ',int2str(ID)))

end