
function [all_parameters_thomp_noveltybonus] = concatenate_all_params_thomp_noveltybonus_1Hor(num_part)

all_parameters_thomp_noveltybonus = nan(num_part,4);

    for participant = 1:num_part

        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson_noveltybonus\3params_1Hor\results\fmincon\res_thompson_',num2str(500+participant),'_results.mat'))

        all_parameters_thomp_noveltybonus(participant,:) = mEparams;
    end

end