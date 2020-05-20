
for ID = 501:560 %1:560
    
    figure()

%% gamma is constant

    tmp=load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\LLsurfaces\UCB\structures\participant_',int2str(ID),'_struct_cst_gamma.mat'));
    
    tmp.vec_gamma = linspace(tmp.param_bounds_gamma(1),tmp.param_bounds_gamma(2),tmp.n_per_dim);
    tmp.vec_tau = linspace(tmp.param_bounds_tau(1),tmp.param_bounds_tau(2),tmp.n_per_dim);
    tmp.vec_xi = linspace(tmp.param_bounds_xi(1),tmp.param_bounds_xi(2),tmp.n_per_dim);

    nlogLmat_mean_cst=mean(tmp.nlogLmat,3);
    
    % ADDED (if not found LL does not match with the one on the graph)
    %nlogLmat_mean_cst = nlogLmat_mean_cst';
    
    paramconst_both=sort([tmp.fmincon_data_gamma tmp.genetic_data_gamma]);
    
    plot_LL_surface(tmp.vec_xi,tmp.vec_tau, nlogLmat_mean_cst, tmp.fmincon_data_xi, tmp.fmincon_data_tau, tmp.genetic_data_xi, tmp.genetic_data_tau, 1)
    
    xlabel('xi')
    ylabel('tau')
    zlabel('nlogL')
    title(strcat('Averaged for gamma=',num2str(paramconst_both(1)), ':', num2str(paramconst_both(2))))
    
    clear tmp;
    
       
%% tau is constant

    tmp=load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\LLsurfaces\UCB\structures\participant_',int2str(ID),'_struct_cst_tau.mat'));

    tmp.vec_gamma = linspace(tmp.param_bounds_gamma(1),tmp.param_bounds_gamma(2),tmp.n_per_dim);
    tmp.vec_tau = linspace(tmp.param_bounds_tau(1),tmp.param_bounds_tau(2),tmp.n_per_dim);
    tmp.vec_xi = linspace(tmp.param_bounds_xi(1),tmp.param_bounds_xi(2),tmp.n_per_dim);

    nlogLmat_mean_cst=mean(tmp.nlogLmat,3);
    
    % no need to transpose here becasue changed the order of the indexes in
     nlogLmat_mean_cst = nlogLmat_mean_cst';
    
    paramconst_both=sort([tmp.fmincon_data_tau tmp.genetic_data_tau]);
    
    plot_LL_surface(tmp.vec_xi,tmp.vec_gamma, nlogLmat_mean_cst, tmp.fmincon_data_xi, tmp.fmincon_data_gamma, tmp.genetic_data_xi, tmp.genetic_data_gamma, 2)
    
    xlabel('xi')
    ylabel('gamma')
    zlabel('nlogL')
    title(strcat('Averaged for tau=',num2str(paramconst_both(1)), ':', num2str(paramconst_both(2))))
    
    clear tmp;
    
%% xi is constant

    tmp=load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\LLsurfaces\UCB\structures\participant_',int2str(ID),'_struct_cst_xi.mat'));

    tmp.vec_gamma = linspace(tmp.param_bounds_gamma(1),tmp.param_bounds_gamma(2),tmp.n_per_dim);
    tmp.vec_tau = linspace(tmp.param_bounds_tau(1),tmp.param_bounds_tau(2),tmp.n_per_dim);
    tmp.vec_xi = linspace(tmp.param_bounds_xi(1),tmp.param_bounds_xi(2),tmp.n_per_dim);

    nlogLmat_mean_cst=mean(tmp.nlogLmat,3);
    
    % ADDED (if not found LL does not match with the one on the graph)
    nlogLmat_mean_cst = nlogLmat_mean_cst';
    
    paramconst_both=sort([tmp.fmincon_data_xi tmp.genetic_data_xi]);
    
    plot_LL_surface(tmp.vec_tau,tmp.vec_gamma, nlogLmat_mean_cst, tmp.fmincon_data_tau, tmp.fmincon_data_gamma, tmp.genetic_data_tau, tmp.genetic_data_gamma, 3)
    
    xlabel('tau')
    ylabel('gamma')
    zlabel('nlogL')
    title(strcat('Averaged for xi=',num2str(paramconst_both(1)), ':', num2str(paramconst_both(2))))
    
    clear tmp;
    
    %% Save
    
    file_name = strcat('D:\MaggiesFarm\modeling_28_02\participant_data\LLsurfaces\UCB\');

    if ~exist(file_name)
        mkdir(file_name)
    end

    savefig(strcat(file_name, 'participant_', int2str(ID)));
    
end


    
%%
    function [] = plot_LL_surface(vec_param1,vec_param2, nlogLmat_mean_paramconst, fmincon_data_param1, fmincon_data_param2, genetic_data_param1, genetic_data_param2, n)
        
        subplot(1,3,n);
    
        [param1_mat, param2_mat]= meshgrid(vec_param1,vec_param2);
        
        surf(param1_mat,param2_mat,nlogLmat_mean_paramconst); hold on;
        z_line = min(min(nlogLmat_mean_paramconst)):max(max(nlogLmat_mean_paramconst));

        plot3(fmincon_data_param1*ones(1,size(z_line,2)),fmincon_data_param2*ones(1,size(z_line,2)), min(min(nlogLmat_mean_paramconst)):max(max(nlogLmat_mean_paramconst)),'r', 'Linewidth', 2); hold on;
        text(fmincon_data_param1,fmincon_data_param2,min(min(min(nlogLmat_mean_paramconst))+150,max(max(nlogLmat_mean_paramconst))),'fmincon \rightarrow ', 'HorizontalAlignment','right')

        plot3(genetic_data_param1*ones(1,size(z_line,2)),genetic_data_param2*ones(1,size(z_line,2)), min(min(nlogLmat_mean_paramconst)):max(max(nlogLmat_mean_paramconst)),'g', 'Linewidth', 2)
        text(genetic_data_param1,genetic_data_param2,min(min(min(nlogLmat_mean_paramconst))+150,max(max(nlogLmat_mean_paramconst))),'\leftarrow genetic', 'HorizontalAlignment','left')

        [mat_param1, mat_param2]= meshgrid(vec_param1,vec_param2);
        surf(mat_param1,mat_param2,nlogLmat_mean_paramconst)
        
        zlim([min(min(nlogLmat_mean_paramconst))-10 min(min(min(nlogLmat_mean_paramconst))+150,max(max(nlogLmat_mean_paramconst)))])
        
        
    end
  

