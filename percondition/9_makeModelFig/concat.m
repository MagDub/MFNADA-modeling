

data_folder = '../../../data/modelfit/thompson_percond/';

% AB
[all_param_AB, all_param_AB_mean] = load_data_cond('AB');

% ABD
[all_param_ABD, all_param_ABD_mean] = load_data_cond('ABD');

% AD
[all_param_AD, all_param_AD_mean] = load_data_cond('AD');

% BD
[all_param_BD, all_param_BD_mean] = load_data_cond('BD');

% All
all_param = [all_param_AB, all_param_ABD, all_param_AD, all_param_BD];
all_param_mean = [all_param_AB_mean, all_param_ABD_mean, all_param_AD_mean, all_param_BD_mean];

all_param_desc = {'param_epsilon_AB_SH', 'param_epsilon_AB_LH', 'param_sgm0_AB_SH', 'param_sgm0_AB_LH', 'param_eta_AB_SH', 'param_eta_AB_LH',...
                    'param_epsilon_ABD_SH', 'param_epsilon_ABD_LH', 'param_sgm0_ABD_SH', 'param_sgm0_ABD_LH', 'param_eta_ABD_SH', 'param_eta_ABD_LH',...
                        'param_epsilon_AD_SH', 'param_epsilon_AD_LH', 'param_sgm0_AD_SH', 'param_sgm0_AD_LH', 'param_eta_AD_SH', 'param_eta_AD_LH',...
                            'param_epsilon_BD_SH', 'param_epsilon_BD_LH', 'param_sgm0_BD_SH', 'param_sgm0_BD_LH', 'param_eta_BD_SH', 'param_eta_BD_LH'};
                        
all_param_mean_desc = {'param_epsilon_AB_mean', 'param_sgm0_AB_mean', 'param_eta_AB_mean', ...
                        'param_epsilon_ABD_mean',  'param_sgm0_ABD_mean', 'param_eta_ABD_mean', ...
                            'param_epsilon_AD_mean',  'param_sgm0_AD_mean', 'param_eta_AD_mean', ...
                                'param_epsilon_BD_mean',  'param_sgm0_BD_mean', 'param_eta_BD_mean'};

% drug code
load('../../../data/data_for_figs/drug_code.mat')
load('../../../data/data_for_figs/drug_code_desc.mat')

% demo
load('../../../data/data_for_figs/demo_corr.mat')
load('../../../data/data_for_figs/demo_corr_desc.mat')

T = array2table([all_param, drug_code(:,1), drug_code(:,2), demo_corr, all_param_mean]);

all_param_desc{size(all_param,2)+1} = 'ID';
all_param_desc{size(all_param,2)+2} = 'drug_code';
all_param_desc{size(all_param,2)+3} = demo_corr_desc{1};
all_param_desc{size(all_param,2)+4} = demo_corr_desc{2};
for i =1:size(all_param_mean_desc,2)
    all_param_desc{size(all_param,2)+4+i} = all_param_mean_desc{i};
end
T.Properties.VariableNames = all_param_desc;
 
filename = 'model_params.xlsx';
writetable(T,strcat(data_folder, filename),'Sheet',1)

