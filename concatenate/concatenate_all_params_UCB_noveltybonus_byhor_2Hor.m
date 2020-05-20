
function [all_parameters_UCB_noveltybonus] = concatenate_all_params_UCB_noveltybonus_byhor_2Hor(num_part)

all_parameters_UCB_noveltybonus = nan(num_part,7);

    for participant = 1:num_part

        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB_noveltybonus\4params_2Hor\results\fmincon\res_UCB_',num2str(500+participant),'_results.mat'))

        all_parameters_UCB_noveltybonus(participant,:) = mEparams;
    end

end