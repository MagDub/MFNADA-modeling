
num_part = 60; 

optim_algo = 'fmincon';

[all_parameters_thomp_noveltybonus] = concatenate_all_params_thomp_noveltybonus_1Hor(num_part);

sgm0_mat_UCB = [all_parameters_thomp_noveltybonus(:,1)];
Q0_mat_UCB = [all_parameters_thomp_noveltybonus(:,2)];
xi_mat_UCB = [all_parameters_thomp_noveltybonus(:,3)];
eta_mat_UCB = [all_parameters_thomp_noveltybonus(:,4)];

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
