
num_part = 60; 

optim_algo = 'fmincon';

[all_parameters_UCB] = concatenate_all_params_UCB_prior(num_part);

gamma_mat_UCB_ML = [all_parameters_UCB(:,1)];
tau_mat_UCB_ML = [all_parameters_UCB(:,2)];
xi_mat_UCB_ML = [all_parameters_UCB(:,3)];

% % remove the tau outlier
% gamma_mat_UCB(find(all_parameters_UCB(:,2)>5),:)=[];
% tau_mat_UCB(find(all_parameters_UCB(:,2)>5),:)=[];
% xi_mat_UCB(find(all_parameters_UCB(:,2)>5),:)=[];


figure()

%% ML

%%%%%%%%%%%%%%%% gamma %%%%%%%%%%%%%%%%

subplot(2,3,1)

% histogram of parameters
h1=histogram(gamma_mat_UCB_ML, 10, 'Normalization', 'pdf'); hold on;

% fit distrib to a normal distrib and plot it
pd_data_gamma_ML=fitdist(gamma_mat_UCB_ML, 'Normal'); disp(pd_data_gamma_ML);
x=0:0.01:4;
d_fitted=plot(x,pdf(pd_data_gamma_ML,x), 'LineWidth', 2, 'MarkerSize', 6); hold on;

leg1 = strcat('fitted distrib (mean:',32,num2str(pd_data_gamma_ML.mu,2), ', sigma:',32,num2str(pd_data_gamma_ML.sigma,2),')');
legend([d_fitted],{leg1})
title('ML - UCB - gamma')
 

%%%%%%%%%%%%%%%% tau %%%%%%%%%%%%%%%%
subplot(2,3,2)

% histogram of parameters
h1=histogram(tau_mat_UCB_ML, 12, 'Normalization', 'pdf'); hold on;

% fit distrib to a normal distrib and plot it
pd_data_tau_ML=fitdist(tau_mat_UCB_ML, 'Normal'); disp(pd_data_tau_ML);
x=0:0.1:7;
d_fitted=plot(x,pdf(pd_data_tau_ML,x), 'LineWidth', 2, 'MarkerSize', 6); hold on;


leg1 = strcat('fitted distrib (mean:',32,num2str(pd_data_tau_ML.mu,2), ', sigma:',32,num2str(pd_data_tau_ML.sigma,2),')');
legend([d_fitted],{leg1})
ylim([0 1.5])
xlim([0 7])
title('ML - UCB - tau')


%%%%%%%%%%%%%%%% xi %%%%%%%%%%%%%%%%
subplot(2,3,3)

h1=histogram(xi_mat_UCB_ML, 10, 'Normalization', 'pdf'); hold on;
x=0:0.01:0.5; 
%pd_data_gamma=fitdist(xi_mat_UCB, 'Gamma'); disp(pd_data_gamma)
pd_data_beta_ML=fitdist(xi_mat_UCB_ML, 'Beta'); disp(pd_data_beta_ML)
%h2=plot(x, pdf(pd_data_gamma, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
h3=plot(x, pdf(pd_data_beta_ML, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
%leg1 = 'Gamma distrib fitted to data';
leg2 = 'Beta distrib fitted to data';
%legend([h2, h3],{leg1, leg2})
legend([h3],{leg2})
title('ML - UCB - xi')
ylim([0 20])



%% MAP

[all_parameters_UCB] = concatenate_all_params_UCB_MAP_prior(num_part);

gamma_mat_UCB_MAP = [all_parameters_UCB(:,1)];
tau_mat_UCB_MAP= [all_parameters_UCB(:,2)];
xi_mat_UCB_MAP = [all_parameters_UCB(:,3)];

% % remove the tau outlier
% gamma_mat_UCB(find(all_parameters_UCB(:,2)>5),:)=[];
% tau_mat_UCB(find(all_parameters_UCB(:,2)>5),:)=[];
% xi_mat_UCB(find(all_parameters_UCB(:,2)>5),:)=[];


%%%%%%%%%%%%%%%% gamma %%%%%%%%%%%%%%%%

subplot(2,3,4)

% histogram of parameters
h1=histogram(gamma_mat_UCB_MAP, 10, 'Normalization', 'pdf'); hold on;

% fit distrib to a normal distrib and plot it
pd_data_gamma_MAP=fitdist(gamma_mat_UCB_MAP, 'Normal'); disp(pd_data_gamma_MAP);
x=0:0.01:4;
d_fitted=plot(x,pdf(pd_data_gamma_MAP,x), 'LineWidth', 2, 'MarkerSize', 6); hold on;

%leg1 = strcat('fitted distrib (mean:',32,num2str(pd_data.mu,2), ', sigma:',32,num2str(pd_data.sigma,2),')');
%legend([d_fitted],{leg1})
title('MAP - UCB - gamma')
 

%%%%%%%%%%%%%%%% tau %%%%%%%%%%%%%%%%
subplot(2,3,5)

% histogram of parameters
h1=histogram(tau_mat_UCB_MAP, 5, 'Normalization', 'pdf'); hold on;

% fit distrib to a normal distrib and plot it
pd_data_tau_MAP=fitdist(tau_mat_UCB_MAP, 'Normal'); disp(pd_data_tau_MAP);
x=0:0.1:7;
d_fitted=plot(x,pdf(pd_data_tau_MAP,x), 'LineWidth', 2, 'MarkerSize', 6); hold on;

%leg1 = strcat('fitted distrib (mean:',32,num2str(pd_data.mu,2), ', sigma:',32,num2str(pd_data.sigma,2),')');
%legend([d_fitted],{leg1})
ylim([0 1.5])
xlim([0 7])
title('MAP - UCB - tau')


%%%%%%%%%%%%%%%% xi %%%%%%%%%%%%%%%%
subplot(2,3,6)

h1=histogram(xi_mat_UCB_MAP, 10, 'Normalization', 'pdf'); hold on;
x=0:0.01:0.5; 
%pd_data_gamma=fitdist(xi_mat_UCB, 'Gamma'); disp(pd_data_gamma)
pd_data_beta_MAP=fitdist(xi_mat_UCB_MAP, 'Beta'); disp(pd_data_beta_MAP)
%h2=plot(x, pdf(pd_data_gamma, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
h3=plot(x, pdf(pd_data_beta_MAP, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
%leg1 = 'Gamma distrib fitted to data';
%leg2 = 'Beta distrib fitted to data';
%legend([h2, h3],{leg1, leg2})
%legend([h3],{leg2})
title('MAP - UCB - xi')
ylim([0 20])


%% MLE vs MAP
figure();
subplot(1,3,1)
x=0:0.01:5;
plot(x, pdf(pd_data_gamma_ML, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
plot(x, pdf(pd_data_gamma_MAP, x), 'LineWidth', 2, 'MarkerSize', 6); 
title('Gamma')
legend('Empirical prior', 'Posterior')

subplot(1,3,2)
x=0:0.01:4;
plot(x, pdf(pd_data_tau_ML, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
plot(x, pdf(pd_data_tau_MAP, x), 'LineWidth', 2, 'MarkerSize', 6); 
title('Tau')
legend('Empirical prior', 'Posterior')

subplot(1,3,3)
x=0:0.01:0.4;
plot(x, pdf(pd_data_beta_ML, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
plot(x, pdf(pd_data_beta_MAP, x), 'LineWidth', 2, 'MarkerSize', 6); 
title('Xi')
legend('Empirical prior', 'Posterior')

x0 = 200;
y0 = 200;
width = 900;
height = 500;
set(gcf,'position',[x0,y0,width,height])
