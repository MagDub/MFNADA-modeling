
function [all_parameters] = concatenate_all_params_mod8()

num_part = 60;

all_parameters = nan(num_part,9);

    for participant = 1:num_part

        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB_noveltybonus_2nov_MAP\3params\results\res_UCB_',num2str(500+participant),'_results.mat'))

        all_parameters(participant,:) = mEparams;
    end

end