
function [all_parameters_UCB_3p, all_parameters_UCB_4p, all_parameters_UCB_4p_Q0single, all_parameters_UCB_4p_sgm0single, all_parameters_UCB_5p] = concatenate_all_params3(num_part, optim_algo)

all_parameters_UCB_3p = nan(num_part,6);
all_parameters_UCB_4p = nan(num_part,8);
all_parameters_UCB_4p_Q0single = nan(num_part,7);
all_parameters_UCB_4p_sgm0single = nan(num_part,7);
all_parameters_UCB_5p = nan(num_part,9);
    
for participant = 1:num_part    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\3params\results\fmincon\res_UCB_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\3params\results\fmincon\res_UCB_5',int2str(participant),'_results.mat'))
        end
    end
    all_parameters_UCB_3p(participant,:) = mEparams;
end

for participant = 1:num_part    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\4params\results\fmincon\res_UCB_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\4params\results\fmincon\res_UCB_5',int2str(participant),'_results.mat'))
        end
    end
    all_parameters_UCB_4p(participant,:) = mEparams;
end

for participant = 1:num_part    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\4params\results_Q0single\fmincon\res_UCB_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\4params\results_Q0single\fmincon\res_UCB_5',int2str(participant),'_results.mat'))
        end
    end
    all_parameters_UCB_4p_Q0single(participant,:) = mEparams;
end

% for participant = 1:num_part    
%     if strcmp(optim_algo,'fmincon')
%         if participant < 10
%             load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\4params\results_sgm0single\fmincon\res_UCB_50',int2str(participant),'_results.mat'))
%         else
%             load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\4params\results_sgm0single\fmincon\res_UCB_5',int2str(participant),'_results.mat'))
%         end
%     end
%     all_parameters_UCB_4p_sgm0single(participant,:) = mEparams;
% end

for participant = 1:num_part    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\5params\results\fmincon\res_UCB_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\5params\results\fmincon\res_UCB_5',int2str(participant),'_results.mat'))
        end
    end
    all_parameters_UCB_5p(participant,:) = mEparams;
end

end