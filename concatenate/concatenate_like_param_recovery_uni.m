
function [all_parameters_thomp_noveltybonus] = concatenate_like_param_recovery_uni()

num_part = 60;

all_parameters_thomp_noveltybonus = nan(num_part,7);

    for participant = 1:num_part

        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson_model_fit\thompson_like_param_recovery_2sgm0_prior0normal\results\res_thompson_',num2str(500+participant),'_results.mat'))

        all_parameters_thomp_noveltybonus(participant,:) = mEparams;
    end

end