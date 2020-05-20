
function [all_parameters_UCB,all_parameters_thompson, all_parameters_UCBmean, all_parameters_UCBargmax, all_parameters_UCBargmin, all_parameters_hybrid5, all_parameters_IG, all_parameters_UCBargmaxweighted3p, all_parameters_UCBargmaxweighted4p] = concatenate_all_params(num_part, optim_algo)

all_parameters_UCB = nan(num_part,6);
all_parameters_thompson = nan(num_part,5);
all_parameters_UCBmean = nan(num_part,6);
all_parameters_UCBargmax = nan(num_part,6);
all_parameters_UCBargmin = nan(num_part,6);
all_parameters_hybrid5 = nan(num_part,10);
all_parameters_hybrid6 = nan(num_part,10);
all_parameters_IG = nan(num_part,6);
all_parameters_UCBargmaxweighted3p = nan(num_part,6);
all_parameters_UCBargmaxweighted4p = nan(num_part,8);

for participant = 1:num_part

    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\3params\results\fmincon\res_UCB_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\3params\results\fmincon\res_UCB_5',int2str(participant),'_results.mat'))
        end
    elseif strcmp(optim_algo,'genetic')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\3params\results\genetic\res_UCB_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\3params\results\genetic\res_UCB_5',int2str(participant),'_results.mat'))
        end
    end
    
    all_parameters_UCB(participant,:) = mEparams;

end

% for participant = 1:num_part
%     
%     if strcmp(optim_algo,'fmincon')
%         if participant < 10
%             load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson\3params\results\fmincon\res_thompson_50',int2str(participant),'_results.mat'))
%         else
%             load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson\3params\results\fmincon\res_thompson_5',int2str(participant),'_results.mat'))
%         end
%     elseif strcmp(optim_algo,'genetic')
%         if participant < 10
%             load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson\3params\results\genetic\res_thompson_50',int2str(participant),'_results.mat'))
%         else
%             load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson\3params\results\genetic\res_thompson_5',int2str(participant),'_results.mat'))
%         end
%     end
%     
%     all_parameters_thompson(participant,:) = mEparams;
% end
    
for participant = 1:num_part
    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCBmean\3params\results\fmincon\res_UCBmean_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCBmean\3params\results\fmincon\res_UCBmean_5',int2str(participant),'_results.mat'))
        end
    elseif strcmp(optim_algo,'genetic')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCBmean\3params\results\genetic\res_UCBmean_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCBmean\3params\results\genetic\res_UCBmean_5',int2str(participant),'_results.mat'))
        end
    end
    
    all_parameters_UCBmean(participant,:) = mEparams;
end

for participant = 1:num_part
    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCBargmax\3params\results\fmincon\res_UCBargmax_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCBargmax\3params\results\fmincon\res_UCBargmax_5',int2str(participant),'_results.mat'))
        end
    elseif strcmp(optim_algo,'genetic')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCBargmax\3params\results\genetic\res_UCBargmax_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCBargmax\3params\results\genetic\res_UCBargmax_5',int2str(participant),'_results.mat'))
        end
    end
    
    all_parameters_UCBargmax(participant,:) = mEparams;
end

for participant = 1:num_part
    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCBargmin\3params\results\fmincon\res_UCBargmin_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCBargmin\3params\results\fmincon\res_UCBargmin_5',int2str(participant),'_results.mat'))
        end
    elseif strcmp(optim_algo,'genetic')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCBargmin\3params\results\genetic\res_UCBargmin_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCBargmin\3params\results\genetic\res_UCBargmin_5',int2str(participant),'_results.mat'))
        end
    end
    
    all_parameters_UCBargmin(participant,:) = mEparams;
end
    
for participant = 1:num_part
    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\5params\results\fmincon\res_hybrid_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\5params\results\fmincon\res_hybrid_5',int2str(participant),'_results.mat'))
        end
    elseif strcmp(optim_algo,'genetic')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\5params\results\genetic\res_hybrid_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\5params\results\genetic\res_hybrid_5',int2str(participant),'_results.mat'))
        end
    end
    
    all_parameters_hybrid5(participant,:) = mEparams;
end

for participant = 1:num_part
    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\IG\3params\results\fmincon\res_IG_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\IG\3params\results\fmincon\res_IG_5',int2str(participant),'_results.mat'))
        end
    elseif strcmp(optim_algo,'genetic')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\IG\3params\results\genetic\res_IG_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\IG\3params\results\genetic\res_IG_5',int2str(participant),'_results.mat'))
        end
    end
    
    all_parameters_IG(participant,:) = mEparams;
end

for participant = 1:num_part
    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCBargmaxweightedv2\3params\results\fmincon\res_UCBargmaxweightedv2_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCBargmaxweightedv2\3params\results\fmincon\res_UCBargmaxweightedv2_5',int2str(participant),'_results.mat'))
        end
    elseif strcmp(optim_algo,'genetic')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCBargmaxweightedv2\3params\results\genetic\res_UCBargmaxweightedv2_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCBargmaxweightedv2\3params\results\genetic\res_UCBargmaxweightedv2_5',int2str(participant),'_results.mat'))
        end
    end
    
    all_parameters_UCBargmaxweighted3p(participant,:) = mEparams;
end

for participant = 1:num_part
    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCBargmaxweightedv2\4params\results\fmincon\res_UCBargmaxweightedv2_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCBargmaxweightedv2\4params\results\fmincon\res_UCBargmaxweightedv2_5',int2str(participant),'_results.mat'))
        end
    elseif strcmp(optim_algo,'genetic')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCBargmaxweightedv2\4params\results\genetic\res_UCBargmaxweightedv2_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCBargmaxweightedv2\4params\results\genetic\res_UCBargmaxweightedv2_5',int2str(participant),'_results.mat'))
        end
    end
    
    all_parameters_UCBargmaxweighted4p(participant,:) = mEparams;
end

end