
for ID = 507 %501:560
    
%    figure()

% %% sgm0 is constant
% 
%     tmp=load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\LLsurfaces\thompson\structures\participant_',int2str(ID),'_struct_cst_sgm0.mat'));
%     
%     tmp.vec_sgm0 = linspace(tmp.param_bounds_sgm0(1),tmp.param_bounds_sgm0(2),tmp.n_per_dim);
%     tmp.vec_Q0 = linspace(tmp.param_bounds_Q0(1),tmp.param_bounds_Q0(2),tmp.n_per_dim);
%     tmp.vec_xi = linspace(tmp.param_bounds_xi(1),tmp.param_bounds_xi(2),tmp.n_per_dim);
% 
%     nlogLmat_mean_cst=mean(tmp.nlogLmat,3);
%     
%     % ADDED (if not found LL does not match with the one on the graph)
%     nlogLmat_mean_cst = nlogLmat_mean_cst';
%     
%     paramconst_both=sort([tmp.fmincon_data_sgm0 tmp.genetic_data_sgm0]);
%     
%     plot_LL_surface(tmp.vec_xi,tmp.vec_Q0, nlogLmat_mean_cst, tmp.fmincon_data_xi, tmp.fmincon_data_Q0, tmp.genetic_data_xi, tmp.genetic_data_Q0, 1)
%     
%     xlabel('xi')
%     ylabel('Q0')
%     zlabel('nlogL')
%     title(strcat('Averaged for sgm0=',num2str(paramconst_both(1)), ':', num2str(paramconst_both(2))))
%     
%     clear tmp;
    
%% Q0 is constant

    tmp=load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\LLsurfaces\thompson\structures\participant_',int2str(ID),'_struct_cst_Q0.mat'));

    tmp.vec_sgm0 = linspace(tmp.param_bounds_sgm0(1),tmp.param_bounds_sgm0(2),tmp.n_per_dim);
    tmp.vec_Q0 = linspace(tmp.param_bounds_Q0(1),tmp.param_bounds_Q0(2),tmp.n_per_dim);
    tmp.vec_xi = linspace(tmp.param_bounds_xi(1),tmp.param_bounds_xi(2),tmp.n_per_dim);

    nlogLmat_mean_cst=mean(tmp.nlogLmat,3);
    detHessmat_mean_cst=mean(tmp.detHessmat,3);
    
    % no need to transpose here becasue changed the order of the indexes in
    % likelihood_space_thomspon_cost_Q0
    
    paramconst_both=sort([tmp.fmincon_data_Q0 tmp.genetic_data_Q0]);
    
    plot_LL_surface(paramconst_both, tmp.vec_xi,tmp.vec_sgm0, nlogLmat_mean_cst, detHessmat_mean_cst, tmp.fmincon_data_xi, tmp.fmincon_data_sgm0, tmp.genetic_data_xi, tmp.genetic_data_sgm0, 1)
    
    figure()
    plot_LL_surface2(paramconst_both, tmp.vec_xi,tmp.vec_sgm0, nlogLmat_mean_cst, detHessmat_mean_cst, tmp.fmincon_data_xi, tmp.fmincon_data_sgm0, tmp.genetic_data_xi, tmp.genetic_data_sgm0, 1)

    
    clear tmp;
