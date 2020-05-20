
function [all_parameters_thomp_noveltybonus] = concatenate_all_params_mod4()

num_part = 60;

all_parameters_thomp_noveltybonus = nan(num_part,12);

    for participant = 1:num_part

        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid_noveltybonus_both_2nov_MAP\5params\results\res_hybrid_',num2str(500+participant),'_results.mat'))

        all_parameters_thomp_noveltybonus(participant,:) = mEparams;
    end

end