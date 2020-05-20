
optim_algo = 'fmincon'; % The optimisation algorithm can be: 'genetic' or 'fmincon'

% THOMPSON
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% param_bounds_xi = [0.01,0.5];
% param_bounds_sgm0 = [1,10]; 
% param_bounds_Q0 = [0.1,10]; 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% UCB
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% param_bounds_gamma = [0.01,3]; % information bonus
% param_bounds_tau = [0.1,4]; % inverse temperature
% param_bounds_xi = [0.01,0.5]; % epsilon greedy
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% LA ON A CHANGE BORNES DE XI
% for ID = 501:560
%     fit_heuristics_xi_nov(ID, 'fmincon')
% end

for ID = 501:560
    cv_mod9_thompson_2param_1Hor(ID)
end

for ID = 501:560
    cv_mod10_thompson_3param_2Hor(ID)
end

% for ID = 554:560
%     fit_IG_2param_argmax_all(ID, 'fmincon')
% end
% 
% 
% fit_IG_2param_argmax(541, 'fmincon')
% 
% for ID = 553:560
%    fit_IG_2param(ID, 'fmincon')
%    fit_IG_3param_argmax(ID, 'fmincon') 
%    fit_IG_2param_argmax(ID, 'fmincon')
%    %fit_pure_argmax_2param(ID, 'fmincon');
% end
% 
% fit_pure_argmax_2param(517, 'fmincon'); 
% fit_pure_argmax_2param(521, 'fmincon'); 
% fit_pure_argmax_2param(522, 'fmincon'); 
% fit_pure_argmax_2param(525, 'fmincon'); 
% fit_pure_argmax_2param(526, 'fmincon');
% fit_pure_argmax_2param(529, 'fmincon');
% fit_pure_argmax_2param(530, 'fmincon');
% 
% for ID = 533:539
%     fit_pure_argmax_2param(ID, 'fmincon');
% end


% % % 
%isnan_thomp = [4    11    14];
%  for i=501:560 %524:532 %513,514]
% % %     optim_algo = 'genetic';
% % %    fit_UCBargmin_3param(i, optim_algo)
% % %     fit_UCBargmax_3param(i, optim_algo)
% % %     fit_UCBmean_3param(i, optim_algo)
% % %     fit_simple_3param(i, optim_algo)
% % %     fit_UCB_3param(i, optim_algo)
% %      fit_thompson_4param(i, optim_algo); %nan when 2 sgm0: 4, 6, 8, 10, 13, 14, 21, 26, 27, 29, 31, 37, 41, 44, 50    56    60
% % %      fit_UCB_3param(i, optim_algo)
% %%        fit_IG_3param(i, 'fmincon')
% % %      fit_UCBmean_3param(i, optim_algo)
% % %      fit_UCBargmax_3param(i, optim_algo)
% %      fit_hybrid_5param(i, optim_algo)
% % %     fit_hybrid_5param(i, optim_algo) 
% % %     fit_UCB_3param_hor11(i,optim_algo)
% % %     fit_UCB_3param_hor6(i,optim_algo)
% % %     optim_algo = 'genetic';
% % %     fit_thompson_3param_hor11(i, optim_algo)
% % %     fit_thompson_3param_hor6(i, optim_algo)
% % %     optim_algo = 'fmincon';
% % %     fit_UCB_3param_hor11(i,optim_algo)
% % %     fit_UCB_3param_hor6(i,optim_algo)
% % %     optim_algo = 'fmincon';
% % %     fit_thompson_3param_hor11(i, optim_algo)
% % %     fit_thompson_3param_hor6(i, optim_algo)
%  end
 

% [all_parameters_UCB,all_parameters_thompson, all_parameters_simple_model, all_parameters_hybrid] = concatenate_all_params(optim_algo);

% % if by horizon
% [all_parameters_UCB_hor11,all_parameters_thompson_hor11] = concatenate_all_params_hor11(optim_algo);
% [all_parameters_UCB_hor6,all_parameters_thompson_hor6] = concatenate_all_params_hor6(optim_algo);
% all_parameters_UCB = [all_parameters_UCB_hor11 all_parameters_UCB_hor6];
% all_parameters_thompson = [all_parameters_thompson_hor11 all_parameters_thompson_hor6];
 
% figure()
% boxplot(all_parameters_UCB)
% xlabel('gamma - tau - xi')
% title('UCB')
% 
% figure()
% boxplot(all_parameters_thompson)
% xlabel('Q0 - sgm0 - xi')
% title('thompson')

