
num_part = 60; 

optim_algo = 'fmincon';

[all_parameters_hybrid] = concatenate_all_params_hybrid_byhor_3paramsnoveltybonus2Hor(num_part);

gamma_mat_hybrid_short = [all_parameters_hybrid(:,1)];
gamma_mat_hybrid_long = [all_parameters_hybrid(:,2)];
gamma_mat_hybrid = [gamma_mat_hybrid_short gamma_mat_hybrid_long];
tau_mat_hybrid_short = [all_parameters_hybrid(:,3)];
tau_mat_hybrid_long = [all_parameters_hybrid(:,4)];
tau_mat_hybrid = [tau_mat_hybrid_short tau_mat_hybrid_long];
eta_mat_hybrid = [all_parameters_hybrid(:,5)];
w_mat_hybrid_short = [all_parameters_hybrid(:,6)];
w_mat_hybrid_long = [all_parameters_hybrid(:,7)];
w_mat_hybrid = [w_mat_hybrid_short w_mat_hybrid_long];

% remove the tau outlier
% gamma_mat_hybrid(find(all_parameters_hybrid(:,2)>5),:)=[];
% tau_mat_hybrid(find(all_parameters_hybrid(:,2)>5),:)=[];
% xi_mat_hybrid(find(all_parameters_hybrid(:,2)>5),:)=[];

%% Histograms

%%%%%%%%%%%%%%%% gamma %%%%%%%%%%%%%%%%
subplot(1,5,1)

% histogram of parameters split by horizon

hist(gamma_mat_hybrid, 10, 'Normalization', 'pdf');
legend('Short Horizon', 'Long Horizon')
title('hybrid - gamma')
 
%%%%%%%%%%%%%%%% tau %%%%%%%%%%%%%%%%
subplot(1,5,2)

% histogram of parameters split by horizon

hist(tau_mat_hybrid, 10, 'Normalization', 'pdf');
legend('Short Horizon', 'Long Horizon')
title('hybrid - tau')

%%%%%%%%%%%%%%%% xi %%%%%%%%%%%%%%%%
subplot(1,5,3)

% histogram of parameters split by horizon

hist(xi_mat_hybrid, 10, 'Normalization', 'pdf');
legend('Short Horizon', 'Long Horizon')
title('hybrid - xi')

%%%%%%%%%%%%%%%% sgm0 %%%%%%%%%%%%%%%%
subplot(1,5,4)

% histogram of parameters split by horizon

hist(sgm0_mat_hybrid, 16, 'Normalization', 'pdf');
title('hybrid - sgm0')
 

%%%%%%%%%%%%%%%% w %%%%%%%%%%%%%%%%
subplot(1,5,5)

% histogram of parameters split by horizon

hist(xi_mat_hybrid, 10, 'Normalization', 'pdf');
legend('Short Horizon', 'Long Horizon')
title('hybrid - w')

