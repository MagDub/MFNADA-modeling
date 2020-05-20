
function [all_parameters_thompson_MAP, all_parameters_thompson_MLE, all_parameters_UCB_MAP, all_parameters_UCB_MLE] = concatenate_all_params_MAP(num_part)

all_parameters_thompson_MAP = nan(num_part,5);
all_parameters_thompson_MLE = nan(num_part,5);
all_parameters_UCB_MAP = nan(num_part,6);
all_parameters_UCB_MLE = nan(num_part,6);


for participant = 1:num_part
    
    if participant < 10
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson_MAP\3params\results\fmincon\res_thompson_50',int2str(participant),'_results.mat'))
    else
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson_MAP\3params\results\fmincon\res_thompson_5',int2str(participant),'_results.mat'))
    end
    
    all_parameters_thompson_MAP(participant,:) = mEparams;
end

for participant = 1:num_part
    
    if participant < 10
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson\3params_sepHor\results\fmincon\res_thompson_50',int2str(participant),'_results.mat'))
    else
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson\3params_sepHor\results\fmincon\res_thompson_5',int2str(participant),'_results.mat'))
    end
    
    all_parameters_thompson_MLE(participant,:) = mEparams;
end

for participant = 1:num_part
    
    if participant < 10
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB_MAP\3params\results\fmincon\res_UCB_50',int2str(participant),'_results.mat'))
    else
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB_MAP\3params\results\fmincon\res_UCB_5',int2str(participant),'_results.mat'))
    end
    
    all_parameters_UCB_MAP(participant,:) = mEparams;
end

for participant = 1:num_part
    
    if participant < 10
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\3params_sepHor\results\fmincon\res_UCB_50',int2str(participant),'_results.mat'))
    else
        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\3params_sepHor\results\fmincon\res_UCB_5',int2str(participant),'_results.mat'))
    end
    
    all_parameters_UCB_MLE(participant,:) = mEparams;
end


end