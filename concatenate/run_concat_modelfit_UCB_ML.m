
num_part = 60; 

optim_algo = 'fmincon';

[all_parameters_UCB] = concatenate_all_params_UCB_prior(num_part);

gamma_mat_UCB = [all_parameters_UCB(:,1)];
tau_mat_UCB = [all_parameters_UCB(:,2)];
xi_mat_UCB = [all_parameters_UCB(:,3)];

% remove the tau outlier
gamma_mat_UCB(find(all_parameters_UCB(:,2)>5),:)=[];
tau_mat_UCB(find(all_parameters_UCB(:,2)>5),:)=[];
xi_mat_UCB(find(all_parameters_UCB(:,2)>5),:)=[];


figure()

%%%%%%%%%%%%%%%% gamma %%%%%%%%%%%%%%%%

subplot(1,3,1)

% histogram of parameters
h1=histogram(gamma_mat_UCB, 10, 'Normalization', 'pdf'); hold on;

% fit distribution to a normal distrib and plot it
pd_data=fitdist(gamma_mat_UCB, 'Normal'); disp(pd_data);
x=0:0.01:4;
d_fitted=plot(x,pdf(pd_data,x), 'LineWidth', 2, 'MarkerSize', 6); hold on;

leg1 = strcat('fitted distribution (mean:',32,num2str(pd_data.mu,2), ', sigma:',32,num2str(pd_data.sigma,2),')');
legend([d_fitted],{leg1})
title('UCB - gamma')
 

%%%%%%%%%%%%%%%% tau %%%%%%%%%%%%%%%%
subplot(1,3,2)

% histogram of parameters
h1=histogram(tau_mat_UCB, 12, 'Normalization', 'pdf'); hold on;

% fit distribution to a normal distrib and plot it
pd_data=fitdist(tau_mat_UCB, 'Normal'); disp(pd_data);
x=0:0.1:1.5;
d_fitted=plot(x,pdf(pd_data,x), 'LineWidth', 2, 'MarkerSize', 6); hold on;

leg1 = strcat('fitted distribution (mean:',32,num2str(pd_data.mu,2), ', sigma:',32,num2str(pd_data.sigma,2),')');
legend([d_fitted],{leg1})
title('UCB - tau')


%%%%%%%%%%%%%%%% xi %%%%%%%%%%%%%%%%
subplot(1,3,3)

h1=histogram(xi_mat_UCB, 10, 'Normalization', 'pdf'); hold on;
x=0:0.01:0.5; 
%pd_data_gamma=fitdist(xi_mat_UCB, 'Gamma'); disp(pd_data_gamma)
pd_data_beta=fitdist(xi_mat_UCB, 'Beta'); disp(pd_data_beta)
%h2=plot(x, pdf(pd_data_gamma, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
h3=plot(x, pdf(pd_data_beta, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
%leg1 = 'Gamma distribution fitted to data';
leg2 = 'Beta distribution fitted to data';
%legend([h2, h3],{leg1, leg2})
legend([h3],{leg2})
title('UCB - xi')



