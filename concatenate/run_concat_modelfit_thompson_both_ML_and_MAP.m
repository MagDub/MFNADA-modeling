
num_part = 60; 

optim_algo = 'fmincon';

[all_parameters_thompson] = concatenate_all_params_thompson_prior(num_part);

sgm0_mat_thompson_ML = [all_parameters_thompson(:,1)];
Q0_mat_thompson_ML = [all_parameters_thompson(:,2)];
xi_mat_thompson_ML = [all_parameters_thompson(:,3)];

figure()

%%%%%%%%%%%%%%%% Q0 %%%%%%%%%%%%%%%%

subplot(2,3,1)

% histogram of parameters
h1=histogram(Q0_mat_thompson_ML, 10, 'Normalization', 'pdf'); hold on;

% fit distribution to a normal distrib and plot it
pd_data_Q0_ML=fitdist(Q0_mat_thompson_ML, 'Normal'); disp(pd_data_Q0_ML);
x=1:0.1:10;
d_fitted=plot(x,pdf(pd_data_Q0_ML,x), 'LineWidth', 2, 'MarkerSize', 6); hold on;

% real distirbution of means
mu_real = 5;
sigma_real = 2; 
d_real=plot(x,normpdf(x,mu_real,sigma_real),'LineWidth', 2);
leg1 = strcat('fitted distribution (mean:',32,num2str(pd_data_Q0_ML.mu,2), ', sigma:',32,num2str(pd_data_Q0_ML.sigma,2),')');
leg2 = strcat('theoretical distribution (mean:',32,num2str(mu_real,2), ', sigma:',32,num2str(sigma_real,2),')');
legend([d_fitted,d_real],{leg1, leg2})
title('Thompson - Q0')
 

%%%%%%%%%%%%%%%% sgm0 %%%%%%%%%%%%%%%%
subplot(2,3,2)

% histogram of parameters
h1=histogram(sgm0_mat_thompson_ML, 12, 'Normalization', 'pdf'); hold on;

% fit distribution to a normal distrib and plot it
pd_data_sgm0_ML=fitdist(sgm0_mat_thompson_ML, 'Normal'); disp(pd_data_sgm0_ML);
x=0:0.1:4;
d_fitted=plot(x,pdf(pd_data_sgm0_ML,x), 'LineWidth', 2, 'MarkerSize', 6); hold on;

% real distribution of sgm0
mu_real = 1.4;
sigma_real = 1; 
d_real=plot(x,normpdf(x,mu_real,sigma_real),'LineWidth', 2);
leg1 = strcat('fitted distribution (mean:',32,num2str(pd_data_sgm0_ML.mu,2), ', sigma:',32,num2str(pd_data_sgm0_ML.sigma,2),')');
leg2 = strcat('theoretical distribution (mean:',32,num2str(mu_real,2), ', sigma:',32,num2str(sigma_real,2),')');
legend([d_fitted,d_real],{leg1, leg2})
title('Thompson - sgm0')


%%%%%%%%%%%%%%%% xi %%%%%%%%%%%%%%%%
subplot(2,3,3)

