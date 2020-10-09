
Q0 = 5;

% % mod 12 (thompson+xi+eta)
% sgm0_range = 0.8:0.4:2;
% xi = 0;
% eta = 0;
% run_sim_mod12_changing_sgm0(sgm0_range, xi, Q0, eta)
% 
% % mod 12 (thompson+xi+eta)
% sgm0_range = 0.8:0.4:2;
% xi = 0.2;
% eta = 2;
% run_sim_mod12_changing_sgm0(sgm0_range, xi, Q0, eta)

%tau_range = linspace(0.01,1,5);
%run_sim_softmax_changing_tau(tau_range, Q0)

% tau_range = linspace(0.001,3,14);
% run_sim_softmax_changing_tau_2(tau_range, Q0)

tau_range = linspace(1,1.5,5);
run_sim_softmax_changing_tau_ABD(tau_range, Q0)

% xi_range = linspace(0,1,5);
% run_sim_egreedy_changing_xi_ABD(xi_range, Q0)


% xi_range = linspace(0,1,5);
% run_sim_egreedy_changing_xi(xi_range, Q0)

% %mod 5 (ucb)
% tau_range = 0.1:0.5:1;
% gamma = 0;
% run_sim_mod5_changing_tau(gamma, Q0, tau_range)
% 
% %
% tau_range = 0.1:0.5:3;
% gamma = 1;
% run_sim_mod5_changing_tau(gamma, Q0, tau_range)


% %
% gamma_range = 0.5:0.5:3.5;
% tau = 1;
% run_sim_mod5_changing_gamma(tau, Q0, gamma_range)
% 
% %
% gamma_range = 0.5:0.5:3.5;
% tau = 1.5;
% run_sim_mod5_changing_gamma(tau, Q0, gamma_range)






    

    

