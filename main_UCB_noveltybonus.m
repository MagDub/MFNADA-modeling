
%% TO BE COPIED IN sim_refit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
holly = 1;
n_per_dim = 10;
param_bounds_gamma = [10^-8,4]; % information bonus
param_bounds_tau = [10^-8,7]; % inverse temperature
param_bounds_eta = [0,5];
param_bounds_xi = [10^-8,0.5]; % epsilon greedy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%
algo = 'UCB_noveltybonus';
n_param = 4;

param_bounds.gamma = param_bounds_gamma;
param_bounds.tau = param_bounds_tau; 
param_bounds.eta = param_bounds_eta; 
param_bounds.xi = param_bounds_xi; 


prep_inp_params(n_per_dim,algo, n_param, param_bounds, []);

iterTot = n_per_dim^n_param;

if holly==0
    
    parfor ID=1:iterTot

        disp(strcat((int2str(ID)),32, 'of', 32, int2str(iterTot)))

        sim_refit_UCB_3param_noveltybonus(ID) 

    end
    
    
elseif holly==1
    
    disp(strcat('TO WRITE in HOLLY_MF_UCB_noveltybonus_test.sh : -t 1-',int2str(n_per_dim^n_param)))
    
end


