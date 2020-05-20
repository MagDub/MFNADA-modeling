
for ID = 503%:560
    
    figure()
    
%% 

load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson\3params\results\fmincon\res_thompson_',int2str(ID),'_results.mat'));
disp(mE)
sgm0_short = mE.params(1);
sgm0_long = mE.params(2);
Q0_short = mE.params(3);
Q0_long = mE.params(3); 
xi_short = mE.params(4);
xi_long = mE.params(5);    

%% sgm0 is constant

    tmp=load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\LLsurfaces\thompson\structures\participant_',int2str(ID),'_struct_cst_sgm0.mat'));
    
    %disp(tmp)
    
    tmp.vec_sgm0 = linspace(tmp.param_bounds_sgm0(1),tmp.param_bounds_sgm0(2),tmp.n_per_dim);
    tmp.vec_Q0 = linspace(tmp.param_bounds_Q0(1),tmp.param_bounds_Q0(2),tmp.n_per_dim);
    tmp.vec_xi = linspace(tmp.param_bounds_xi(1),tmp.param_bounds_xi(2),tmp.n_per_dim);

    nlogLmat_mean_cst=mean(tmp.nlogLmat,3);
    
    % ADDED (if not found LL does not match with the one on the graph)
    nlogLmat_mean_cst = nlogLmat_mean_cst';
    
    paramconst_both=sort([tmp.fmincon_data_sgm0 tmp.genetic_data_sgm0]);
    
    %plot_LL_surface(tmp.vec_xi,tmp.vec_Q0, nlogLmat_mean_cst, xi_short, tmp.fmincon_data_Q0, xi_long, Q0_long, 1)
    plot_LL_surface(tmp.vec_xi,tmp.vec_Q0, nlogLmat_mean_cst, xi_short, Q0_short, xi_long, Q0_long, 1)
    
    xlabel('xi')
    ylabel('Q0')
    zlabel('nlogL')
    title(strcat('Averaged for sgm0=',num2str(paramconst_both(1)), ':', num2str(paramconst_both(2))))
    
    clear tmp;
    
%% Q0 is constant

    tmp=load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\LLsurfaces\thompson\structures\participant_',int2str(ID),'_struct_cst_Q0.mat'));

    tmp.vec_sgm0 = linspace(tmp.param_bounds_sgm0(1),tmp.param_bounds_sgm0(2),tmp.n_per_dim);
    tmp.vec_Q0 = linspace(tmp.param_bounds_Q0(1),tmp.param_bounds_Q0(2),tmp.n_per_dim);
    tmp.vec_xi = linspace(tmp.param_bounds_xi(1),tmp.param_bounds_xi(2),tmp.n_per_dim);

    nlogLmat_mean_cst=mean(tmp.nlogLmat,3);
    
    % no need to transpose here becasue changed the order of the indexes in
    % likelihood_space_thomspon_cost_Q0
    
    paramconst_both=sort([tmp.fmincon_data_Q0 tmp.genetic_data_Q0]);
    
    plot_LL_surface(tmp.vec_xi,tmp.vec_sgm0, nlogLmat_mean_cst, xi_short, sgm0_short, xi_long, sgm0_long, 2)
    
    xlabel('xi')
    ylabel('sgm0')
    zlabel('nlogL')
    title(strcat('Averaged for Q0=',num2str(paramconst_both(1)), ':', num2str(paramconst_both(2))))
    
    clear tmp;
    
%% xi is constant

    tmp=load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\LLsurfaces\thompson\structures\participant_',int2str(ID),'_struct_cst_xi.mat'));

    tmp.vec_sgm0 = linspace(tmp.param_bounds_sgm0(1),tmp.param_bounds_sgm0(2),tmp.n_per_dim);
    tmp.vec_Q0 = linspace(tmp.param_bounds_Q0(1),tmp.param_bounds_Q0(2),tmp.n_per_dim);
    tmp.vec_xi = linspace(tmp.param_bounds_xi(1),tmp.param_bounds_xi(2),tmp.n_per_dim);

    nlogLmat_mean_cst=mean(tmp.nlogLmat,3);
    
    % ADDED (if not found LL does not match with the one on the graph)
    nlogLmat_mean_cst = nlogLmat_mean_cst';
    
    paramconst_both=sort([tmp.fmincon_data_xi tmp.genetic_data_xi]);
    
    plot_LL_surface(tmp.vec_Q0,tmp.vec_sgm0, nlogLmat_mean_cst, Q0_short , sgm0_short, Q0_long, sgm0_long, 3)
    
    xlabel('Q0')
    ylabel('sgm0')
    zlabel('nlogL')
    title(strcat('Averaged for xi=',num2str(paramconst_both(1)), ':', num2str(paramconst_both(2))))
    
    clear tmp;
    
    %% Save
    
    file_name = strcat('D:\MaggiesFarm\modeling_28_02\participant_data\LLsurfaces\thompson\');

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
        text(fmincon_data_param1,fmincon_data_param2,max(max(nlogLmat_mean_paramconst)),'Short \rightarrow ', 'HorizontalAlignment','right')

        plot3(genetic_data_param1*ones(1,size(z_line,2)),genetic_data_param2*ones(1,size(z_line,2)), min(min(nlogLmat_mean_paramconst)):max(max(nlogLmat_mean_paramconst)),'g', 'Linewidth', 2)
        text(genetic_data_param1,genetic_data_param2,max(max(nlogLmat_mean_paramconst)),'\leftarrow Long', 'HorizontalAlignment','left')

        [mat_param1, mat_param2]= meshgrid(vec_param1,vec_param2);
        surf(mat_param1,mat_param2,nlogLmat_mean_paramconst)
    end
  

