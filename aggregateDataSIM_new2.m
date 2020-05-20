function [data,tmp_gameIDs] = aggregateDataSIM_new2(params, user)

%% loop through games and aggregate
data_SH = [];
data_LH = [];

gameIDs_SH = [];
gameIDs_LH = [];

i_SH = 0;
i_LH = 0;

%user.log = {'Block','Blocktrial','Horizon','GameID','Trial','TreeA','TreeB','TreeC','TreeD','Size','RT','PressedKey', 'Unused Tree'};

tmp_user_log = user.log(user.log(:,5)==1,:);
size(unique(tmp_user_log(:,4)))

if size(unique(tmp_user_log(:,4)),1)~200
    disp('Should be 200 !!')
end

for b = 1:params.task.exp.n_blocks
    for g = 1:params.task.exp.n_trialPB
        
        % index of trials in this games
        idx = find(user.log(:,1) == b & user.log(:,2) == g & user.log(:,3) == 6);
        
        if ~isempty(idx)
        
            gameIDs_SH(end+1) = user.log(idx(1),4);
            i_SH = i_SH + 1;

            % tree A
            idx_a = idx(find(user.log(idx,6)==1));
            if ~isempty(idx_a)
                tmp_SH.a = user.log(idx_a,10);
            else
                tmp_SH.a = [];
            end

            % tree B
            idx_b = idx(find(user.log(idx,7)==1));
            if ~isempty(idx_b)
                tmp_SH.b = user.log(idx_b,10);
            else
                tmp_SH.b = [];
            end


            % tree D
            idx_d = idx(find(user.log(idx,9)==1));
            if ~isempty(idx_d)
                tmp_SH.d = user.log(idx_d,10);
            else
                tmp_SH.d = [];
            end

            tmp_SH.unshown_tree = user.log(idx(1),13);
            tmp_SH.alltrees = user.log(idx,6:10); % trees a-d shown, values
            tmp_alltrees_SH = tmp_SH.alltrees;
            tmp_alltrees_SH(:,tmp_SH.unshown_tree) = [];
            tmp_SH.allshowntrees = tmp_alltrees_SH;
            tmp_SH.gameNo = (b-1)*params.task.exp.n_trialPB + g; % overall game number
            data_SH(i_SH).a = tmp_SH.a;
            data_SH(i_SH).b = tmp_SH.b;
            data_SH(i_SH).d = tmp_SH.d;
            data_SH(i_SH).unshown_tree = tmp_SH.unshown_tree;
            data_SH(i_SH).alltrees = tmp_SH.alltrees;
            data_SH(i_SH).allshowntrees = tmp_SH.allshowntrees;
            data_SH(i_SH).gameNo = tmp_SH.gameNo;
            
            idx = [];
        end
        
    end
end

for b = 1:params.task.exp.n_blocks
    for g = 1:params.task.exp.n_trialPB
        
        % index of trials in this games
        idx = find(user.log(:,1) == b & user.log(:,2) == g & user.log(:,3) == 11);
        
        if ~isempty(idx)
        
            gameIDs_LH(end+1) = user.log(idx(1),4);
            i_LH = i_LH + 1;

            % tree A
            idx_a = idx(find(user.log(idx,6)==1));
            if ~isempty(idx_a)
                tmp_LH.a = user.log(idx_a,10);
            else
                tmp_LH.a = [];
            end

            % tree B
            idx_b = idx(find(user.log(idx,7)==1));
            if ~isempty(idx_b)
                tmp_LH.b = user.log(idx_b,10);
            else
                tmp_LH.b = [];
            end


            % tree D
            idx_d = idx(find(user.log(idx,9)==1));
            if ~isempty(idx_d)
                tmp_LH.d = user.log(idx_d,10);
            else
                tmp_LH.d = [];
            end

            tmp_LH.unshown_tree = user.log(idx(1),13);
            tmp_LH.alltrees = user.log(idx,6:10); % trees a-d shown, values
            tmp_alltrees_LH = tmp_LH.alltrees;
            tmp_alltrees_LH(:,tmp_LH.unshown_tree) = [];
            tmp_LH.allshowntrees = tmp_alltrees_LH;
            tmp_LH.gameNo = (b-1)*params.task.exp.n_trialPB + g; % overall game number
            data_LH(i_LH).a = tmp_LH.a;
            data_LH(i_LH).b = tmp_LH.b;
            data_LH(i_LH).d = tmp_LH.d;
            data_LH(i_LH).unshown_tree = tmp_LH.unshown_tree;
            data_LH(i_LH).alltrees = tmp_LH.alltrees;
            data_LH(i_LH).allshowntrees = tmp_LH.allshowntrees;
            data_LH(i_LH).gameNo = tmp_LH.gameNo;
            
            idx = [];
        end

    end
end

%test
tmp_gameNo_SH = [];
tmp_gameNo_LH = [];
for i = 1:size(data_SH,2)
    tmp_gameNo_SH(end+1) = data_SH(i).gameNo;
    tmp_gameNo_LH(end+1) = data_LH(i).gameNo;
end
tmp_gameNo = [tmp_gameNo_SH tmp_gameNo_LH];
sort(tmp_gameNo)

tmp_gameIDs = [gameIDs_SH gameIDs_LH];

for i = 1:size(data_SH,2)
    
    data(1,i).a = data_SH(i).a;
    data(2,i).a = data_LH(i).a;
    
    data(1,i).b = data_SH(i).b;
    data(2,i).b = data_LH(i).b;
    
    data(1,i).d = data_SH(i).d;
    data(2,i).d = data_LH(i).d;
    
    data(1,i).unshown_tree = data_SH(i).unshown_tree;
    data(2,i).unshown_tree = data_LH(i).unshown_tree;
    
    data(1,i).allshowntrees = data_SH(i).allshowntrees;
    data(2,i).allshowntrees = data_LH(i).allshowntrees;
    
    data(1,i).alltrees = data_SH(i).alltrees;
    data(2,i).alltrees = data_LH(i).alltrees;
    
    data(1,i).gameNo = data_SH(i).gameNo;
    data(2,i).gameNo = data_LH(i).gameNo;

end