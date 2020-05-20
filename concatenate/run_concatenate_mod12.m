

[all_parameters_thomp_noveltybonus_MAP] = concatenate_all_params_thomp_nov_2Hor_2nov_Q01_MAP_uni_2s();

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
model_parameters_desc = [{'sgm0_short'} {'sgm0_long'} {'Q0'} {'xi_short'} {'xi_long'} {'eta_short'} {'eta_long'}];

save('D:\writing\MF_dev\data_for_figs\model_parameters_2s.mat', 'model_parameters');
save('D:\writing\MF_dev\data_for_figs\model_parameters_2s_desc.mat', 'model_parameters_desc');

