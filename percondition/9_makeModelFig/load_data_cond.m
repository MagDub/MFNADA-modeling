
function [all_param, all_param_mean] = load_data_cond(cond)

    load(strcat('./params/param_epsilon_',cond,'_SH.mat'));
    load(strcat('./params/param_epsilon_',cond,'_LH.mat'));
    load(strcat('./params/param_sgm0_',cond,'_SH.mat'));
    load(strcat('./params/param_sgm0_',cond,'_LH.mat'));
    load(strcat('./params/param_eta_',cond,'_SH.mat'));
    load(strcat('./params/param_eta_',cond,'_LH.mat')); 
    
    all_param=[param_epsilon_SH, param_epsilon_LH, param_sgm0_SH, param_sgm0_LH, param_eta_SH, param_eta_LH];
    all_param_mean=[param_epsilon_SH+param_epsilon_LH, param_sgm0_SH+param_sgm0_LH, param_eta_SH+param_eta_LH]/2;
    
end