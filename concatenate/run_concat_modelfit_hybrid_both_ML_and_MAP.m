
num_part = 60; 

optim_algo = 'fmincon';

[all_parameters_hybrid] = concatenate_all_params_hybrid_prior(num_part);

gamma_mat_hybrid_ML = [all_parameters_hybrid(:,1)];
tau_mat_hybrid_ML = [all_parameters_hybrid(:,2)];
xi_mat_hybrid_ML = [all_parameters_hybrid(:,3)];
sgm0_mat_hybrid_ML = [all_parameters_hybrid(:,4)];
w_mat_hybrid_ML = [all_parameters_hybrid(:,5)];



figure()

%%%%%%%%%%%%%%%% gamma %%%%%%%%%%%%%%%%

subplot(2,5,1)

% histogram of parameters
h1=histogram(gamma_mat_hybrid_ML, 10, 'Normalization', 'pdf'); hold on;

% fit distribution to a normal distrib and plot it
pd_data_gamma_ML=fitdist(gamma_mat_hybrid_ML, 'Normal'); disp(pd_data_gamma_ML);
x=0:0.01:10;
d_fitted=plot(x,pdf(pd_data_gamma_ML,x), 'LineWidth', 2, 'MarkerSize', 6); hold on;

leg1 = strcat('fitted distribution (mean:',32,num2str(pd_data_gamma_ML.mu,2), ', sigma:',32,num2str(pd_data_gamma_ML.sigma,2),')');
legend([d_fitted],{leg1})
title('hybrid - gamma')
 

%%%%%%%%%%%%%%%% tau %%%%%%%%%%%%%%%%
subplot(2,5,2)

% histogram of parameters
h1=histogram(tau_mat_hybrid_ML, 10, 'Normalization', 'pdf'); hold on;

% fit distribution to a normal distrib and plot it
pd_data_tau_ML=fitdist(tau_mat_hybrid_ML, 'Normal'); disp(pd_data_tau_ML);
x=0:0.1:6;
d_fitted=plot(x,pdf(pd_data_tau_ML,x), 'LineWidth', 2, 'MarkerSize', 6); hold on;

leg1 = strcat('fitted distribution (mean:',32,num2str(pd_data_tau_ML.mu,2), ', sigma:',32,num2str(pd_data_tau_ML.sigma,2),')');
legend([d_fitted],{leg1})
title('hybrid - tau')


%%%%%%%%%%%%%%%% xi %%%%%%%%%%%%%%%%
subplot(2,5,3)

