
addpath('model_fct/')
data_folder = '../../data/modelfit/ucb_prior1normal/';

% load
[model_parameters, param_settings] = concatenate_all_params(strcat(data_folder,'results/'));
model_parameters_desc = [{'ID'} {'Q0'} {'gamma_short'} {'gamma_long'} {'tau_short'} {'tau_long'} {'xi_short'} {'xi_long'} {'eta_short'} {'eta_long'}];

% Save
mkdir(strcat(data_folder, 'concatenated'));
save(strcat(data_folder, 'concatenated/model_parameters.mat'),'model_parameters');
save(strcat(data_folder, 'concatenated/model_parameters_desc.mat'), 'model_parameters_desc');
save(strcat(data_folder, 'concatenated/param_settings.mat'),'param_settings');

load('../../data/data_for_figs/drug_code.mat')
load('../../data/data_for_figs/drug_code_desc.mat')

load('../../data/data_for_figs/demo_corr.mat')
load('../../data/data_for_figs/demo_corr_desc.mat')

T = array2table([model_parameters, drug_code(:,2), demo_corr]);

model_parameters_desc{size(model_parameters,2)+1} = 'drug_code';
model_parameters_desc{size(model_parameters,2)+2} = demo_corr_desc{1};
model_parameters_desc{size(model_parameters,2)+3} = demo_corr_desc{2};
T.Properties.VariableNames = model_parameters_desc;

filename = 'model_parameters.xlsx';
writetable(T,strcat(data_folder, 'concatenated/', filename),'Sheet',1)

