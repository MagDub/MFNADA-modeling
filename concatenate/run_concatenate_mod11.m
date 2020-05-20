

[all_parameters_thomp_noveltybonus_MAP] = concatenate_all_params_thomp_mod11();

sgm0_mat_thomp_short = [all_parameters_thomp_noveltybonus_MAP(:,1)];
sgm0_mat_thomp_long = [all_parameters_thomp_noveltybonus_MAP(:,2)];
sgm0_mat_thomp = [sgm0_mat_thomp_short sgm0_mat_thomp_long];
Q0_mat_thomp = [all_parameters_thomp_noveltybonus_MAP(:,3)];
eta_mat_thomp_short = [all_parameters_thomp_noveltybonus_MAP(:,4)];
eta_mat_thomp_long = [all_parameters_thomp_noveltybonus_MAP(:,5)];
eta_mat_thomp = [eta_mat_thomp_short eta_mat_thomp_long];

model_parameters = [all_parameters_thomp_noveltybonus_MAP];
model_parameters_desc = [{'sgm0_short'} {'sgm0_long'} {'Q0'} {'eta_short'} {'eta_long'}];

save('D:\writing\MF\data_for_figs\model_parameters_mod11.mat', 'model_parameters');
save('D:\writing\MF\data_for_figs\model_parameters_mod11_desc.mat', 'model_parameters_desc');

