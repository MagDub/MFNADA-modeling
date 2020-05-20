

[all_parameters_thomp_noveltybonus_MAP] = concatenate_thomp_like_param_recovery_2sgm0();

sgm0_mat_thomp_short = [all_parameters_thomp_noveltybonus_MAP(:,1)];
sgm0_mat_thomp_long = [all_parameters_thomp_noveltybonus_MAP(:,2)];
sgm0_mat_thomp = [sgm0_mat_thomp_short sgm0_mat_thomp_long];
Q0_mat_thomp = [all_parameters_thomp_noveltybonus_MAP(:,3)];
xi_mat_thomp_short = [all_parameters_thomp_noveltybonus_MAP(:,4)];
xi_mat_thomp_long = [all_parameters_thomp_noveltybonus_MAP(:,5)];
xi_mat_thomp = [xi_mat_thomp_short xi_mat_thomp_long];
eta_mat_thomp_short = [all_parameters_thomp_noveltybonus_MAP(:,6)];
eta_mat_thomp_long = [all_parameters_thomp_noveltybonus_MAP(:,7)];
eta_mat_thomp = [eta_mat_thomp_short eta_mat_thomp_long];


model_parameters = [all_parameters_thomp_noveltybonus_MAP];
model_parameters_desc = [{'ID'} {'sgm0'} {'Q0'} {'xi_short'} {'xi_long'} {'eta_short'} {'eta_long'}];

