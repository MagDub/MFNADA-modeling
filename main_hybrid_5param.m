
%% NEED TO BE COPIED IN sim_refit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
holly = 1;
n_per_dim = 7;
param_bounds_gamma = [0.01,10]; % information bonus
param_bounds_tau = [0.01,5]; % inverse temperature
param_bounds_xi = [0.01,0.5]; % epsilon greedy
param_bounds_sgm0 = [0.01,6]; 
param_bounds_w_hyb = [0,1]; % arbitrates between thompson and hybrid
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
algo = 'hybrid';

n_param = 5;

param_bounds.gamma = param_bounds_gamma;
param_bounds.tau = param_bounds_tau; 
param_bounds.xi = param_bounds_xi; 
param_bounds.sgm0 = param_bounds_sgm0; 
%param_bounds.Q0 = param_bounds_Q0; 
param_bounds.w_hyb = param_bounds_w_hyb; 

prep_inp_params(n_per_dim,algo, n_param, param_bounds, []);

iterTot = n_per_dim^n_param

if holly==0
    
    for ID=23:iterTot

        disp(strcat((int2str(ID)),32, 'of', 32, int2str(iterTot)))

        sim_refit_hybrid_5param(ID) 

    end
    
    aggregate_simResults_5params(algo, n_param, n_per_dim)
    plot_correlation_5param_(algo, n_per_dim)
    
elseif holly==1
    
    disp(strcat('TO WRITE in HOLLY_MF_hybrid.sh : -t 1-',int2str(n_per_dim^n_param)))
    
end


