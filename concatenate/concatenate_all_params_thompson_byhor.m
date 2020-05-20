
function [all_parameters_thompson] = concatenate_all_params_thompson_byhor(num_part)

all_parameters_thompson = nan(num_part,4);


for participant = 1:num_part
    
    if participant < 10
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson\3params_2Hor\results\fmincon\res_thompson_50',int2str(participant),'_results.mat'))
    else
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson\3params_2Hor\results\fmincon\res_thompson_5',int2str(participant),'_results.mat'))
    end
    
    all_parameters_thompson(participant,:) = mEparams;
end

end