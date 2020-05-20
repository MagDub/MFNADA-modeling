
%ID = 501;
    
function likelihood_space_thompson_const_sgm0_fmincon(ID)
%for ID = 501:502 % 560

    holly = 1;
    
    n_per_dim = 20;
    
    % import fmincon data of participant
    if holly ==0
        fmincon_data = load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson\3params\results\fmincon\res_thompson_',int2str(ID),'_results.mat'));
    elseif holly == 1
        fmincon_data = load(strcat('/home/mdubois/data/participant_data/thompson/3params/results/fmincon/res_thompson_',int2str(ID),'_results.mat'));
    end
    fmincon_data_sgm0 = fmincon_data.mEparams(1);
    fmincon_data_Q0 = fmincon_data.mEparams(2);
    fmincon_data_xi = fmincon_data.mEparams(3);
    
    sgm0_both=sort([fmincon_data_sgm0]);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    param_bounds_xi = [0.01,0.5];
    param_bounds_sgm0 = sgm0_both; 
    param_bounds_Q0 = [0.1,10]; 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    %% Create inp_params
    param_names = {'sgm0','Q0','xi'};

    grd = [];
    grd.dim{1} = linspace(param_bounds_sgm0(1),param_bounds_sgm0(2),n_per_dim);
    grd.dim{2} = linspace(param_bounds_Q0(1),param_bounds_Q0(2),n_per_dim);
    grd.dim{3} = linspace(param_bounds_xi(1),param_bounds_xi(2),n_per_dim);

    [x1, x2, x3] = ndgrid(grd.dim{1},grd.dim{2},grd.dim{3});
    inp_params = single([x1(:) x2(:) x3(:)]);

    %% settings
    settings = [];
    settings.task.N_games = 200;
    settings.task.N_hor = 1;
    settings.task.Ngames_per_hor = settings.task.N_games / settings.task.N_hor;
    settings.task.N_trees = 3;
    settings.opts.TLT       = [];
    settings.funs.decfun        = @softmax;
    settings.funs.valuefun      = @mvnorm_Thompson; %@hybrid; % @UCB; % 
    settings.funs.priorfun      = [];
    settings.funs.learningfun   = @kalman_filt;
    settings.desc = ['thompson_' int2str(ID)];    % description of model (settings, etc)
    settings.params.param_names = {'sgm0','Q0','xi'};   % is same param name as prev, write ''
    settings.params.lb          = [param_bounds_sgm0(1)    param_bounds_Q0(1)  param_bounds_xi(1)];    % lower bound
    settings.params.ub          = [param_bounds_sgm0(2)    param_bounds_Q0(2)  param_bounds_xi(2)];    % upper bound

    %% get data
    if holly == 0
        data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\';
    elseif holly == 1
        data_dir = '/data/mdubois/MaggiesFarm/data/';
    end
    
    [data,gameIDs] = aggregateData(ID,data_dir);

    %% compute likelihoods
    modelfun = @(x) modelMF_S0fixed(x,settings.params.param_names,ID,settings,data,gameIDs);   

    vec_sgm0 = linspace(param_bounds_sgm0(1),param_bounds_sgm0(2),n_per_dim);
    vec_Q0 = linspace(param_bounds_Q0(1),param_bounds_Q0(2),n_per_dim);
    vec_xi = linspace(param_bounds_xi(1),param_bounds_xi(2),n_per_dim);
       
    for i_xi=1:size(vec_xi,2)
        for i_Q0=1:size(vec_Q0,2) 
            for i_sgm0=1:size(vec_sgm0,2)                     
                mEparams = [vec_sgm0(i_sgm0), vec_Q0(i_Q0), vec_xi(i_xi)];
                [nLogL, ~, ~] = modelfun(mEparams);
                nlogLmat_cst_sgm0(i_xi,i_Q0,i_sgm0) = nLogL;
            end
        end
    end    
    
    struct_cst_sgm0.nlogLmat = nlogLmat_cst_sgm0;
    struct_cst_sgm0.param_bounds_xi = param_bounds_xi;
    struct_cst_sgm0.param_bounds_Q0 = param_bounds_Q0;
    struct_cst_sgm0.param_bounds_sgm0 = param_bounds_sgm0;
    struct_cst_sgm0.n_per_dim = n_per_dim;
    struct_cst_sgm0.fmincon_data_sgm0 = fmincon_data_sgm0;
    struct_cst_sgm0.fmincon_data_Q0 = fmincon_data_Q0;
    struct_cst_sgm0.fmincon_data_xi = fmincon_data_xi;
    
    if holly == 0
        save(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\LLsurfaces\thompson\participant_', int2str(ID), '_struct_cst_sgm0.mat'),'-struct', 'struct_cst_sgm0');
    elseif holly == 1
        save(strcat('/home/mdubois/data/participant_data/LLsurfaces/thompson/participant_', int2str(ID), '_struct_cst_sgm0.mat'),'-struct', 'struct_cst_sgm0');
    end
    
end






