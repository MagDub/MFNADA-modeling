
addpath('./holly/')
data_fol = ('../../data');

for ID=501 %502:560
    
    disp(ID)
    
    fit_mod4_hybrid_7param_MAP(ID, data_fol)
    
    %fit_mod8_UCB_3param_nov_Q0_MAP(ID, data_fol)
        
    %fit_mod12_like_param_recovery_2sgm0_prior1normal(ID, data_fol)
    
end
