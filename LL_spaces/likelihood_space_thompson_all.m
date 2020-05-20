function [] = likelihood_space_thompson_all(ID)

likelihood_space_thompson_const_Q0_fmincon(ID);

likelihood_space_thompson_const_sgm0_fmincon(ID);

likelihood_space_thompson_const_xi_fmincon(ID);

end

