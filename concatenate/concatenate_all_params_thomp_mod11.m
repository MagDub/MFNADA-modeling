
function [all_parameters_thomp_noveltybonus] = concatenate_all_params_thomp_mod11()

num_part = 60;

all_parameters_thomp_noveltybonus = nan(num_part,5);

    for participant = 1:num_part

        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson_noveltybonus_2nov_MAP\2params_2Hor_Q01_2sgm0_xi_eta_uni\results\res_thompson_',num2str(500+participant),'_results.mat'))

        all_parameters_thomp_noveltybonus(participant,:) = mEparams;
    end

end