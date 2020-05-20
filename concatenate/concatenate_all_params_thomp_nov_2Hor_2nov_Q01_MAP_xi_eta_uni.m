
function [all_parameters_thomp_noveltybonus] = concatenate_all_params_thomp_nov_2Hor_2nov_Q01_MAP_xi_eta_uni()

num_part = 60;

all_parameters_thomp_noveltybonus = nan(num_part,6);

    for participant = 1:num_part

        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson_noveltybonus_2nov_MAP_xi_eta_uni\3params_2Hor_Q01\results\res_thompson_',num2str(500+participant),'_results.mat'))
        %load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson_noveltybonus_2nov_MAP\3params_2Hor_Q01_2sgm0\results\res_thompson_',num2str(500+participant),'_results.mat'))

        
        all_parameters_thomp_noveltybonus(participant,:) = mEparams;
    end

end