%    
% %% xi is constant
% 
%     tmp=load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\LLsurfaces\thompson\structures\participant_',int2str(ID),'_struct_cst_xi.mat'));
% 
%     tmp.vec_sgm0 = linspace(tmp.param_bounds_sgm0(1),tmp.param_bounds_sgm0(2),tmp.n_per_dim);
%     tmp.vec_Q0 = linspace(tmp.param_bounds_Q0(1),tmp.param_bounds_Q0(2),tmp.n_per_dim);
%     tmp.vec_xi = linspace(tmp.param_bounds_xi(1),tmp.param_bounds_xi(2),tmp.n_per_dim);
% 
%     nlogLmat_mean_cst=mean(tmp.nlogLmat,3);
%     
%     % ADDED (if not found LL does not match with the one on the graph)
%     nlogLmat_mean_cst = nlogLmat_mean_cst';
%     
%     paramconst_both=sort([tmp.fmincon_data_xi tmp.genetic_data_xi]);
%     
%     plot_LL_surface(tmp.vec_Q0,tmp.vec_sgm0, nlogLmat_mean_cst, tmp.fmincon_data_Q0, tmp.fmincon_data_sgm0, tmp.genetic_data_Q0, tmp.genetic_data_sgm0, 3)
%     
%     xlabel('Q0')
%     ylabel('sgm0')
%     zlabel('nlogL')
%     title(strcat('Averaged for xi=',num2str(paramconst_both(1)), ':', num2str(paramconst_both(2))))
%     
%     clear tmp;
    
    %% Save
    
    file_name = strcat('D:\MaggiesFarm\modeling_28_02\participant_data\LLsurfaces\thompson\');

    if ~exist(file_name)
        mkdir(file_name)
    end

    savefig(strcat(file_name, 'participant_', int2str(ID)));
    
end


    
%%
    function [] = plot_LL_surface(paramconst_both, vec_param1,vec_param2, nlogLmat_mean_paramconst, detHessmat_mean_paramconst, fmincon_data_param1, fmincon_data_param2, genetic_data_param1, genetic_data_param2, n)
        
        %subplot(1,2,n);
    
        [param1_mat, param2_mat]= meshgrid(vec_param1,vec_param2);
        
        surf(param1_mat,param2_mat,nlogLmat_mean_paramconst); hold on;
        z_line = min(min(nlogLmat_mean_paramconst)):max(max(nlogLmat_mean_paramconst));

        plot3(fmincon_data_param1*ones(1,size(z_line,2)),fmincon_data_param2*ones(1,size(z_line,2)), min(min(nlogLmat_mean_paramconst)):max(max(nlogLmat_mean_paramconst)),'r', 'Linewidth', 2); hold on;
        text(fmincon_data_param1,fmincon_data_param2,max(max(nlogLmat_mean_paramconst)),'fmincon \rightarrow ', 'HorizontalAlignment','right')

        plot3(genetic_data_param1*ones(1,size(z_line,2)),genetic_data_param2*ones(1,size(z_line,2)), min(min(nlogLmat_mean_paramconst)):max(max(nlogLmat_mean_paramconst)),'g', 'Linewidth', 2)
        text(genetic_data_param1,genetic_data_param2,max(max(nlogLmat_mean_paramconst)),'\leftarrow genetic', 'HorizontalAlignment','left')

        [mat_param1, mat_param2]= meshgrid(vec_param1,vec_param2);
        surf(mat_param1,mat_param2,nlogLmat_mean_paramconst)
        
        xlabel('xi')
        ylabel('sgm0')
        zlabel('nlogL')
        title(strcat('Averaged for Q0=',num2str(paramconst_both(1)), ':', num2str(paramconst_both(2))))
    end
        
    function [] = plot_LL_surface2(paramconst_both, vec_param1,vec_param2, nlogLmat_mean_paramconst, detHessmat_mean_paramconst, fmincon_data_param1, fmincon_data_param2, genetic_data_param1, genetic_data_param2, n)

        % Plot hessian
        %subplot(1,2,n+1);
            
        [param1_mat, param2_mat]= meshgrid(vec_param1,vec_param2);
        
        surf(param1_mat,param2_mat,detHessmat_mean_paramconst); hold on;
        z_line = min(min(detHessmat_mean_paramconst)):max(max(detHessmat_mean_paramconst));

        plot3(fmincon_data_param1*ones(1,size(z_line,2)),fmincon_data_param2*ones(1,size(z_line,2)), min(min(detHessmat_mean_paramconst)):max(max(detHessmat_mean_paramconst)),'r', 'Linewidth', 2); hold on;
        text(fmincon_data_param1,fmincon_data_param2,max(max(detHessmat_mean_paramconst)),'fmincon \rightarrow ', 'HorizontalAlignment','right')

        plot3(genetic_data_param1*ones(1,size(z_line,2)),genetic_data_param2*ones(1,size(z_line,2)), min(min(detHessmat_mean_paramconst)):max(max(detHessmat_mean_paramconst)),'g', 'Linewidth', 2)
        text(genetic_data_param1,genetic_data_param2,max(max(detHessmat_mean_paramconst)),'\leftarrow genetic', 'HorizontalAlignment','left')

        [mat_param1, mat_param2]= meshgrid(vec_param1,vec_param2);
        surf(mat_param1,mat_param2,detHessmat_mean_paramconst)
        
        xlabel('xi')
        ylabel('sgm0')
        zlabel('detHess')
        title(strcat('Averaged for Q0=',num2str(paramconst_both(1)), ':', num2str(paramconst_both(2))))
    end
  

