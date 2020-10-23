
% sgm0 = 1.312;
xi = 0.2; % 
Q0 = 5;
tau = 0.7; % (1/beta)
% eta = 0;
% gamma = 0;

% eta_range = 0:1:5;
gamma_range = [0.7, 1.5];
% sgm0_range = 0.8:0.4:1.8;
% tau_range = 0.2:0.5:0.7;
% xi_range = 0:0.1:1;

% % mod 12 (thompson+xi+eta)
% run_sim_mod12_changing_eta(sgm0, xi, Q0, eta_range)
% run_sim_mod12_changing_xi(sgm0, xi_range, Q0, eta)
% run_sim_mod12_changing_sgm0(sgm0_range, xi, Q0, eta)

% mod 5 (ucb)
run_sim_mod5_changing_gamma_xi(tau, xi, Q0, gamma_range)
% run_sim_mod5_changing_tau(gamma, Q0, tau_range)

% % mod 16 (argmax+xi+eta) 
% run_sim_mod16_changing_eta(xi, Q0, eta_range)
% run_sim_mod16_changing_xi(xi_range, Q0, eta)
 
% % mod 9 (thompson)
% run_sim_mod9_changing_sgm0(Q0, sgm0_range)




    

    

