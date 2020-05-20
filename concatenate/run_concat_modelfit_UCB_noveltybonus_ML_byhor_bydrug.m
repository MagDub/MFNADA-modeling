
num_part = 60; 

optim_algo = 'fmincon';

[all_parameters_UCB_noveltybonus] = concatenate_all_params_UCB_noveltybonus_byhor(num_part);


%% Drugs

% Load drug coding - placebo = 0	amisulpride = 1     propranolol = 2
load('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis_with_logreg\drug_coding.mat')

% placebo
placebo_ind = find(drug_coding(1:num_part,2)==0);

% amisulpride
amisulpride_ind = find(drug_coding(1:num_part,2)==1);

% propranolol
propranolol_ind = find(drug_coding(1:num_part,2)==2);

%% Data

gamma_mat_UCB_short = [all_parameters_UCB_noveltybonus(placebo_ind,1), all_parameters_UCB_noveltybonus(amisulpride_ind,1), all_parameters_UCB_noveltybonus(propranolol_ind,1)];
gamma_mat_UCB_long = [all_parameters_UCB_noveltybonus(placebo_ind,2), all_parameters_UCB_noveltybonus(amisulpride_ind,2), all_parameters_UCB_noveltybonus(propranolol_ind,2)];
gamma_mat_UCB = [gamma_mat_UCB_short gamma_mat_UCB_long];
tau_mat_UCB_short = [all_parameters_UCB_noveltybonus(placebo_ind,3), all_parameters_UCB_noveltybonus(amisulpride_ind,3), all_parameters_UCB_noveltybonus(propranolol_ind,3)];
tau_mat_UCB_long = [all_parameters_UCB_noveltybonus(placebo_ind,4), all_parameters_UCB_noveltybonus(amisulpride_ind,4), all_parameters_UCB_noveltybonus(propranolol_ind,4)];
tau_mat_UCB = [tau_mat_UCB_short tau_mat_UCB_long];
xi_mat_UCB_short = [all_parameters_UCB_noveltybonus(placebo_ind,5), all_parameters_UCB_noveltybonus(amisulpride_ind,5), all_parameters_UCB_noveltybonus(propranolol_ind,5)];
xi_mat_UCB_long = [all_parameters_UCB_noveltybonus(placebo_ind,6), all_parameters_UCB_noveltybonus(amisulpride_ind,6), all_parameters_UCB_noveltybonus(propranolol_ind,6)];
xi_mat_UCB = [xi_mat_UCB_short xi_mat_UCB_long];
eta_mat_UCB = [all_parameters_UCB_noveltybonus(placebo_ind,7), all_parameters_UCB_noveltybonus(amisulpride_ind,7), all_parameters_UCB_noveltybonus(propranolol_ind,7)];



%% Figures

%%%%%%%%%%%%%%%% gamma %%%%%%%%%%%%%%%%
figure()

% Histogram
subplot(2,2,1)
hist(gamma_mat_UCB_short);
legend('Placebo', 'Amisulpride', 'Propranolol')
title('UCB - gamma short horizon ')
subplot(2,2,2)
hist(gamma_mat_UCB_long);
legend('Placebo', 'Amisulpride', 'Propranolol')
title('UCB - gamma long horizon ')

% Boxplot
subplot(2,2,3)
boxplot(gamma_mat_UCB_short);
title('UCB - gamma short horizon ')
xlabel('Placebo - Amisulpride - Propranolol')
subplot(2,2,4)
boxplot(gamma_mat_UCB_long);
xlabel('Placebo - Amisulpride - Propranolol')
title('UCB - gamma long horizon ') 


%%%%%%%%%%%%%%%% tau %%%%%%%%%%%%%%%%
figure()

% Histogram
subplot(2,2,1)
hist(tau_mat_UCB_short);
legend('Placebo', 'Amisulpride', 'Propranolol')
title('UCB - tau short horizon ')
subplot(2,2,2)
hist(tau_mat_UCB_long);
legend('Placebo', 'Amisulpride', 'Propranolol')
title('UCB - tau long horizon ')

% Boxplot
subplot(2,2,3)
boxplot(tau_mat_UCB_short);
title('UCB - tau short horizon ')
xlabel('Placebo - Amisulpride - Propranolol')
subplot(2,2,4)
boxplot(tau_mat_UCB_long);
xlabel('Placebo - Amisulpride - Propranolol')
title('UCB - tau long horizon ') 


%%%%%%%%%%%%%%%% xi %%%%%%%%%%%%%%%%
figure()

% Histogram
subplot(2,2,1)
hist(xi_mat_UCB_short);
legend('Placebo', 'Amisulpride', 'Propranolol')
title('UCB - xi short horizon ')
subplot(2,2,2)
hist(xi_mat_UCB_long);
legend('Placebo', 'Amisulpride', 'Propranolol')
title('UCB - xi long horizon ')

% Boxplot
subplot(2,2,3)
boxplot(xi_mat_UCB_short);
title('UCB - xi short horizon ')
xlabel('Placebo - Amisulpride - Propranolol')
subplot(2,2,4)
boxplot(xi_mat_UCB_long);
xlabel('Placebo - Amisulpride - Propranolol')
title('UCB - xi long horizon ') 

%%%%%%%%%%%%%%%% eta %%%%%%%%%%%%%%%%
figure()

% Histogram
subplot(2,1,1)
hist(eta_mat_UCB);
legend('Placebo', 'Amisulpride', 'Propranolol')
title('UCB - eta')

% Boxplot
subplot(2,1,2)
boxplot(eta_mat_UCB);
title('UCB - eta')
xlabel('Placebo - Amisulpride - Propranolol')