% % Load drug coding - placebo = 0	amisulpride = 1     propranolol = 2
% load('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis_with_logreg\drug_coding.mat')
% 
% % placebo
% placebo_ind = find(drug_coding(:,2)==0);
% 
% % amisulpride
% amisulpride_ind = find(drug_coding(:,2)==1);
% 
% % propanolol
% propanolol_ind = find(drug_coding(:,2)==2);
% 
% % Create matrices for each parameters split by drug group
% Q0_mat_thompson = [all_parameters_thompson(placebo_ind,1), all_parameters_thompson(amisulpride_ind,1), all_parameters_thompson(propanolol_ind ,1)];
% sgm0_mat_thompson = [all_parameters_thompson(placebo_ind,2), all_parameters_thompson(amisulpride_ind,2), all_parameters_thompson(propanolol_ind ,2)];
% xi_mat_thompson = [all_parameters_thompson(placebo_ind,3), all_parameters_thompson(amisulpride_ind,3), all_parameters_thompson(propanolol_ind ,3)];
% 
% gamma_mat_UCB = [all_parameters_UCB(placebo_ind,1), all_parameters_UCB(amisulpride_ind,1), all_parameters_UCB(propanolol_ind ,1)];
% tau_mat_UCB = [all_parameters_UCB(placebo_ind,2), all_parameters_UCB(amisulpride_ind,2), all_parameters_UCB(propanolol_ind ,2)];
% xi_mat_UCB = [all_parameters_UCB(placebo_ind,3), all_parameters_UCB(amisulpride_ind,3), all_parameters_UCB(propanolol_ind ,3)];
% 
% gamma_mat_simple_model = [all_parameters_simple_model(placebo_ind,1), all_parameters_simple_model(amisulpride_ind,1), all_parameters_simple_model(propanolol_ind ,1)];
% tau_mat_simple_model = [all_parameters_simple_model(placebo_ind,2), all_parameters_simple_model(amisulpride_ind,2), all_parameters_simple_model(propanolol_ind ,2)];
% xi_mat_simple_model = [all_parameters_simple_model(placebo_ind,3), all_parameters_simple_model(amisulpride_ind,3), all_parameters_simple_model(propanolol_ind ,3)];
% 
% gamma_mat_hybrid = [all_parameters_hybrid(placebo_ind,1), all_parameters_hybrid(amisulpride_ind,1), all_parameters_hybrid(propanolol_ind ,1)];
% tau_mat_hybrid = [all_parameters_hybrid(placebo_ind,2), all_parameters_hybrid(amisulpride_ind,2), all_parameters_hybrid(propanolol_ind ,2)];
% xi_mat_hybrid = [all_parameters_hybrid(placebo_ind,3), all_parameters_hybrid(amisulpride_ind,3), all_parameters_hybrid(propanolol_ind ,3)];
% sgm0_mat_hybrid = [all_parameters_hybrid(placebo_ind,2), all_parameters_hybrid(amisulpride_ind,2), all_parameters_hybrid(propanolol_ind ,2)];
% w_mat_hybrid = [all_parameters_hybrid(placebo_ind,3), all_parameters_hybrid(amisulpride_ind,3), all_parameters_hybrid(propanolol_ind ,3)];
% 
% 
% % Thompson
% 
% figure()
% 
% subplot(1,3,1)
% boxplot(Q0_mat_thompson)
% xlabel('placebo - amisulpride - propanolol')
% title('Thompson - Q0')
% 
% subplot(1,3,2)
% boxplot(sgm0_mat_thompson)
% xlabel('placebo - amisulpride - propanolol')
% title('Thompson - sgm0')
% 
% subplot(1,3,3)
% boxplot(xi_mat_thompson)
% xlabel('placebo - amisulpride - propanolol')
% title('Thompson - xi')
% 
% % UCB
% 
% figure()
% 
% subplot(1,3,1)
% boxplot(gamma_mat_UCB)
% xlabel('placebo - amisulpride - propanolol')
% title('UCB - Gamma')
% 
% subplot(1,3,2)
% boxplot(tau_mat_UCB)
% xlabel('placebo - amisulpride - propanolol')
% title('UCB - Tau')
% 
% subplot(1,3,3)
% boxplot(xi_mat_UCB)
% xlabel('placebo - amisulpride - propanolol')
% title('UCB - xi')
% 
% % simple_model
% 
% figure()
% 
% subplot(1,3,1)
% boxplot(gamma_mat_simple_model)
% xlabel('placebo - amisulpride - propanolol')
% title('Simple model - Gamma')
% 
% subplot(1,3,2)
% boxplot(tau_mat_simple_model)
% xlabel('placebo - amisulpride - propanolol')
% title('Simple model - Tau')
% 
% subplot(1,3,3)
% boxplot(xi_mat_simple_model)
% xlabel('placebo - amisulpride - propanolol')
% title('Simple model - xi')
% 
% % Hybrid
% 
% figure()
% 
% subplot(1,5,1)
% boxplot(gamma_mat_hybrid)
% xlabel('placebo - amisulpride - propanolol')
% title('Hybrid - Gamma')
% 
% subplot(1,5,2)
% boxplot(tau_mat_hybrid)
% xlabel('placebo - amisulpride - propanolol')
% title('Hybrid - Tau')
% 
% subplot(1,5,3)
% boxplot(xi_mat_hybrid)
% xlabel('placebo - amisulpride - propanolol')
% title('Hybrid - xi')
% 
% subplot(1,5,4)
% boxplot(sgm0_mat_hybrid)
% xlabel('placebo - amisulpride - propanolol')
% title('Hybrid - Sgm0')
% 
% subplot(1,5,5)
% boxplot(w_mat_hybrid)
% xlabel('placebo - amisulpride - propanolol')
% title('Hybrid - w')

