
function [all_parameters_UCB_noveltybonus] = concatenate_all_params_UCB_noveltybonus_byhor(num_part)

all_parameters_UCB_noveltybonus = nan(num_part,7);


for participant = 1:num_part
    
    if participant < 10
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB_noveltybonus\4params_2Hor\results\fmincon\res_UCB_50',int2str(participant),'_results.mat'))
    else
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB_noveltybonus\4params_2Hor\results\fmincon\res_UCB_5',int2str(participant),'_results.mat'))
    end
    
    all_parameters_UCB_noveltybonus(participant,:) = mEparams;
end

end