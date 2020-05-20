
function [all_parameters_thomp_noveltybonus] = concatenate_all_params_thomp_noveltybonus_2Hor(num_part)

all_parameters_thomp_noveltybonus = nan(num_part,5);

    for participant = 1:num_part

        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson_noveltybonus\3params_2Hor\results\fmincon\res_thompson_',num2str(500+participant),'_results.mat'))

        all_parameters_thomp_noveltybonus(participant,:) = mEparams;
    end

end