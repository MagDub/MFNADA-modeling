
num_part = 60; 

optim_algo = 'fmincon';

[all_parameters_thomp_noveltybonus] = concatenate_all_params_thomp_noveltybonus_2Hor_2nov_Q03(num_part);

sgm0_mat_thomp = [all_parameters_thomp_noveltybonus(:,1)];
Q0_mat_thomp = [all_parameters_thomp_noveltybonus(:,2)];
xi_mat_thomp_short = [all_parameters_thomp_noveltybonus(:,3)];
xi_mat_thomp_long = [all_parameters_thomp_noveltybonus(:,4)];
xi_mat_thomp = [xi_mat_thomp_short xi_mat_thomp_long];
eta_mat_thomp_short = [all_parameters_thomp_noveltybonus(:,5)];
eta_mat_thomp_long = [all_parameters_thomp_noveltybonus(:,6)];
eta_mat_thomp = [eta_mat_thomp_short eta_mat_thomp_long];

