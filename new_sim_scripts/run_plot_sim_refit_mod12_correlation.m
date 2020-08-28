
% from run_sim

close all;

load('../../data/simulation_data/thompson/4perdim_newbounds/inp_params_thompson.mat')
load('../../data/data_for_figs/out_sim_thompson.mat')

% {'sgm0', 'sgm0', 'Q0','xi', '', 'eta', ''};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_sgm0 = [0.01,6];
param_bounds_Q0 = [1,6]; 
param_bounds_xi = [10^-8,0.5];  
param_bounds_eta = [0,5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

para_vals_generated = out.org;
para_vals_fitted = out.fitted;

subplot(2,4,1);
plot(para_vals_fitted(:,4), para_vals_generated(:,4),'.'); hold on;
plot([-12 12],[-12 12],':k')
r = corr(para_vals_fitted(:,4),para_vals_generated(:,4),'Type','pearson');
title(strcat('xi SH, r=',num2str(r,3)))
xlim([param_bounds_xi(1)-0.1*param_bounds_xi(2) param_bounds_xi(2)+0.1*param_bounds_xi(2)])
ylim([param_bounds_xi(1)-0.1*param_bounds_xi(2) param_bounds_xi(2)+0.1*param_bounds_xi(2)])
ylabel('Generated')
xlabel('Fitted')

subplot(2,4,2);
plot(para_vals_fitted(:,5), para_vals_generated(:,5),'.'); hold on;
plot([-12 12],[-12 12],':k')
r = corr(para_vals_fitted(:,5),para_vals_generated(:,5),'Type','pearson');
title(strcat('xi LH, r=',num2str(r,3)))
xlim([param_bounds_xi(1)-0.1*param_bounds_xi(2) param_bounds_xi(2)+0.1*param_bounds_xi(2)])
ylim([param_bounds_xi(1)-0.1*param_bounds_xi(2) param_bounds_xi(2)+0.1*param_bounds_xi(2)])
ylabel('Generated')
xlabel('Fitted')

subplot(2,4,3);
plot(para_vals_fitted(:,6), para_vals_generated(:,6),'.'); hold on;
plot([-12 12],[-12 12],':k')
r = corr(para_vals_fitted(:,6),para_vals_generated(:,6),'Type','pearson');
title(strcat('sgm0, r=',num2str(r,3)))
xlim([param_bounds_sgm0(1)-0.1*param_bounds_sgm0(2) param_bounds_sgm0(2)+0.1*param_bounds_sgm0(2)])
ylim([param_bounds_sgm0(1)-0.1*param_bounds_sgm0(2) param_bounds_sgm0(2)+0.1*param_bounds_sgm0(2)])
ylabel('Generated')
xlabel('Fitted')

subplot(2,4,4);
plot(para_vals_fitted(:,7), para_vals_generated(:,7),'.'); hold on;
plot([-12 12],[-12 12],':k')
r = corr(para_vals_fitted(:,7),para_vals_generated(:,7),'Type','pearson');
title(strcat('sgm0, r=',num2str(r,3)))
xlim([param_bounds_sgm0(1)-0.1*param_bounds_sgm0(2) param_bounds_sgm0(2)+0.1*param_bounds_sgm0(2)])
ylim([param_bounds_sgm0(1)-0.1*param_bounds_sgm0(2) param_bounds_sgm0(2)+0.1*param_bounds_sgm0(2)])
ylabel('Generated')
xlabel('Fitted')

subplot(2,4,5);
plot(para_vals_fitted(:,3), para_vals_generated(:,3),'.');hold on;
plot([-12 12],[-12 12],':k') 
r = corr(para_vals_fitted(:,3),para_vals_generated(:,3),'Type','pearson');
title(strcat('Q0, r=',num2str(r,3)))
xlim([param_bounds_Q0(1)-0.1*param_bounds_Q0(2) param_bounds_Q0(2)+0.1*param_bounds_Q0(2)])
ylim([param_bounds_Q0(1)-0.1*param_bounds_Q0(2) param_bounds_Q0(2)+0.1*param_bounds_Q0(2)])
ylabel('Generated')
xlabel('Fitted')

subplot(2,4,6);
plot(para_vals_fitted(:,6), para_vals_generated(:,6),'.'); hold on;
plot([-12 12],[-12 12],':k')
r = corr(para_vals_fitted(:,6),para_vals_generated(:,6),'Type','pearson');
title(strcat('eta SH, r=',num2str(r,3)))
xlim([param_bounds_eta(1)-0.1*param_bounds_eta(2) param_bounds_eta(2)+0.1*param_bounds_eta(2)])
ylim([param_bounds_eta(1)-0.1*param_bounds_eta(2) param_bounds_eta(2)+0.1*param_bounds_eta(2)])
ylabel('Generated')
xlabel('Fitted')

subplot(2,4,7);
plot(para_vals_fitted(:,7), para_vals_generated(:,7),'.'); hold on;
plot([-12 12],[-12 12],':k')
r = corr(para_vals_fitted(:,7),para_vals_generated(:,7),'Type','pearson');
title(strcat('eta LH, r=',num2str(r,3)))
xlim([param_bounds_eta(1)-0.1*param_bounds_eta(2) param_bounds_eta(2)+0.1*param_bounds_eta(2)])
ylim([param_bounds_eta(1)-0.1*param_bounds_eta(2) param_bounds_eta(2)+0.1*param_bounds_eta(2)])
ylabel('Generated')
xlabel('Fitted')