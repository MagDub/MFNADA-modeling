
optim_algo = 'genetic'; % The optimisation algorithm can be: 'genetic' or 'fmincon'

% THOMPSON
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% param_bounds_xi = [0.01,0.5];
% param_bounds_sgm0 = [1,10]; 
% param_bounds_Q0 = [0.1,10]; 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% UCB
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% param_bounds_gamma = [0.01,3]; % information bonus
% param_bounds_tau = [0.1,4]; % inverse temperature
% param_bounds_xi = [0.01,0.5]; % epsilon greedy
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% LA ON A CHANGE BORNES DE XI

% 
% parfor i=501:560
%     optim_algo = 'genetic';
%     fit_UCB_3param_hor11(i,optim_algo)
%     fit_UCB_3param_hor6(i,optim_algo)
%     optim_algo = 'genetic';
%     fit_thompson_3param_hor11(i, optim_algo)
%     fit_thompson_3param_hor6(i, optim_algo)
%     optim_algo = 'fmincon';
%     fit_UCB_3param_hor11(i,optim_algo)
%     fit_UCB_3param_hor6(i,optim_algo)
%     optim_algo = 'fmincon';
%     fit_thompson_3param_hor11(i, optim_algo)
%     fit_thompson_3param_hor6(i, optim_algo)
% end
 

%[all_parameters_UCB,all_parameters_thompson] = concatenate_all_params(optim_algo);

% % if by horizon
[all_parameters_UCB_hor11,all_parameters_thompson_hor11] = concatenate_all_params_hor11(optim_algo);
[all_parameters_UCB_hor6,all_parameters_thompson_hor6] = concatenate_all_params_hor6(optim_algo);
all_parameters_UCB = [all_parameters_UCB_hor11 all_parameters_UCB_hor6];
all_parameters_thompson = [all_parameters_thompson_hor11 all_parameters_thompson_hor6];
 
%%% UCB
figure()
subplot(1,3,1)
boxplot([all_parameters_UCB(:,1) all_parameters_UCB(:,4)])
xlabel('Hor 11, Hor 6')
title('UCB gamma')

subplot(1,3,2)
boxplot([all_parameters_UCB(:,2) all_parameters_UCB(:,5)])
xlabel('Hor 11, Hor 6')
title('UCB tau')

subplot(1,3,3)
boxplot([all_parameters_UCB(:,3) all_parameters_UCB(:,6)])
xlabel('Hor 11, Hor 6')
title('UCB xi')

%%% thompson
figure()
subplot(1,3,1)
boxplot([all_parameters_thompson(:,1) all_parameters_thompson(:,4)])
xlabel('Hor 11, Hor 6')
title('thompson Q0')

subplot(1,3,2)
boxplot([all_parameters_thompson(:,2) all_parameters_thompson(:,5)])
xlabel('Hor 11, Hor 6')
title('thompson sgm0')

subplot(1,3,3)
boxplot([all_parameters_thompson(:,3) all_parameters_thompson(:,6)])
xlabel('Hor 11, Hor 6')
title('thompson xi')

% Load drug coding - placebo = 0	amisulpride = 1     propranolol = 2
load('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis_with_logreg\drug_coding.mat')

% placebo
placebo_ind = find(drug_coding(:,2)==0);

% amisulpride
amisulpride_ind = find(drug_coding(:,2)==1);

% propanolol
propanolol_ind = find(drug_coding(:,2)==2);

% Create matrices for each parameters split by drug group

%%%%%%%% thompson %%%%%%%%

% hor 11
Q0_mat_thompson_hor11 = [all_parameters_thompson_hor11(placebo_ind,1), all_parameters_thompson_hor11(amisulpride_ind,1), all_parameters_thompson_hor11(propanolol_ind ,1)];
sgm0_mat_thompson_hor11 = [all_parameters_thompson_hor11(placebo_ind,2), all_parameters_thompson_hor11(amisulpride_ind,2), all_parameters_thompson_hor11(propanolol_ind ,2)];
xi_mat_thompson_hor11 = [all_parameters_thompson_hor11(placebo_ind,3), all_parameters_thompson_hor11(amisulpride_ind,3), all_parameters_thompson_hor11(propanolol_ind ,3)];

