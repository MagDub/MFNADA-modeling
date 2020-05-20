
%% NEED TO BE COPIED IN sim_refit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
holly = 1;
n_per_dim = 5;
param_bounds_sgm0 = [0.01,6];
param_bounds_Q0 = [1,10]; 
param_bounds_xi = [10^-8,0.5];  
param_bounds_eta = [0,5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% faire Q0 de 1

%%
algo = 'thompson';
n_param = 4;

param_bounds.xi = param_bounds_xi;
param_bounds.sgm0 = param_bounds_sgm0; 
param_bounds.Q0 = param_bounds_Q0; 
param_bounds.eta = param_bounds_eta; 

prep_inp_params_perhor(n_per_dim,algo, n_param, param_bounds, []);
  
parfor ID=1:n_per_dim^n_param

    disp(strcat((int2str(ID)),32, 'of', 32, int2str(n_per_dim^n_param)))

    sim_refit_thompson_3param_noveltybonus_parhor(ID) 

end

aggregate_simResults(algo, n_param, n_per_dim)
plot_correlation(algo, n_param, n_per_dim)
