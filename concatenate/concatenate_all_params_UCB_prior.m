
function [all_parameters_UCB] = concatenate_all_params_UCB_prior(num_part)

all_parameters_UCB = nan(num_part,3);


for participant = 1:num_part
    
    if participant < 10
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\3params_1Hor\results\fmincon\res_UCB_50',int2str(participant),'_results.mat'))
    else
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\3params_1Hor\results\fmincon\res_UCB_5',int2str(participant),'_results.mat'))
    end
    
    all_parameters_UCB(participant,:) = mEparams;
end

end