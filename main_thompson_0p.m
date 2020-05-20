
%% NEED TO BE COPIED IN sim_refit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
holly = 0;
n_per_dim = 10;
param_bounds_eta = [0,5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
algo = 'thompson';
n_param = 1;

param_bounds.eta = param_bounds_eta; 

prep_inp_params(n_per_dim,algo, n_param, param_bounds, []);

if holly==0
    
    parfor ID=1:n_per_dim^n_param

        disp(strcat((int2str(ID)),32, 'of', 32, int2str(n_per_dim^n_param)))

        sim_refit_thompson_3param_noveltybonus(ID)

    end
    
    
elseif holly==1
    
    disp(strcat('TO WRITE in HOLLY_MF_thompson.sh : -t 1-',int2str(n_per_dim^n_param)))
    
end

    aggregate_simResults(algo, n_param, n_per_dim)
    plot_correlation_1param_(algo, n_per_dim)