h1=histogram(xi_mat_hybrid_ML, 10, 'Normalization', 'pdf'); hold on;
x=0:0.01:0.5; 
%pd_data_gamma=fitdist(xi_mat_hybrid, 'Gamma'); disp(pd_data_gamma)
pd_data_beta_ML=fitdist(xi_mat_hybrid_ML, 'Beta'); disp(pd_data_beta_ML)
%h2=plot(x, pdf(pd_data_gamma, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
h3=plot(x, pdf(pd_data_beta_ML, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
%leg1 = 'Gamma distribution fitted to data';
leg2 = 'Beta distribution fitted to data';
%legend([h2, h3],{leg1, leg2})
legend([h3],{leg2})
title('hybrid - xi')


%%%%%%%%%%%%%%%% sgm0 %%%%%%%%%%%%%%%%
subplot(2,5,4)

% histogram of parameters
h1=histogram(sgm0_mat_hybrid_ML, 10, 'Normalization', 'pdf'); hold on;

% fit distribution to a normal distrib and plot it
pd_data_sgm0_ML=fitdist(sgm0_mat_hybrid_ML, 'Normal'); disp(pd_data_sgm0_ML);
x=0:0.1:6;
d_fitted=plot(x,pdf(pd_data_sgm0_ML,x), 'LineWidth', 2, 'MarkerSize', 6); hold on;

% real distribution of sgm0
mu_real = 1.4;
sigma_real = 1; 
d_real=plot(x,normpdf(x,mu_real,sigma_real),'LineWidth', 2);
leg1 = strcat('fitted distribution (mean:',32,num2str(pd_data_sgm0_ML.mu,2), ', sigma:',32,num2str(pd_data_sgm0_ML.sigma,2),')');
leg2 = strcat('theoretical distribution (mean:',32,num2str(mu_real,2), ', sigma:',32,num2str(sigma_real,2),')');
legend([d_fitted,d_real],{leg1, leg2})
title('hybrid - sgm0')


%%%%%%%%%%%%%%%% w %%%%%%%%%%%%%%%%
subplot(2,5,5)

h1=histogram(w_mat_hybrid_ML, 10, 'Normalization', 'pdf'); hold on;
x=0:0.01:1; 
%pd_data_beta=fitdist(w_mat_hybrid, 'Beta'); disp(pd_data_beta)
%h3=plot(x, pdf(pd_data_beta, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
%leg2 = 'Beta distribution fitted to data';
%legend([h3],{leg2})
title('hybrid - w')


%% MAP vs MLE

[all_parameters_hybrid] = concatenate_all_params_hybrid_MAP_prior(num_part);

gamma_mat_hybrid_MAP = [all_parameters_hybrid(:,1)];
tau_mat_hybrid_MAP = [all_parameters_hybrid(:,2)];
xi_mat_hybrid_MAP = [all_parameters_hybrid(:,3)];
sgm0_mat_hybrid_MAP = [all_parameters_hybrid(:,4)];
w_mat_hybrid_MAP = [all_parameters_hybrid(:,5)];


%%%%%%%%%%%%%%%% gamma %%%%%%%%%%%%%%%%

subplot(2,5,6)

% histogram of parameters
h1=histogram(gamma_mat_hybrid_MAP, 10, 'Normalization', 'pdf'); hold on;

% fit distribution to a normal distrib and plot it
pd_data_gamma_MAP=fitdist(gamma_mat_hybrid_MAP, 'Normal'); disp(pd_data_gamma_MAP);
x=0:0.01:10;
d_fitted=plot(x,pdf(pd_data_gamma_MAP,x), 'LineWidth', 2, 'MarkerSize', 6); hold on;

leg1 = strcat('fitted distribution (mean:',32,num2str(pd_data_gamma_MAP.mu,2), ', sigma:',32,num2str(pd_data_gamma_MAP.sigma,2),')');
legend([d_fitted],{leg1})
title('hybrid - gamma')
 

%%%%%%%%%%%%%%%% tau %%%%%%%%%%%%%%%%
subplot(2,5,7)

% histogram of parameters
h1=histogram(tau_mat_hybrid_MAP, 10, 'Normalization', 'pdf'); hold on;

% fit distribution to a normal distrib and plot it
pd_data_tau_MAP=fitdist(tau_mat_hybrid_MAP, 'Normal'); disp(pd_data_tau_MAP);
x=0:0.1:6;
d_fitted=plot(x,pdf(pd_data_tau_MAP,x), 'LineWidth', 2, 'MarkerSize', 6); hold on;

leg1 = strcat('fitted distribution (mean:',32,num2str(pd_data_tau_MAP.mu,2), ', sigma:',32,num2str(pd_data_tau_MAP.sigma,2),')');
legend([d_fitted],{leg1})
title('hybrid - tau')


%%%%%%%%%%%%%%%% xi %%%%%%%%%%%%%%%%
subplot(2,5,8)

h1=histogram(xi_mat_hybrid_MAP, 10, 'Normalization', 'pdf'); hold on;
x=0:0.01:0.5; 
%pd_data_gamma=fitdist(xi_mat_hybrid, 'Gamma'); disp(pd_data_gamma)
pd_data_beta_MAP=fitdist(xi_mat_hybrid_MAP, 'Beta'); disp(pd_data_beta_MAP)
%h2=plot(x, pdf(pd_data_gamma, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
h3=plot(x, pdf(pd_data_beta_MAP, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
%leg1 = 'Gamma distribution fitted to data';
leg2 = 'Beta distribution fitted to data';
%legend([h2, h3],{leg1, leg2})
legend([h3],{leg2})
title('hybrid - xi')


%%%%%%%%%%%%%%%% sgm0 %%%%%%%%%%%%%%%%
subplot(2,5,9)

% histogram of parameters
h1=histogram(sgm0_mat_hybrid_MAP, 10, 'Normalization', 'pdf'); hold on;

% fit distribution to a normal distrib and plot it
pd_data_sgm0_MAP=fitdist(sgm0_mat_hybrid_MAP, 'Normal'); disp(pd_data_sgm0_MAP);
x=0:0.1:6;
d_fitted=plot(x,pdf(pd_data_sgm0_MAP,x), 'LineWidth', 2, 'MarkerSize', 6); hold on;

% real distribution of sgm0
mu_real = 1.4;
sigma_real = 1; 
d_real=plot(x,normpdf(x,mu_real,sigma_real),'LineWidth', 2);
leg1 = strcat('fitted distribution (mean:',32,num2str(pd_data_sgm0_MAP.mu,2), ', sigma:',32,num2str(pd_data_sgm0_MAP.sigma,2),')');
leg2 = strcat('theoretical distribution (mean:',32,num2str(mu_real,2), ', sigma:',32,num2str(sigma_real,2),')');
legend([d_fitted,d_real],{leg1, leg2})
title('hybrid - sgm0')


%%%%%%%%%%%%%%%% w %%%%%%%%%%%%%%%%
subplot(2,5,10)

h1=histogram(w_mat_hybrid_MAP, 10, 'Normalization', 'pdf'); hold on;
x=0:0.01:1; 
pd_data_w_MAP=fitdist(w_mat_hybrid, 'Normal'); disp(pd_data_w_MAP)
h3=plot(x, pdf(pd_data_w_MAP, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
leg2 = 'Normal distribution fitted to data';
legend([h3],{leg2})
title('hybrid - w')



%% MLE vs MAP

figure()

ucb_priors = load('D:\MaggiesFarm\modeling_28_02\participant_data\priors\UCB_3params\empirical_prior.mat');

subplot(1,5,1)
x=0:0.01:5;
mu_real = ucb_priors.prior(1).pd.mu;
sigma_real = ucb_priors.prior(1).pd.sigma; 
plot(x, normpdf(x,mu_real,sigma_real), 'LineWidth', 2, 'MarkerSize', 6); hold on;
plot(x, pdf(pd_data_gamma_MAP, x), 'LineWidth', 2, 'MarkerSize', 6); 
title('Gamma')
legend('Empirical prior (from UCB)', 'Posterior')

subplot(1,5,2)
x=0:0.01:4;
mu_real = ucb_priors.prior(2).pd.mu;
sigma_real = ucb_priors.prior(2).pd.sigma; 
plot(x, normpdf(x,mu_real,sigma_real), 'LineWidth', 2, 'MarkerSize', 6); hold on;
plot(x, pdf(pd_data_tau_MAP, x), 'LineWidth', 2, 'MarkerSize', 6); 
title('Tau')
legend('Empirical prior (from UCB)', 'Posterior')

subplot(1,5,3)
x=0:0.01:4;
mu_real = 1.4;
sigma_real = 1; 
plot(x, normpdf(x,mu_real,sigma_real), 'LineWidth', 2, 'MarkerSize', 6); hold on;
plot(x, pdf(pd_data_sgm0_MAP, x), 'LineWidth', 2, 'MarkerSize', 6); 
title('sgm0')
legend('Theoretical prior', 'Posterior')

subplot(1,5,4)
x=0:0.01:0.45;
plot(x, pdf(pd_data_beta_ML, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
plot(x, pdf(pd_data_beta_MAP, x), 'LineWidth', 2, 'MarkerSize', 6); 
title('Xi')
legend('Empirical prior', 'Posterior')

subplot(1,5,5)
x=0:0.01:1;
pd_data_uni = makedist('Uniform','lower',0,'upper',1);
plot(x, pdf(pd_data_uni, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
plot(x, pdf(pd_data_w_MAP, x), 'LineWidth', 2, 'MarkerSize', 6); 
title('w')
legend('Theoretical prior', 'Posterior')


x0 = 200;
y0 = 200;
width = 900;
height = 500;
set(gcf,'position',[x0,y0,width,height])

