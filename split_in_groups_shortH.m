
num_part = 60;
optim_algo = 'fmincon';

[all_parameters_hybrid_Q0single, all_parameters_hybrid_Q0sgm0single, all_parameters_hybrid_Q0sgm0w0single,all_parameters_hybrid_Q0sgm0w0xisingle, all_parameters_hybrid_Q0sgm0w0xisingle_newB, all_parameters_hybrid_Q0sgm0w0xisingle_newB2, all_parameters_hybrid_Q0sgm0w0xisingle_newB3, all_parameters_hybrid_Q0sgm0xisingle, all_parameters_hybrid_Q0sgm0xisingle_newB, all_parameters_hybrid_Q0sgm0xisingle_newB2] = concatenate_all_params2(num_part, optim_algo);

% Load drug coding - placebo = 0	ami = 1     prop = 2
load('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis_with_logreg\drug_coding.mat')
placebo_ind = find(drug_coding(1:num_part,2)==0);
ami_ind = find(drug_coding(1:num_part,2)==1);
prop_ind = find(drug_coding(1:num_part,2)==2);

%% Bounds 1

% boxplot short horizon
figure()
boxplot([all_parameters_hybrid_Q0sgm0w0xisingle_newB(placebo_ind ,1), all_parameters_hybrid_Q0sgm0w0xisingle_newB(ami_ind ,1), all_parameters_hybrid_Q0sgm0w0xisingle_newB(prop_ind ,1)])

figure()

subplot(1,4,1)
hist(all_parameters_hybrid_Q0sgm0w0xisingle_newB(placebo_ind ,1));
xlabel('Gamma value')
ylabel('frequency')
ylim([0 40])
title('Placebo - short Horizon')

subplot(1,4,2)
hist(all_parameters_hybrid_Q0sgm0w0xisingle_newB(ami_ind ,1));
xlabel('Gamma value')
ylabel('frequency')
ylim([0 40])
title('Ami - short Horizon')

subplot(1,4,3)
hist(all_parameters_hybrid_Q0sgm0w0xisingle_newB(prop_ind ,1));
xlabel('Gamma value')
ylabel('frequency')
ylim([0 40])
title('Prop - short Horizon')

subplot(1,4,4)
hist(all_parameters_hybrid_Q0sgm0w0xisingle_newB(: ,1));
xlabel('Gamma value')
ylabel('frequency')
ylim([0 40])
title('All - short Horizon')


%% Bounds 2

% boxplot short horizon
figure()
boxplot([all_parameters_hybrid_Q0sgm0w0xisingle_newB2(placebo_ind ,1), all_parameters_hybrid_Q0sgm0w0xisingle_newB2(ami_ind ,1), all_parameters_hybrid_Q0sgm0w0xisingle_newB2(prop_ind ,1)])

figure()

subplot(1,4,1)
hist(all_parameters_hybrid_Q0sgm0w0xisingle_newB2(placebo_ind ,1));
xlabel('Gamma value')
ylabel('frequency')
ylim([0 40])
title('Placebo - short Horizon')

subplot(1,4,2)
hist(all_parameters_hybrid_Q0sgm0w0xisingle_newB2(ami_ind ,1));
xlabel('Gamma value')
ylabel('frequency')
ylim([0 40])
title('Ami - short Horizon')

subplot(1,4,3)
hist(all_parameters_hybrid_Q0sgm0w0xisingle_newB2(prop_ind ,1));
xlabel('Gamma value')
ylabel('frequency')
ylim([0 40])
title('Prop - short Horizon')

subplot(1,4,4)
hist(all_parameters_hybrid_Q0sgm0w0xisingle_newB2(: ,1));
xlabel('Gamma value')
ylabel('frequency')
ylim([0 40])
title('All - short Horizon')

