
addpath('model_fct/')
data_folder = '../../../data/modelfit/thompson_percond/thompson_AD/';

% load
[model_parameters, param_settings] = concatenate_all_params(strcat(data_folder,'results/'));
model_parameters_desc = [{'ID'} {'sgm0_short'} {'sgm0_long'} {'Q0'} {'xi_short'} {'xi_long'} {'eta_short'} {'eta_long'}];

% Save
mkdir(strcat(data_folder, 'concatenated_AD'));
save(strcat(data_folder, 'concatenated_AD/model_parameters.mat'),'model_parameters');
save(strcat(data_folder, 'concatenated_AD/model_parameters_desc.mat'), 'model_parameters_desc');
save(strcat(data_folder, 'concatenated_AD/param_settings.mat'),'param_settings');



