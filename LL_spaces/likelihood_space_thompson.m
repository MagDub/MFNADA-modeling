
for ID = 501:560

    n_per_dim = 25;
    
    % import fmincon data of participant
    fmincon_data = load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson\3params\results\fmincon\res_thompson_',int2str(ID),'_results.mat'));
    fmincon_data_sgm0 = fmincon_data.mEparams(1);
    fmincon_data_Q0 = fmincon_data.mEparams(2);
    fmincon_data_xi = fmincon_data.mEparams(3);
    
    % import GA data of participant
    genetic_data = load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson\3params\results\genetic\res_thompson_',int2str(ID),'_results.mat'));
    genetic_data_sgm0 = genetic_data.mEparams(1);
    genetic_data_Q0 = genetic_data.mEparams(2);
    genetic_data_xi = genetic_data.mEparams(3);
    
    sgm0_both=sort([fmincon_data_sgm0 genetic_data_sgm0]);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    param_bounds_xi = [0.01,0.2];
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
    settings.params.lb          = [param_bounds_sgm0(1)   param_bounds_Q0(1)  param_bounds_xi(1) ];    % lower bound
    settings.params.ub          = [param_bounds_sgm0(2)    param_bounds_Q0(2)  param_bounds_xi(2) ];    % upper bound

    %% get data
    data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\';
    [data,gameIDs] = aggregateData(ID,data_dir);

    %% compute likelihoods
    modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed_lapse(x,settings.params.param_names,ID,settings,data,gameIDs);   

    vec_sgm0 = linspace(param_bounds_sgm0(1),param_bounds_sgm0(2),n_per_dim);
    vec_Q0 = linspace(param_bounds_Q0(1),param_bounds_Q0(2),n_per_dim);
    vec_xi = linspace(param_bounds_xi(1),param_bounds_xi(2),n_per_dim);

    for i_sgm0=1:size(vec_sgm0,2)
        for i_Q0=1:size(vec_Q0,2)
            for i_xi=1:size(vec_xi,2)
                mEparams = [vec_sgm0(i_sgm0), vec_Q0(i_Q0), vec_xi(i_xi)];
                [nLogL, ~, ~] = modelfun(mEparams);
                nlogLmat(i_xi,i_Q0,i_sgm0) = nLogL;
            end
        end
    end

    nlogLmat_mean_sgm0=mean(nlogLmat,3);
    
    % plot
    [xi_mat, Q0_mat]= meshgrid(vec_xi,vec_Q0);
    surf(xi_mat,Q0_mat,nlogLmat_mean_sgm0); hold on;
    z_line = min(min(nlogLmat_mean_sgm0)):max(max(nlogLmat_mean_sgm0));
    
    plot3(fmincon_data_xi*ones(1,size(z_line,2)),fmincon_data_Q0*ones(1,size(z_line,2)), min(min(nlogLmat_mean_sgm0)):max(max(nlogLmat_mean_sgm0)),'r', 'Linewidth', 2); hold on;
    text(fmincon_data_xi,fmincon_data_Q0,max(max(nlogLmat_mean_sgm0)),'fmincon \rightarrow ', 'HorizontalAlignment','right')
    
    plot3(genetic_data_xi*ones(1,size(z_line,2)),genetic_data_Q0*ones(1,size(z_line,2)), min(min(nlogLmat_mean_sgm0)):max(max(nlogLmat_mean_sgm0)),'g', 'Linewidth', 2)
    text(genetic_data_xi,genetic_data_Q0,max(max(nlogLmat_mean_sgm0)),'\leftarrow genetic', 'HorizontalAlignment','left')
    
%%%%%%
    [Z_mat, Y_mat]= meshgrid(vec_xi,vec_Q0);
    surf(Z_mat,Y_mat,nlogLmat_mean_sgm0)

    xlabel('xi')
    ylabel('Q0')
    zlabel('nlogL')
    title(strcat('Averaged for sgm0=',num2str(sgm0_both(1)), ':', num2str(sgm0_both(2))))

    file_name = strcat('D:\MaggiesFarm\modeling_28_02\participant_data\LLsurfaces\thompson\');

    if ~exist(file_name)
        mkdir(file_name)
    end

    savefig(strcat(file_name, 'participant_', int2str(ID)));
    
    close all;
    
end





