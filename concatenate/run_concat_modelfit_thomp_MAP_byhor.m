
num_part = 60; 

optim_algo = 'fmincon';

[all_parameters_thompson] = concatenate_all_params_thompson_MAP_byhor(num_part);

sgm0_mat_thompson = [all_parameters_thompson(:,1)];
Q0_mat_thompson = [all_parameters_thompson(:,2)];
xi_mat_thompson_short = [all_parameters_thompson(:,3)];
xi_mat_thompson_long = [all_parameters_thompson(:,4)];
xi_mat_thompson = [xi_mat_thompson_short xi_mat_thompson_long];



figure()

%% Histograms

%%%%%%%%%%%%%%%% sgm0 %%%%%%%%%%%%%%%%
subplot(1,3,1)

% histogram of parameters split by horizon

hist(sgm0_mat_thompson, 16, 'Normalization', 'pdf'); 
%legend('Short Horizon', 'Long Horizon')
title('thompson - sgm0')
 
%%%%%%%%%%%%%%%% Q0 %%%%%%%%%%%%%%%%
subplot(1,3,2)

% histogram of parameters split by horizon

hist(Q0_mat_thompson, 16, 'Normalization', 'pdf');
%legend('Short Horizon', 'Long Horizon')
title('thompson - Q0')

%%%%%%%%%%%%%%%% xi %%%%%%%%%%%%%%%%
subplot(1,3,3)

% histogram of parameters split by horizon

hist(xi_mat_thompson, 10, 'Normalization', 'pdf');
legend('Short Horizon', 'Long Horizon')
title('thompson - xi')

% %% Boxplots
% 
% %%%%%%%%%%%%%%%% sgm0 %%%%%%%%%%%%%%%%
% subplot(2,3,4)
% boxplot(sgm0_mat_thompson);
% title('thompson - sgm0')
% xticklabels({'Short Hor','Long Hor'})
% 
% %%%%%%%%%%%%%%%% Q0 %%%%%%%%%%%%%%%%
% subplot(2,3,5)
% boxplot(Q0_mat_thompson);
% title('thompson - Q0')
% xticklabels({'Short Hor','Long Hor'})
% 
% %%%%%%%%%%%%%%%% xi %%%%%%%%%%%%%%%%
% subplot(2,3,6)
% boxplot(xi_mat_thompson);
% title('thompson - xi')
% xticklabels({'Short Hor','Long Hor'})
