
function [all_parameters_hybrid] = concatenate_all_params_hybrid_byhor(num_part)

all_parameters_hybrid = nan(num_part,9);


for participant = 1:num_part
    
    if participant < 10
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\5params_2Hor\results\fmincon\res_hybrid_50',int2str(participant),'_results.mat'))
    else
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\5params_2Hor\results\fmincon\res_hybrid_5',int2str(participant),'_results.mat'))
    end
    
    all_parameters_hybrid(participant,:) = mEparams;
end

end