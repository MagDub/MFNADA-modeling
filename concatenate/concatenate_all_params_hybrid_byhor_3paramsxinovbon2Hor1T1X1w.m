
function [all_parameters_hybrid] = concatenate_all_params_hybrid_byhor_3paramsxinovbon2Hor1T1X1w(num_part)

all_parameters_hybrid = nan(num_part,6);


for participant = 1:num_part
    
    load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid_noveltybonus\3params_xi_2Hor1Tau1Xi1whyb\results\fmincon\res_hybrid_',num2str(500+participant),'_results.mat'))
    
    all_parameters_hybrid(participant,:) = mEparams;
end

end