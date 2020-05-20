

[all_parameters] = concatenate_all_params_mod8();

Q0_mat = [all_parameters(:,1)];

gamma_mat_short = [all_parameters(:,2)];
gamma_mat_long = [all_parameters(:,3)];
gamma_mat = [gamma_mat_short gamma_mat_long];

tau_mat_short = [all_parameters(:,4)];
tau_mat_long = [all_parameters(:,5)];
tau_mat = [tau_mat_short tau_mat_long];

xi_mat_short = [all_parameters(:,6)];
xi_mat_long = [all_parameters(:,7)];
xi_mat = [xi_mat_short xi_mat_long];

eta_mat_short = [all_parameters(:,8)];
eta_mat_long = [all_parameters(:,9)];
eta_mat = [eta_mat_short eta_mat_long];


model_parameters = [all_parameters];
model_parameters_desc = [{'Q0' 'gamma_SH'   'gamma_LH'         'tau_SH'      'tau_LH'      'xi_SH'   'xi_LH'   'eta_SH' 'eta_LH'}];

save('D:\writing\MF\data_for_figs\model_8_UCB_parameters.mat', 'model_parameters');
save('D:\writing\MF\data_for_figs\model_8_UCB_parameters_desc.mat', 'model_parameters_desc');

