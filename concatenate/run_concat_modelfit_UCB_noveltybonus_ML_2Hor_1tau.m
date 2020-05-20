
num_part = 60; 

optim_algo = 'fmincon';

[all_parameters_UCB_noveltybonus] = concatenate_all_params_UCB_noveltybonus_byhor_2Hor_1tau(num_part);

gamma_mat_UCB_short = [all_parameters_UCB_noveltybonus(:,1)];
gamma_mat_UCB_long = [all_parameters_UCB_noveltybonus(:,2)];
gamma_mat_UCB = [gamma_mat_UCB_short gamma_mat_UCB_long];
tau_mat_UCB = [all_parameters_UCB_noveltybonus(:,3)];
xi_mat_UCB_short = [all_parameters_UCB_noveltybonus(:,4)];
xi_mat_UCB_long = [all_parameters_UCB_noveltybonus(:,5)];
xi_mat_UCB = [xi_mat_UCB_short xi_mat_UCB_long];
eta_mat_UCB = [all_parameters_UCB_noveltybonus(:,6)];

figure()

%% Histograms

%%%%%%%%%%%%%%%% gamma %%%%%%%%%%%%%%%%
subplot(1,4,1)

% histogram of parameters split by horizon

hist(gamma_mat_UCB, 10, 'Normalization', 'pdf');
legend('Short Horizon', 'Long Horizon')
title('UCB - gamma')
 
%%%%%%%%%%%%%%%% tau %%%%%%%%%%%%%%%%
subplot(1,4,2)

% histogram of parameters split by horizon

hist(tau_mat_UCB, 10, 'Normalization', 'pdf');
legend('Short Horizon', 'Long Horizon')
title('UCB - tau')

%%%%%%%%%%%%%%%% xi %%%%%%%%%%%%%%%%
subplot(1,4,3)

% histogram of parameters split by horizon

hist(xi_mat_UCB, 10, 'Normalization', 'pdf');
legend('Short Horizon', 'Long Horizon')
title('UCB - xi')

%%%%%%%%%%%%%%%% eta %%%%%%%%%%%%%%%%
subplot(1,4,4)

% histogram of parameters split by horizon

hist(eta_mat_UCB, 10, 'Normalization', 'pdf');
legend('Short Horizon', 'Long Horizon')
title('UCB - eta')



%% Boxplots
figure()

%%%%%%%%%%%%%%%% gamma %%%%%%%%%%%%%%%%
subplot(1,4,1)
boxplot(gamma_mat_UCB);
title('UCB - gamma')
xticklabels({'Short Hor','Long Hor'})

%%%%%%%%%%%%%%%% tau %%%%%%%%%%%%%%%%
subplot(1,4,2)
boxplot(tau_mat_UCB);
title('UCB - tau')
xticklabels({'Short Hor','Long Hor'})

%%%%%%%%%%%%%%%% xi %%%%%%%%%%%%%%%%
subplot(1,4,3)
boxplot(xi_mat_UCB);
title('UCB - xi')
xticklabels({'Short Hor','Long Hor'})

%%%%%%%%%%%%%%%% eta %%%%%%%%%%%%%%%%
subplot(1,4,4)
boxplot(eta_mat_UCB);
title('UCB - eta')
xticklabels({'Short Hor','Long Hor'})