h1=histogram(xi_mat_thompson_ML, 10, 'Normalization', 'pdf'); hold on;
x=0:0.01:0.5; 
%pd_data_gamma=fitdist(xi_mat_thompson, 'Gamma'); disp(pd_data_gamma)
pd_data_beta_ML=fitdist(xi_mat_thompson_ML, 'Beta'); disp(pd_data_beta_ML)
%h2=plot(x, pdf(pd_data_gamma, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
h3=plot(x, pdf(pd_data_beta_ML, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
%leg1 = 'Gamma distribution fitted to data';
leg2 = 'Beta distribution fitted to data';
%legend([h2, h3],{leg1, leg2})
legend([h3],{leg2})
title('Thompson - xi')



%% MAP

[all_parameters_thompson] = concatenate_all_params_thompson_MAP_prior(num_part);

sgm0_mat_thompson_MAP = [all_parameters_thompson(:,1)];
Q0_mat_thompson_MAP = [all_parameters_thompson(:,2)];
xi_mat_thompson_MAP = [all_parameters_thompson(:,3)];



%%%%%%%%%%%%%%%% Q0 %%%%%%%%%%%%%%%%

subplot(2,3,4)

% histogram of parameters
h1=histogram(Q0_mat_thompson_MAP, 10, 'Normalization', 'pdf'); hold on;

% fit distribution to a normal distrib and plot it
pd_data_Q0_MAP=fitdist(Q0_mat_thompson_MAP, 'Normal'); disp(pd_data_Q0_MAP);
x=1:0.1:10;
d_fitted=plot(x,pdf(pd_data_Q0_MAP,x), 'LineWidth', 2, 'MarkerSize', 6); hold on;

% real distirbution of means
mu_real = 5;
sigma_real = 2; 
d_real=plot(x,normpdf(x,mu_real,sigma_real),'LineWidth', 2);
leg1 = strcat('fitted distribution (mean:',32,num2str(pd_data_Q0_MAP.mu,2), ', sigma:',32,num2str(pd_data_Q0_MAP.sigma,2),')');
leg2 = strcat('theoretical distribution (mean:',32,num2str(mu_real,2), ', sigma:',32,num2str(sigma_real,2),')');
legend([d_fitted,d_real],{leg1, leg2})
title('Thompson - Q0')
 

%%%%%%%%%%%%%%%% sgm0 %%%%%%%%%%%%%%%%
subplot(2,3,5)

% histogram of parameters
h1=histogram(sgm0_mat_thompson_MAP, 12, 'Normalization', 'pdf'); hold on;

% fit distribution to a normal distrib and plot it
pd_data_sgm0_MAP=fitdist(sgm0_mat_thompson_MAP, 'Normal'); disp(pd_data_sgm0_MAP);
x=0:0.1:4;
d_fitted=plot(x,pdf(pd_data_sgm0_MAP,x), 'LineWidth', 2, 'MarkerSize', 6); hold on;

% real distribution of sgm0
mu_real = 1.4;
sigma_real = 1; 
d_real=plot(x,normpdf(x,mu_real,sigma_real),'LineWidth', 2);
leg1 = strcat('fitted distribution (mean:',32,num2str(pd_data_sgm0_MAP.mu,2), ', sigma:',32,num2str(pd_data_sgm0_MAP.sigma,2),')');
leg2 = strcat('theoretical distribution (mean:',32,num2str(mu_real,2), ', sigma:',32,num2str(sigma_real,2),')');
legend([d_fitted,d_real],{leg1, leg2})
title('Thompson - sgm0')


%%%%%%%%%%%%%%%% xi %%%%%%%%%%%%%%%%
subplot(2,3,6)

h1=histogram(xi_mat_thompson_MAP, 10, 'Normalization', 'pdf'); hold on;
x=0:0.01:0.5; 
%pd_data_gamma=fitdist(xi_mat_thompson, 'Gamma'); disp(pd_data_gamma)
pd_data_beta_MAP=fitdist(xi_mat_thompson_MAP, 'Beta'); disp(pd_data_beta_MAP)
%h2=plot(x, pdf(pd_data_gamma, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
h3=plot(x, pdf(pd_data_beta_MAP, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
%leg1 = 'Gamma distribution fitted to data';
leg2 = 'Beta distribution fitted to data';
%legend([h2, h3],{leg1, leg2})
legend([h3],{leg2})
title('Thompson - xi')


%% MLE vs MAP
figure();
subplot(1,3,1)
x=0:0.01:10;
mu_real = 5;
sigma_real = 2;
plot(x,normpdf(x,mu_real,sigma_real), 'LineWidth', 2, 'MarkerSize', 6); hold on;
plot(x, pdf(pd_data_Q0_MAP, x), 'LineWidth', 2, 'MarkerSize', 6); 
title('Q0')
legend('Theoretical prior', 'Posterior')

subplot(1,3,2)
x=0:0.01:4;
mu_real = 1.4;
sigma_real = 1; 
plot(x, normpdf(x,mu_real,sigma_real), 'LineWidth', 2, 'MarkerSize', 6); hold on;
plot(x, pdf(pd_data_sgm0_MAP, x), 'LineWidth', 2, 'MarkerSize', 6); 
title('sgm0')
legend('Theoretical prior', 'Posterior')

subplot(1,3,3)
x=0:0.01:0.45;
plot(x, pdf(pd_data_beta_ML, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
plot(x, pdf(pd_data_beta_MAP, x), 'LineWidth', 2, 'MarkerSize', 6); 
title('Xi')
legend('Empirical prior', 'Posterior')

x0 = 200;
y0 = 200;
width = 900;
height = 500;
set(gcf,'position',[x0,y0,width,height])
