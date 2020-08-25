

data_folder = '../../../data/modelfit/thompson_percond/';

% AB
load('./frequencies/pickedhigh_AB_SH.mat')
load('./frequencies/pickedhigh_AB_LH.mat')
load('./frequencies/pickednovel_AB_SH.mat')
load('./frequencies/pickednovel_AB_LH.mat')
all_behav_AB= [pickedhigh_AB_SH, pickedhigh_AB_LH, pickednovel_AB_SH, pickednovel_AB_LH];
all_behav_AB_mean= [pickedhigh_AB_SH+pickedhigh_AB_LH, pickednovel_AB_SH+pickednovel_AB_LH]/2;

% ABD
load('./frequencies/pickedhigh_ABD_SH.mat')
load('./frequencies/pickedhigh_ABD_LH.mat')
load('./frequencies/pickedlow_ABD_SH.mat')
load('./frequencies/pickedlow_ABD_LH.mat')
all_behav_ABD= [pickedhigh_ABD_SH, pickedhigh_ABD_LH, pickedlow_ABD_SH, pickedlow_ABD_LH];
all_behav_ABD_mean= [pickedhigh_ABD_SH+pickedhigh_ABD_LH, pickedlow_ABD_SH+pickedlow_ABD_LH]/2;

% AD
load('./frequencies/pickedhigh_AD_SH.mat')
load('./frequencies/pickedhigh_AD_LH.mat')
load('./frequencies/pickedlow_AD_SH.mat')
load('./frequencies/pickedlow_AD_LH.mat')
load('./frequencies/pickednovel_AD_SH.mat')
load('./frequencies/pickednovel_AD_LH.mat')
all_behav_AD= [pickedhigh_AD_SH, pickedhigh_AD_LH, pickedlow_AD_SH, pickedlow_AD_LH, pickednovel_AD_SH, pickednovel_AD_LH];
all_behav_AD_mean= [pickedhigh_AD_SH+pickedhigh_AD_LH, pickedlow_AD_SH+pickedlow_AD_LH, pickednovel_AD_SH+pickednovel_AD_LH]/2;

% BD
load('./frequencies/pickedhigh_BD_SH.mat')
load('./frequencies/pickedhigh_BD_LH.mat')
load('./frequencies/pickedlow_BD_SH.mat')
load('./frequencies/pickedlow_BD_LH.mat')
load('./frequencies/pickednovel_BD_SH.mat')
load('./frequencies/pickednovel_BD_LH.mat')
all_behav_BD= [pickedhigh_BD_SH, pickedhigh_BD_LH, pickedlow_BD_SH, pickedlow_BD_LH, pickednovel_BD_SH, pickednovel_BD_LH];
all_behav_BD_mean= [pickedhigh_BD_SH+pickedhigh_BD_LH, pickedlow_BD_SH+pickedlow_BD_LH, pickednovel_BD_SH+pickednovel_BD_LH]/2;

% All
all_behav = [all_behav_AB, all_behav_ABD, all_behav_AD, all_behav_BD];
all_behav_mean = [all_behav_AB_mean, all_behav_ABD_mean, all_behav_AD_mean, all_behav_BD_mean];
all_behav_desc = {'pickedhigh_AB_SH', 'pickedhigh_AB_LH', 'pickednovel_AB_SH', 'pickednovel_AB_LH', ...
                    'pickedhigh_ABD_SH', 'pickedhigh_ABD_LH', 'pickedlow_ABD_SH', 'pickedlow_ABD_LH', ...
                        'pickedhigh_AD_SH', 'pickedhigh_AD_LH', 'pickedlow_AD_SH', 'pickedlow_AD_LH', 'pickednovel_AD_SH', 'pickednovel_AD_LH', ...
                            'pickedhigh_BD_SH', 'pickedhigh_BD_LH', 'pickedlow_BD_SH', 'pickedlow_BD_LH', 'pickednovel_BD_SH', 'pickednovel_BD_LH'};
all_behav_mean_desc = {'pickedhigh_AB_mean', 'pickednovel_AB_mean', 'pickedhigh_ABD_mean', 'pickedlow_ABD_mean', ...
                        'pickedhigh_AD_mean', 'pickedlow_AD_mean', 'pickednovel_AD_mean', 'pickedhigh_BD_mean', 'pickedlow_BD_mean', 'pickednovel_BD_mean'};

% drug code
load('../../../data/data_for_figs/drug_code.mat')
load('../../../data/data_for_figs/drug_code_desc.mat')

% demo
load('../../../data/data_for_figs/demo_corr.mat')
load('../../../data/data_for_figs/demo_corr_desc.mat')

T = array2table([all_behav, drug_code(:,1), drug_code(:,2), demo_corr, all_behav_mean]);

all_behav_desc{size(all_behav,2)+1} = 'ID';
all_behav_desc{size(all_behav,2)+2} = 'drug_code';
all_behav_desc{size(all_behav,2)+3} = demo_corr_desc{1};
all_behav_desc{size(all_behav,2)+4} = demo_corr_desc{2};
for i =1:size(all_behav_mean_desc,2)
    all_behav_desc{size(all_behav,2)+4+i} = all_behav_mean_desc{i};
end
T.Properties.VariableNames = all_behav_desc;

filename = 'behaviour.xlsx';
writetable(T,strcat(data_folder, filename),'Sheet',1)

