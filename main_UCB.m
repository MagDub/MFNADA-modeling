
%% TO BE COPIED IN sim_refit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
holly = 1;
n_per_dim = 20;
param_bounds_gamma = [0.01,6]; % information bonus
param_bounds_tau = [0.1,1.5]; % inverse temperature
param_bounds_xi = [0.01,0.5]; % epsilon greedy
%param_bounds_sgm0 = [1,5]; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
algo = 'UCB';
n_param = 3;

param_bounds.gamma = param_bounds_gamma;
param_bounds.tau = param_bounds_tau; 
param_bounds.xi = param_bounds_xi; 
%param_bounds.sigma = param_bounds_sgm0; 

prep_inp_params(n_per_dim,algo, n_param, param_bounds, []);

iterTot = n_per_dim^n_param;

if holly==0
    
    parfor ID=1:iterTot

        disp(strcat((int2str(ID)),32, 'of', 32, int2str(iterTot)))

        sim_refit_UCB_3param_new(ID) 

    end
    
    %aggregate_simResults_3params(algo, n_param, n_per_dim)
    %plot_correlation_3param_(algo, n_per_dim)
    
elseif holly==1
    
    disp(strcat('TO WRITE in HOLLY_MF_UCB.sh : -t 1-',int2str(n_per_dim^n_param)))
    
end


