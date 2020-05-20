
function [all_parameters_UCB,all_parameters_thompson] = concatenate_all_params_hor6(optim_algo)

all_parameters_UCB = nan(60,3);
all_parameters_thompson = nan(60,3);

for participant = 1:60

    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\3params\results\hor6\fmincon\res_UCB_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\3params\results\hor6\fmincon\res_UCB_5',int2str(participant),'_results.mat'))
        end
    elseif strcmp(optim_algo,'genetic')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\3params\results\hor6\genetic\res_UCB_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\3params\results\hor6\genetic\res_UCB_5',int2str(participant),'_results.mat'))
        end
    end
    
    all_parameters_UCB(participant,:) = mEparams;

end

for participant = 1:60
    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson\3params\results\hor6\fmincon\res_thompson_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson\3params\results\hor6\fmincon\res_thompson_5',int2str(participant),'_results.mat'))
        end
    elseif strcmp(optim_algo,'genetic')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson\3params\results\hor6\genetic\res_thompson_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson\3params\results\hor6\genetic\res_thompson_5',int2str(participant),'_results.mat'))
        end
    end
    
    all_parameters_thompson(participant,:) = mEparams;

end