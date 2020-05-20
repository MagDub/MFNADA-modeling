
function likelihood_space_UCB_const_gamma(ID)
%for ID = 502:560
    n_per_dim = 25;
    
    holly = 1;
    
    % import fmincon data of participant
    if holly ==0
        fmincon_data = load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\3params\results\fmincon\res_UCB_',int2str(ID),'_results.mat'));
    elseif holly == 1
        fmincon_data = load(strcat('/home/mdubois/data/participant_data/UCB/3params/results/fmincon/res_UCB_',int2str(ID),'_results.mat'));
    end
    fmincon_data_gamma = fmincon_data.mEparams(1);
    fmincon_data_tau = fmincon_data.mEparams(2);
    fmincon_data_xi = fmincon_data.mEparams(3);
    
    % import GA data of participant
    if holly ==0
        genetic_data = load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\3params\results\genetic\res_UCB_',int2str(ID),'_results.mat'));
    elseif holly == 1
        genetic_data = load(strcat('/home/mdubois/data/participant_data/UCB/3params/results/genetic/res_UCB_',int2str(ID),'_results.mat'));
    end
    genetic_data_gamma = genetic_data.mEparams(1);
    genetic_data_tau = genetic_data.mEparams(2);
    genetic_data_xi = genetic_data.mEparams(3);
    
    gamma_both=sort([fmincon_data_gamma genetic_data_gamma]);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    param_bounds_gamma = gamma_both; % information bonus
    param_bounds_tau = [0.1,7]; % inverse temperature
    param_bounds_xi = [0,0.8]; % epsilon greedy
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    %% Create inp_params
    param_names = {'gamma','tau', 'xi'};

    grd = [];
    grd.dim{1} = linspace(param_bounds_gamma(1),param_bounds_gamma(2),n_per_dim);
    grd.dim{2} = linspace(param_bounds_tau(1),param_bounds_tau(2),n_per_dim);
    grd.dim{3} = linspace(param_bounds_xi(1),param_bounds_xi(2),n_per_dim);

    [x1, x2, x3] = ndgrid(grd.dim{1},grd.dim{2},grd.dim{3});
    inp_params = single([x1(:) x2(:) x3(:)]);
    
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
    settings.desc = ['sim_UCB_' int2str(ID)];    % description of model (settings, etc)
    settings.params.param_names = {'gamma',                   'tau'         'xi'};   % is same param name as prev, write ''
    settings.params.lb          = [param_bounds_gamma(1)    param_bounds_tau(1) param_bounds_xi(1)];    % lower bound
    settings.params.ub          = [param_bounds_gamma(2)    param_bounds_tau(2) param_bounds_xi(2)];    % upper bound

    %% get data
    if holly == 0
        data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\';
    elseif holly == 1
        data_dir = '/data/mdubois/MaggiesFarm/data/';
    end
    
    [data,gameIDs] = aggregateData(ID,data_dir);

    %% compute likelihoods
    modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed_lapse(x,settings.params.param_names,ID,settings,data,gameIDs);   

    vec_gamma = linspace(param_bounds_gamma(1),param_bounds_gamma(2),n_per_dim);
    vec_tau = linspace(param_bounds_tau(1),param_bounds_tau(2),n_per_dim);
    vec_xi = linspace(param_bounds_xi(1),param_bounds_xi(2),n_per_dim);

    for i_gamma=1:size(vec_gamma,2)
        for i_tau=1:size(vec_tau,2)
            for i_xi=1:size(vec_xi,2)
                mEparams = [vec_gamma(i_gamma), vec_tau(i_tau), vec_xi(i_xi)]; 
                [nLogL, ~, ~] = modelfun(mEparams);
                nlogLmat_cst_gamma(i_tau,i_xi,i_gamma) = nLogL; 
            end
        end
    end
   
    struct_cst_gamma.nlogLmat = nlogLmat_cst_gamma;
    struct_cst_gamma.param_bounds_gamma = param_bounds_gamma;
    struct_cst_gamma.param_bounds_tau = param_bounds_tau;
    struct_cst_gamma.param_bounds_xi = param_bounds_xi;
    struct_cst_gamma.n_per_dim = n_per_dim;
    struct_cst_gamma.fmincon_data_gamma = fmincon_data_gamma;
    struct_cst_gamma.fmincon_data_tau = fmincon_data_tau;
    struct_cst_gamma.fmincon_data_xi = fmincon_data_xi;
    struct_cst_gamma.genetic_data_gamma = genetic_data_gamma;
    struct_cst_gamma.genetic_data_tau = genetic_data_tau;
    struct_cst_gamma.genetic_data_xi = genetic_data_xi;
    
    if holly == 0
        save(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\LLsurfaces\UCB\participant_', int2str(ID), '_struct_cst_gamma.mat'),'-struct', 'struct_cst_gamma');
    elseif holly == 1
        save(strcat('/home/mdubois/data/participant_data/LLsurfaces/UCB/participant_', int2str(ID), '_struct_cst_gamma.mat'),'-struct', 'struct_cst_gamma');
    end

%       nlogLmat_mean_gamma=mean(nlogLmat,3);

%     % plot
%     [xi_mat, tau_mat]= meshgrid(vec_xi,vec_tau);
%     surf(xi_mat,tau_mat,nlogLmat_mean_gamma); hold on;
%     z_line = min(min(nlogLmat_mean_gamma)):max(max(nlogLmat_mean_gamma));
%     
%     plot3(fmincon_data_xi*ones(1,size(z_line,2)),fmincon_data_tau*ones(1,size(z_line,2)), min(min(nlogLmat_mean_gamma)):max(max(nlogLmat_mean_gamma)),'r', 'Linewidth', 2); hold on;
%     text(fmincon_data_xi,fmincon_data_tau,max(max(nlogLmat_mean_gamma)),'fmincon \rightarrow ', 'HorizontalAlignment','right')
%     
%     plot3(genetic_data_xi*ones(1,size(z_line,2)),genetic_data_tau*ones(1,size(z_line,2)), min(min(nlogLmat_mean_gamma)):max(max(nlogLmat_mean_gamma)),'g', 'Linewidth', 2)
%     text(genetic_data_xi,genetic_data_tau,max(max(nlogLmat_mean_gamma)),'\leftarrow genetic', 'HorizontalAlignment','left')
%       
%     xlabel('xi')
%     ylabel('tau')
%     zlabel('nlogL')
%     title(strcat('Averaged for gamma=',num2str(gamma_both(1)), ':', num2str(gamma_both(2))))
% 
%     file_name = strcat('D:\MaggiesFarm\modeling_28_02\participant_data\LLsurfaces\UCB\');
% 
%     if ~exist(file_name)
%         mkdir(file_name)
%     end
%       
%     savefig(strcat(file_name, 'participant_', int2str(ID)));
%     
%     close all;
    
end





