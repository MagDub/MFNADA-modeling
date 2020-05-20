
function [all_parameters_thomp_noveltybonus, settings] = concatenate_all_p_thomp_nov_2Hor_2nov_Q01_MAP_2sgm0_xi_eta_uni(num_part)

all_parameters_thomp_noveltybonus = nan(num_part,7);

    for participant = 1:num_part

        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson_noveltybonus_2nov_MAP\3params_2Hor_Q01_2sgm0\results\res_thompson_',num2str(500+participant),'_results.mat'))

        all_parameters_thomp_noveltybonus(participant,:) = mEparams;
    end

end