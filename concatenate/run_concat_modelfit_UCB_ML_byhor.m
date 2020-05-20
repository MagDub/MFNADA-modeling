
num_part = 60; 

optim_algo = 'fmincon';

[all_parameters_UCB] = concatenate_all_params_UCB_byhor(num_part);

gamma_mat_UCB_short = [all_parameters_UCB(:,1)];
gamma_mat_UCB_long = [all_parameters_UCB(:,2)];
gamma_mat_UCB = [gamma_mat_UCB_short gamma_mat_UCB_long];
tau_mat_UCB_short = [all_parameters_UCB(:,3)];
tau_mat_UCB_long = [all_parameters_UCB(:,4)];
tau_mat_UCB = [tau_mat_UCB_short tau_mat_UCB_long];
xi_mat_UCB_short = [all_parameters_UCB(:,5)];
xi_mat_UCB_long = [all_parameters_UCB(:,6)];
xi_mat_UCB = [xi_mat_UCB_short xi_mat_UCB_long];

% remove the tau outlier
disp('outlier number ');
disp(size(find(tau_mat_UCB(:,1)>5)));
% 
% gamma_mat_UCB(find(tau_mat_UCB(:,1)>5),:)=[];
% xi_mat_UCB(find(tau_mat_UCB(:,1)>5),:)=[];
% tau_mat_UCB(find(tau_mat_UCB(:,1)>5),:)=[];


figure()

%% Histograms

%%%%%%%%%%%%%%%% gamma %%%%%%%%%%%%%%%%
subplot(1,3,1)

% histogram of parameters split by horizon

hist(gamma_mat_UCB, 10, 'Normalization', 'pdf');
legend('Short Horizon', 'Long Horizon')
title('UCB - gamma')
 
%%%%%%%%%%%%%%%% tau %%%%%%%%%%%%%%%%
subplot(1,3,2)

% histogram of parameters split by horizon

hist(tau_mat_UCB, 10, 'Normalization', 'pdf');
legend('Short Horizon', 'Long Horizon')
title('UCB - tau')

%%%%%%%%%%%%%%%% xi %%%%%%%%%%%%%%%%
subplot(1,3,3)

% histogram of parameters split by horizon

hist(xi_mat_UCB, 10, 'Normalization', 'pdf');
legend('Short Horizon', 'Long Horizon')
title('UCB - xi')



% %% Boxplots
% 
% %%%%%%%%%%%%%%%% gamma %%%%%%%%%%%%%%%%
% subplot(2,3,4)
% boxplot(gamma_mat_UCB);
% title('UCB - gamma')
% xticklabels({'Short Hor','Long Hor'})
% 
% %%%%%%%%%%%%%%%% tau %%%%%%%%%%%%%%%%
% subplot(2,3,5)
% boxplot(tau_mat_UCB);
% title('UCB - tau')
% xticklabels({'Short Hor','Long Hor'})
% 
% %%%%%%%%%%%%%%%% xi %%%%%%%%%%%%%%%%
% subplot(2,3,6)
% boxplot(xi_mat_UCB);
% title('UCB - xi')
% xticklabels({'Short Hor','Long Hor'})
