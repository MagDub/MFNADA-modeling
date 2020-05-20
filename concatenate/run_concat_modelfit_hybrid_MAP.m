
num_part = 60; 

optim_algo = 'fmincon';

[all_parameters_hybrid] = concatenate_all_params_hybrid_MAP_prior(num_part);

gamma_mat_hybrid = [all_parameters_hybrid(:,1)];
tau_mat_hybrid = [all_parameters_hybrid(:,2)];
xi_mat_hybrid = [all_parameters_hybrid(:,3)];
sgm0_mat_hybrid = [all_parameters_hybrid(:,4)];
w_mat_hybrid = [all_parameters_hybrid(:,5)];



figure()

%%%%%%%%%%%%%%%% gamma %%%%%%%%%%%%%%%%

subplot(1,5,1)

% histogram of parameters
h1=histogram(gamma_mat_hybrid, 10, 'Normalization', 'pdf'); hold on;

% fit distribution to a normal distrib and plot it
pd_data=fitdist(gamma_mat_hybrid, 'Normal'); disp(pd_data);
x=0:0.01:3;
d_fitted=plot(x,pdf(pd_data,x), 'LineWidth', 2, 'MarkerSize', 6); hold on;

leg1 = strcat('fitted distribution (mean:',32,num2str(pd_data.mu,2), ', sigma:',32,num2str(pd_data.sigma,2),')');
legend([d_fitted],{leg1})
title('hybrid - gamma')
 

%%%%%%%%%%%%%%%% tau %%%%%%%%%%%%%%%%
subplot(1,5,2)

% histogram of parameters
h1=histogram(tau_mat_hybrid, 10, 'Normalization', 'pdf'); hold on;

% fit distribution to a normal distrib and plot it
pd_data=fitdist(tau_mat_hybrid, 'Normal'); disp(pd_data);
x=0:0.1:3;
d_fitted=plot(x,pdf(pd_data,x), 'LineWidth', 2, 'MarkerSize', 6); hold on;

leg1 = strcat('fitted distribution (mean:',32,num2str(pd_data.mu,2), ', sigma:',32,num2str(pd_data.sigma,2),')');
legend([d_fitted],{leg1})
title('hybrid - tau')


%%%%%%%%%%%%%%%% xi %%%%%%%%%%%%%%%%
subplot(1,5,3)

h1=histogram(xi_mat_hybrid, 12, 'Normalization', 'pdf'); hold on;
x=0:0.01:0.5; 
%pd_data_gamma=fitdist(xi_mat_hybrid, 'Gamma'); disp(pd_data_gamma)
pd_data_beta=fitdist(xi_mat_hybrid, 'Beta'); disp(pd_data_beta)
%h2=plot(x, pdf(pd_data_gamma, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
h3=plot(x, pdf(pd_data_beta, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
%leg1 = 'Gamma distribution fitted to data';
leg2 = 'Beta distribution fitted to data';
%legend([h2, h3],{leg1, leg2})
legend([h3],{leg2})
title('hybrid - xi')
%xlim([-0.01 0.1])


%%%%%%%%%%%%%%%% sgm0 %%%%%%%%%%%%%%%%
subplot(1,5,4)

% histogram of parameters
h1=histogram(sgm0_mat_hybrid, 10, 'Normalization', 'pdf'); hold on;

% fit distribution to a normal distrib and plot it
pd_data=fitdist(sgm0_mat_hybrid, 'Normal'); disp(pd_data);
x=0:0.1:4;
d_fitted=plot(x,pdf(pd_data,x), 'LineWidth', 2, 'MarkerSize', 6); hold on;

% real distribution of sgm0
mu_real = 1.4;
sigma_real = 1; 
d_real=plot(x,normpdf(x,mu_real,sigma_real),'LineWidth', 2);
leg1 = strcat('fitted distribution (mean:',32,num2str(pd_data.mu,2), ', sigma:',32,num2str(pd_data.sigma,2),')');
leg2 = strcat('theoretical distribution (mean:',32,num2str(mu_real,2), ', sigma:',32,num2str(sigma_real,2),')');
legend([d_fitted,d_real],{leg1, leg2})
title('hybrid - sgm0')


%%%%%%%%%%%%%%%% w %%%%%%%%%%%%%%%%
subplot(1,5,5)

h1=histogram(w_mat_hybrid, 10, 'Normalization', 'pdf'); hold on;
x=0:0.01:1; 
pd_data_beta=fitdist(w_mat_hybrid, 'Normal'); disp(pd_data_beta)
h3=plot(x, pdf(pd_data_beta, x), 'LineWidth', 2, 'MarkerSize', 6); hold on;
leg2 = 'Normal distribution fitted to data';
legend([h3],{leg2})
title('hybrid - w')


