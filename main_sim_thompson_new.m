
%% NEED TO BE COPIED IN sim_refit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n_per_dim = 4;
param_bounds_sgm0 = [0.1,3.2];
param_bounds_Q0 = [1,6]; 
param_bounds_xi = [0,0.8];  
param_bounds_eta = [0,5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
algo = 'thompson';
n_param = 4;

param_bounds.xi = param_bounds_xi;
param_bounds.sgm0 = param_bounds_sgm0; 
param_bounds.Q0 = param_bounds_Q0; 
param_bounds.eta = param_bounds_eta; 

prep_inp_params_perhor_MAP(n_per_dim,algo, param_bounds);
  
% for ID=1:n_per_dim^7
% 
%     disp(strcat((int2str(ID)),32, 'of', 32, int2str(n_per_dim^(n_param*2-1))))
% 
%     sim_refit_thompson_3param_noveltybonus_parhor_MAP(ID) 
% 
% end
 
% aggregate_simResults_perHorMAP(n_per_dim)
% plot_correlation_perHor(n_per_dim)

