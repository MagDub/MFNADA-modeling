
num_part = 60; 

optim_algo = 'fmincon';

[all_parameters_hybrid] = concatenate_all_params_hybrid_byhor_3paramsxinovbon2Hor1T1X1w(num_part);

gamma_mat_hybrid_short = [all_parameters_hybrid(:,1)];
gamma_mat_hybrid_long = [all_parameters_hybrid(:,2)];
tau_mat_hybrid = [all_parameters_hybrid(:,3)];
xi_mat_hybrid = [all_parameters_hybrid(:,4)];
eta_mat_hybrid = [all_parameters_hybrid(:,5)];
whyb_mat_hybrid = [all_parameters_hybrid(:,6)];




