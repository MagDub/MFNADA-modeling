
function [all_parameters_hybrid6_Q0single, all_parameters_hybrid6_Q0sgm0single, all_parameters_hybrid6_Q0sgm0w0single,all_parameters_hybrid6_Q0sgm0w0xisingle, all_parameters_hybrid6_Q0sgm0w0xisingle_newB, all_parameters_hybrid6_Q0sgm0w0xisingle_newB2, all_parameters_hybrid6_Q0sgm0w0xisingle_newB3, all_parameters_hybrid6_Q0sgm0w0xisingle_newB4, all_parameters_hybrid6_Q0sgm0xisingle, all_parameters_hybrid6_Q0sgm0xisingle_newB, all_parameters_hybrid6_Q0sgm0xisingle_newB2] = concatenate_all_params2(num_part, optim_algo)

all_parameters_hybrid6_Q0single = nan(num_part,11);
all_parameters_hybrid6_Q0sgm0single = nan(num_part,10);
all_parameters_hybrid6_Q0sgm0w0single = nan(num_part,9);
all_parameters_hybrid6_Q0sgm0w0xisingle = nan(num_part,8);
all_parameters_hybrid6_Q0sgm0w0xisingle_newB = nan(num_part,8);
all_parameters_hybrid6_Q0sgm0w0xisingle_newB2 = nan(num_part,8);
all_parameters_hybrid6_Q0sgm0w0xisingle_newB3 = nan(num_part,8);
all_parameters_hybrid6_Q0sgm0w0xisingle_newB4 = nan(num_part,8);
all_parameters_hybrid6_Q0sgm0xisingle = nan(num_part,9);
all_parameters_hybrid6_Q0sgm0xisingle_newB = nan(num_part,9);
all_parameters_hybrid6_Q0sgm0xisingle_newB2 = nan(num_part,9);
    
for participant = 1:num_part    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0single\fmincon\res_hybrid_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0single\fmincon\res_hybrid_5',int2str(participant),'_results.mat'))
        end
    end
    all_parameters_hybrid6_Q0single(participant,:) = mEparams;
end

for participant = 1:num_part    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0sgm0single\fmincon\res_hybrid_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0sgm0single\fmincon\res_hybrid_5',int2str(participant),'_results.mat'))
        end
    end
    all_parameters_hybrid6_Q0sgm0single(participant,:) = mEparams;
end

for participant = 1:num_part    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0sgm0w0single\fmincon\res_hybrid_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0sgm0w0single\fmincon\res_hybrid_5',int2str(participant),'_results.mat'))
        end
    end
    all_parameters_hybrid6_Q0sgm0w0single(participant,:) = mEparams;
end

for participant = 1:num_part    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0sgm0w0xisingle\fmincon\res_hybrid_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0sgm0w0xisingle\fmincon\res_hybrid_5',int2str(participant),'_results.mat'))
        end
    end
    all_parameters_hybrid6_Q0sgm0w0xisingle(participant,:) = mEparams;
end

for participant = 1:num_part    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0sgm0w0xisingle_newB\fmincon\res_hybrid_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0sgm0w0xisingle_newB\fmincon\res_hybrid_5',int2str(participant),'_results.mat'))
        end
    end
    all_parameters_hybrid6_Q0sgm0w0xisingle_newB(participant,:) = mEparams;
end

for participant = 1:num_part    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0sgm0w0xisingle_newB2\fmincon\res_hybrid_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0sgm0w0xisingle_newB2\fmincon\res_hybrid_5',int2str(participant),'_results.mat'))
        end
    end
    all_parameters_hybrid6_Q0sgm0w0xisingle_newB2(participant,:) = mEparams;
end

for participant = 1:num_part    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0sgm0w0xisingle_newB3\fmincon\res_hybrid_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0sgm0w0xisingle_newB3\fmincon\res_hybrid_5',int2str(participant),'_results.mat'))
        end
    end
    all_parameters_hybrid6_Q0sgm0w0xisingle_newB3(participant,:) = mEparams;
end

for participant = 1:num_part    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0sgm0w0xisingle_newB4\fmincon\res_hybrid_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0sgm0w0xisingle_newB4\fmincon\res_hybrid_5',int2str(participant),'_results.mat'))
        end
    end
    all_parameters_hybrid6_Q0sgm0w0xisingle_newB4(participant,:) = mEparams;
end

for participant = 1:num_part    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0sgm0xisingle\fmincon\res_hybrid_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0sgm0xisingle\fmincon\res_hybrid_5',int2str(participant),'_results.mat'))
        end
    end
    all_parameters_hybrid6_Q0sgm0xisingle(participant,:) = mEparams;
end

for participant = 1:num_part    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0sgm0xisingle_newB\fmincon\res_hybrid_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0sgm0xisingle_newB\fmincon\res_hybrid_5',int2str(participant),'_results.mat'))
        end
    end
    all_parameters_hybrid6_Q0sgm0xisingle_newB(participant,:) = mEparams;
end

for participant = 1:num_part    
    if strcmp(optim_algo,'fmincon')
        if participant < 10
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0sgm0xisingle_newB2\fmincon\res_hybrid_50',int2str(participant),'_results.mat'))
        else
            load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\6params\results_Q0sgm0xisingle_newB2\fmincon\res_hybrid_5',int2str(participant),'_results.mat'))
        end
    end
    all_parameters_hybrid6_Q0sgm0xisingle_newB2(participant,:) = mEparams;
end

end