% hor 6
Q0_mat_thompson_hor6 = [all_parameters_thompson_hor6(placebo_ind,1), all_parameters_thompson_hor6(amisulpride_ind,1), all_parameters_thompson_hor6(propanolol_ind ,1)];
sgm0_mat_thompson_hor6 = [all_parameters_thompson_hor6(placebo_ind,2), all_parameters_thompson_hor6(amisulpride_ind,2), all_parameters_thompson_hor6(propanolol_ind ,2)];
xi_mat_thompson_hor6 = [all_parameters_thompson_hor6(placebo_ind,3), all_parameters_thompson_hor6(amisulpride_ind,3), all_parameters_thompson_hor6(propanolol_ind ,3)];

Q0_mat_thompson = [Q0_mat_thompson_hor11 Q0_mat_thompson_hor6];
sgm0_mat_thompson = [sgm0_mat_thompson_hor11 sgm0_mat_thompson_hor6];
xi_mat_thompson = [xi_mat_thompson_hor11 xi_mat_thompson_hor6];

%%%%%%%% UCB %%%%%%%%

% hor 11
gamma_mat_UCB_hor11 = [all_parameters_UCB_hor11(placebo_ind,1), all_parameters_UCB_hor11(amisulpride_ind,1), all_parameters_UCB_hor11(propanolol_ind ,1)];
tau_mat_UCB_hor11 = [all_parameters_UCB_hor11(placebo_ind,2), all_parameters_UCB_hor11(amisulpride_ind,2), all_parameters_UCB_hor11(propanolol_ind ,2)];
xi_mat_UCB_hor11 = [all_parameters_UCB_hor11(placebo_ind,3), all_parameters_UCB_hor11(amisulpride_ind,3), all_parameters_UCB_hor11(propanolol_ind ,3)];

% hor 6
gamma_mat_UCB_hor6 = [all_parameters_UCB_hor6(placebo_ind,1), all_parameters_UCB_hor6(amisulpride_ind,1), all_parameters_UCB_hor6(propanolol_ind ,1)];
tau_mat_UCB_hor6 = [all_parameters_UCB_hor6(placebo_ind,2), all_parameters_UCB_hor6(amisulpride_ind,2), all_parameters_UCB_hor6(propanolol_ind ,2)];
xi_mat_UCB_hor6 = [all_parameters_UCB_hor6(placebo_ind,3), all_parameters_UCB_hor6(amisulpride_ind,3), all_parameters_UCB_hor6(propanolol_ind ,3)];

gamma_mat_UCB = [gamma_mat_UCB_hor11 gamma_mat_UCB_hor6];
tau_mat_UCB = [tau_mat_UCB_hor11 tau_mat_UCB_hor6];
xi_mat_UCB = [xi_mat_UCB_hor11 xi_mat_UCB_hor6];


% Thompson

figure()

subplot(1,3,1)
boxplot(Q0_mat_thompson)
xlabel('placebo - amisulpride - propanolol')
title('Thompson - Q0')

subplot(1,3,2)
boxplot(sgm0_mat_thompson)
xlabel('placebo - amisulpride - propanolol')
title('Thompson - sgm0')

subplot(1,3,3)
boxplot(xi_mat_thompson)
xlabel('placebo - amisulpride - propanolol')
title('Thompson - xi')

% UCB

figure()

subplot(1,3,1)
boxplot(gamma_mat_UCB)
xlabel('placebo - amisulpride - propanolol')
title('UCB - Gamma')

subplot(1,3,2)
boxplot(tau_mat_UCB)
xlabel('placebo - amisulpride - propanolol')
title('UCB - Tau')

subplot(1,3,3)
boxplot(xi_mat_UCB)
xlabel('placebo - amisulpride - propanolol')
title('UCB - xi')

