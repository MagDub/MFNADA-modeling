
%% TO BE COPIED IN sim_refit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
holly = 0;
n_per_dim = 5;
param_bounds_gamma = [0.01,10]; % factor in front of mean
param_bounds_tau = [0.1,3]; % inverse temperature
param_bounds_xi = [0,0.3]; % epsilon greedy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
algo = 'UCBargmax';
n_param = 3;

param_bounds.gamma = param_bounds_gamma;
param_bounds.tau = param_bounds_tau; 
param_bounds.xi = param_bounds_xi; 

prep_inp_params(n_per_dim,algo, n_param, param_bounds, []);

iterTot = n_per_dim^n_param;

if holly==0
    
    parfor ID=1:iterTot

        disp(strcat((int2str(ID)),32, 'of', 32, int2str(iterTot)))

        sim_refit_UCBargmax_3param(ID) 

    end
    
    %aggregate_simResults_3params(algo, n_param, n_per_dim)
    %plot_correlation_3param_(algo, n_per_dim)
    
elseif holly==1
    
    disp(strcat('TO WRITE in HOLLY_MF_UCB.sh : -t 1-',int2str(n_per_dim^n_param)))
    
end


