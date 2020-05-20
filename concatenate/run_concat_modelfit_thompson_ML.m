
num_part = 60; 

optim_algo = 'fmincon';

[all_parameters_thompson] = concatenate_all_params_thompson_prior(num_part);

sgm0_mat_thompson = [all_parameters_thompson(:,1)];
Q0_mat_thompson = [all_parameters_thompson(:,2)];
xi_mat_thompson = [all_parameters_thompson(:,3)];

figure()

%%%%%%%%%%%%%%%% Q0 %%%%%%%%%%%%%%%%

subplot(1,3,1)

% histogram of parameters
h1=histogram(Q0_mat_thompson, 10, 'Normalization', 'pdf'); hold on;

% fit distribution to a normal distrib and plot it
pd_data=fitdist(Q0_mat_thompson, 'Normal'); disp(pd_data);
x=1:0.1:10;
d_fitted=plot(x,pdf(pd_data,x), 'LineWidth', 2, 'MarkerSize', 6); hold on;

% real distirbution of means
mu_real = 5;
sigma_real = 2; 
d_real=plot(x,normpdf(x,mu_real,sigma_real),'LineWidth', 2);
leg1 = strcat('fitted distribution (mean:',32,num2str(pd_data.mu,2), ', sigma:',32,num2str(pd_data.sigma,2),')');
leg2 = strcat('theoretical distribution (mean:',32,num2str(mu_real,2), ', sigma:',32,num2str(sigma_real,2),')');
legend([d_fitted,d_real],{leg1, leg2})
title('Thompson - Q0')
 

%%%%%%%%%%%%%%%% sgm0 %%%%%%%%%%%%%%%%
subplot(1,3,2)

% histogram of parameters
h1=histogram(sgm0_mat_thompson, 12, 'Normalization', 'pdf'); hold on;

% fit distribution to a normal distrib and plot it
pd_data=fitdist(sgm0_mat_thompson, 'Normal'); disp(pd_data);
x=0:0.1:4;
d_fitted=plot(x,pdf(pd_data,x), 'LineWidth', 2, 'MarkerSize', 6); hold on;

% real distribution of sgm0
mu_real = 1.4;
sigma_real = 1; 
d_real=plot(x,normpdf(x,mu_real,sigma_real),'LineWidth', 2);
leg1 = strcat('fitted distribution (mean:',32,num2str(pd_data.mu,2), ', sigma:',32,num2str(pd_data.sigma,2),')');
leg2 = strcat('theoretical distribution (mean:',32,num2str(mu_real,2), ', sigma:',32,num2str(sigma_real,2),')');
legend([d_fitted,d_real],{leg1, leg2})
title('Thompson - sgm0')


%%%%%%%%%%%%%%%% xi %%%%%%%%%%%%%%%%
subplot(1,3,3)

h1=histogram(xi_mat_thompson, 10, 'Normalization', 'pdf'); hold on;
x=0:0.01:0.5; 
%pd_data_gamma=fitdist(xi_mat_thompson, 'Gamma'); disp(pd_data_gamma)
pd_data_beta=fitdist(xi_mat_thompson, 'Beta'); disp(pd_data_beta)
%h2=plot(x, pdf(pd_data_gamma, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
h3=plot(x, pdf(pd_data_beta, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
%leg1 = 'Gamma distribution fitted to data';
leg2 = 'Beta distribution fitted to data';
%legend([h2, h3],{leg1, leg2})
legend([h3],{leg2})
title('Thompson - xi')



