
% size(usermat_completed_task,2)

function main_Holly(ID)

    data_fol = ('/home/mdubois/scripts/MFnada/data/');

    %fit_mod12_like_param_recovery_2sgm0_prior1normal(ID, data_fol)
    %fit_mod8_UCB_3param_nov_Q0_MAP(ID, data_fol);
    
    fit_mod12_AB(ID, data_fol);
    fit_mod12_ABD(ID, data_fol);
    fit_mod12_BD(ID, data_fol);
    fit_mod12_AD(ID, data_fol);

end

