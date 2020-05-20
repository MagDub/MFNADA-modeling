
function [all_parameters_UCB,all_parameters_thompson, all_parameters_hybrid] = concatenate_all_params4(num_part)

all_parameters_UCB = nan(num_part,6);
all_parameters_thompson = nan(num_part,5);
all_parameters_hybrid = nan(num_part,10);


for participant = 1:num_part

    if participant < 10
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\3params\results\fmincon\res_UCB_50',int2str(participant),'_results.mat'))
    else
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\3params\results\fmincon\res_UCB_5',int2str(participant),'_results.mat'))
    end
    
    all_parameters_UCB(participant,:) = mEparams;

end

for participant = 1:num_part
    
    if participant < 10
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson\3params_sepHor\results\fmincon\res_thompson_50',int2str(participant),'_results.mat'))
    else
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson\3params_sepHor\results\fmincon\res_thompson_5',int2str(participant),'_results.mat'))
    end
    
    all_parameters_thompson(participant,:) = mEparams;
end

for participant = 1:num_part
    
    if participant < 10
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\5params\results\fmincon\res_hybrid_50',int2str(participant),'_results.mat'))
    else
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\5params\results\fmincon\res_hybrid_5',int2str(participant),'_results.mat'))
    end
    
    all_parameters_hybrid(participant,:) = mEparams;
end

end