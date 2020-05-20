function [data,gameIDs] = aggregateData(sID,data_dir)

if nargin < 2
    data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\';
end

%% load data
list = dir([data_dir '*_' int2str(sID) '_user_params.mat']);
if length(list) > 1
    warning(['subject ' num2str(sID) ' has more than one files - taking last one.'])
elseif isempty(list)
    error(['No file for subject ' num2str(sID)])
end
load([data_dir list(end).name])

%% loop through games and aggregate
data = []; i6 = 1; i11 = 1;
gameIDs = [];

for b = 1:params.task.exp.n_blocks
    for g = 1:params.task.exp.n_trialPB
        
        % index of trials in this games
        idx = find(user.log(:,1) == b & user.log(:,2) == g);
        
        % determine condition (horizon)
        if user.log(idx(1),3) == 6
            i = i6;
            i6 = i6 + 1;
            h_idx = 1;  % index for horizon
        elseif user.log(idx(1),3) == 11
            i = i11;
            i11 = i11 + 1;
            h_idx = 2;  % index for horizon
        else
            error('unknown horizon')
        end
        
        % get first choice
        idx_chos = idx(find(~isnan(user.log(idx,12)),1,'first'));
        data(h_idx,i).chosen = find(~isnan(user.log(idx_chos,6:9)));
        
        % write down gameID
        gameIDs(h_idx,i) = user.log(idx_chos,4);
        
        % aggregate previous trees
        idx_nonchos = idx(find(isnan(user.log(idx,12))));
        
        % tree A
        idx_a = idx_nonchos(find(user.log(idx_nonchos,6)==1));
        if ~isempty(idx_a)
            data(h_idx,i).a = user.log(idx_a,10);
        else
            data(h_idx,i).a = [];
        end
        
        % tree B
        idx_b = idx_nonchos(find(user.log(idx_nonchos,7)==1));
        if ~isempty(idx_b)
            data(h_idx,i).b = user.log(idx_b,10);
        else
            data(h_idx,i).b = [];
        end
        
        % tree C
        idx_c = idx_nonchos(find(user.log(idx_nonchos,8)==1));
        if ~isempty(idx_c)
            data(h_idx,i).c = user.log(idx_c,10);
        else
            data(h_idx,i).c = [];
        end
        
        % tree D
        idx_d = idx_nonchos(find(user.log(idx_nonchos,9)==1));
        if ~isempty(idx_d)
            data(h_idx,i).d = user.log(idx_d,10);
        else
            data(h_idx,i).d = [];
        end
        
        data(h_idx,i).unshown_tree = unique(user.log(idx_nonchos,13));
        
        % all non-choices in one matrix
        data(h_idx,i).alltrees = user.log(idx_nonchos,6:10); % trees a-d chosen, value obtained
        
        % alltrees without the unswhon_tree
        tmp_alltrees = data(h_idx,i).alltrees;
        tmp_alltrees(:,data(h_idx,i).unshown_tree) = [];
        data(h_idx,i).allshowntrees = tmp_alltrees; 
        
        % overall game number
        data(h_idx,i).gameNo = (b-1)*params.task.exp.n_trialPB + g;
    end
end