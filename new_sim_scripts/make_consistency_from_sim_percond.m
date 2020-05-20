


function [consistency_freq_ABC,consistency_freq_ABD, consistency_freq_BCD, consistency_freq_ACD, consistency_freq_desc] = make_consistency_from_sim_percond(data_dir)

    consistency_freq = nan(1,2);

    load(strcat(data_dir,'data.mat'));
    
    game_mat_SH_ABC = [];
    game_mat_LH_ABC = [];
    
    game_mat_SH_BCD = [];
    game_mat_LH_BCD = [];
    
    game_mat_SH_ACD = [];
    game_mat_LH_ACD = [];
    
    game_mat_SH_ABD = [];
    game_mat_LH_ABD = [];

    for g = 1:size(data,2)

        c=1;
        
        if data(c,g).unshown_tree == 1
            game_mat_SH_BCD(end+1,:) = [data(c,g).gameID data(c,g).chosen data(c,g).unshown_tree];
        elseif data(c,g).unshown_tree == 2
            game_mat_SH_ACD(end+1,:) = [data(c,g).gameID data(c,g).chosen data(c,g).unshown_tree];
        elseif data(c,g).unshown_tree == 3
            game_mat_SH_ABD(end+1,:) = [data(c,g).gameID data(c,g).chosen data(c,g).unshown_tree];
        elseif data(c,g).unshown_tree == 4
            game_mat_SH_ABC(end+1,:) = [data(c,g).gameID data(c,g).chosen data(c,g).unshown_tree];
        end

    end

    for g = 1:size(data,2)

        c=2;

        if data(c,g).unshown_tree == 1
            game_mat_LH_BCD(end+1,:) = [data(c,g).gameID data(c,g).chosen data(c,g).unshown_tree];
        elseif data(c,g).unshown_tree == 2
            game_mat_LH_ACD(end+1,:) = [data(c,g).gameID data(c,g).chosen data(c,g).unshown_tree];
        elseif data(c,g).unshown_tree == 3
            game_mat_LH_ABD(end+1,:) = [data(c,g).gameID data(c,g).chosen data(c,g).unshown_tree];
        elseif data(c,g).unshown_tree == 4
            game_mat_LH_ABC(end+1,:) = [data(c,g).gameID data(c,g).chosen data(c,g).unshown_tree];
        end

    end
        
    gameIDmaxN_ABC = max(max(game_mat_LH_ABC(:,1)), max(game_mat_SH_ABC(:,1)));
    gameIDmaxN_BCD = max(max(game_mat_LH_BCD(:,1)), max(game_mat_SH_BCD(:,1)));
    gameIDmaxN_ACD = max(max(game_mat_LH_ACD(:,1)), max(game_mat_SH_ACD(:,1)));
    gameIDmaxN_ABD = max(max(game_mat_LH_ABD(:,1)), max(game_mat_SH_ABD(:,1)));

    [game_mat_sorted_SH_ABC,index_sorted_SH_ABC] = sort(game_mat_SH_ABC(:,1),'ascend');
    [game_mat_sorted_LH_ABC,index_sorted_LH_ABC] = sort(game_mat_LH_ABC(:,1),'ascend');
    
    [game_mat_sorted_SH_ABD,index_sorted_SH_ABD] = sort(game_mat_SH_ABD(:,1),'ascend');
    [game_mat_sorted_LH_ABD,index_sorted_LH_ABD] = sort(game_mat_LH_ABD(:,1),'ascend');
    
    [game_mat_sorted_SH_ACD,index_sorted_SH_ACD] = sort(game_mat_SH_ACD(:,1),'ascend');
    [game_mat_sorted_LH_ACD,index_sorted_LH_ACD] = sort(game_mat_LH_ACD(:,1),'ascend');
    
    [game_mat_sorted_SH_BCD,index_sorted_SH_BCD] = sort(game_mat_SH_BCD(:,1),'ascend');
    [game_mat_sorted_LH_BCD,index_sorted_LH_BCD] = sort(game_mat_LH_BCD(:,1),'ascend');
    
    game_mat_sorted_SH_ABC(:,2:3) = game_mat_SH_ABC(index_sorted_SH_ABC,2:3);
    game_mat_sorted_LH_ABC(:,2:3) = game_mat_LH_ABC(index_sorted_LH_ABC,2:3);
    
    game_mat_sorted_SH_ACD(:,2:3) = game_mat_SH_ACD(index_sorted_SH_ACD,2:3);
    game_mat_sorted_LH_ACD(:,2:3) = game_mat_LH_ACD(index_sorted_LH_ACD,2:3);
    
    game_mat_sorted_SH_BCD(:,2:3) = game_mat_SH_BCD(index_sorted_SH_BCD,2:3);
    game_mat_sorted_LH_BCD(:,2:3) = game_mat_LH_BCD(index_sorted_LH_BCD,2:3);
    
    game_mat_sorted_SH_ABD(:,2:3) = game_mat_SH_ABD(index_sorted_SH_ABD,2:3);
    game_mat_sorted_LH_ABD(:,2:3) = game_mat_LH_ABD(index_sorted_LH_ABD,2:3);
    
    % ABC
    choices_LH_ABC = [];
    for i=1:100
        ind_=find(game_mat_sorted_LH_ABC(:,1)==i);
        if ~isempty(ind_)
            choices_LH_ABC(end+1,:) = [game_mat_sorted_LH_ABC(ind_,2)' i];
        end
        choices_LH_decs = {'chosen_on_sametrial_1','chosen_on_sametrial_1', 'GameID'};
    end

    choices_SH_ABC = [];
    for i=1:100
        ind_=find(game_mat_sorted_SH_ABC(:,1)==i);
        if ~isempty(ind_)
            choices_SH_ABC(end+1,:) = [game_mat_sorted_SH_ABC(ind_,2)' i];
        end
        choices_SH_decs = {'chosen_on_sametrial_1','chosen_on_sametrial_1', 'GameID'};
    end
    

    % ABD
    choices_LH_ABD = [];
    for i=1:100
        ind_=find(game_mat_sorted_LH_ABD(:,1)==i);
        if ~isempty(ind_)
            choices_LH_ABD(end+1,:) = [game_mat_sorted_LH_ABD(ind_,2)' i];
        end
        choices_LH_decs = {'chosen_on_sametrial_1','chosen_on_sametrial_1', 'GameID'};
    end

    choices_SH_ABD = [];
    for i=1:100
        ind_=find(game_mat_sorted_SH_ABD(:,1)==i);
        if ~isempty(ind_)
            choices_SH_ABD(end+1,:) = [game_mat_sorted_SH_ABD(ind_,2)' i];
        end
        choices_SH_decs = {'chosen_on_sametrial_1','chosen_on_sametrial_1', 'GameID'};
    end
    
    % BCD
    choices_LH_BCD = [];
    for i=1:100
        ind_=find(game_mat_sorted_LH_BCD(:,1)==i);
        if ~isempty(ind_)
            choices_LH_BCD(end+1,:) = [game_mat_sorted_LH_BCD(ind_,2)' i];
        end
        choices_LH_decs = {'chosen_on_sametrial_1','chosen_on_sametrial_1', 'GameID'};
    end

    choices_SH_BCD = [];
    for i=1:100
        ind_=find(game_mat_sorted_SH_BCD(:,1)==i);
        if ~isempty(ind_)
            choices_SH_BCD(end+1,:) = [game_mat_sorted_SH_BCD(ind_,2)' i];
        end
        choices_SH_decs = {'chosen_on_sametrial_1','chosen_on_sametrial_1', 'GameID'};
    end
    
    % ACD
    choices_LH_ACD = [];
    for i=1:100
        ind_=find(game_mat_sorted_LH_ACD(:,1)==i);
        if ~isempty(ind_)
            choices_LH_ACD(end+1,:) = [game_mat_sorted_LH_ACD(ind_,2)' i];
        end
        choices_LH_decs = {'chosen_on_sametrial_1','chosen_on_sametrial_1', 'GameID'};
    end

    choices_SH_ACD = [];
    for i=1:100
        ind_=find(game_mat_sorted_SH_ACD(:,1)==i);
        if ~isempty(ind_)
            choices_SH_ACD(end+1,:) = [game_mat_sorted_SH_ACD(ind_,2)' i];
        end
        choices_SH_decs = {'chosen_on_sametrial_1','chosen_on_sametrial_1', 'GameID'};
    end
    
    %
    consistency_freq_simulation_LH_ABC = sum(choices_LH_ABC(:,1)==choices_LH_ABC(:,2))/size(choices_LH_ABC,1);
    consistency_freq_simulation_SH_ABC = sum(choices_SH_ABC(:,1)==choices_SH_ABC(:,2))/size(choices_SH_ABC,1);
        
    consistency_freq_simulation_LH_ABD = sum(choices_LH_ABD(:,1)==choices_LH_ABD(:,2))/size(choices_LH_ABD,1);
    consistency_freq_simulation_SH_ABD = sum(choices_SH_ABD(:,1)==choices_SH_ABD(:,2))/size(choices_SH_ABD,1);
    
    consistency_freq_simulation_LH_BCD = sum(choices_LH_BCD(:,1)==choices_LH_BCD(:,2))/size(choices_LH_BCD,1);
    consistency_freq_simulation_SH_BCD = sum(choices_SH_BCD(:,1)==choices_SH_BCD(:,2))/size(choices_SH_BCD,1);
    
    consistency_freq_simulation_LH_ACD = sum(choices_LH_ACD(:,1)==choices_LH_ACD(:,2))/size(choices_LH_ACD,1);
    consistency_freq_simulation_SH_ACD = sum(choices_SH_ACD(:,1)==choices_SH_ACD(:,2))/size(choices_SH_ACD,1);
    
    consistency_freq_ABC(1,:) = [consistency_freq_simulation_LH_ABC consistency_freq_simulation_SH_ABC];
    consistency_freq_ABD(1,:) = [consistency_freq_simulation_LH_ABD consistency_freq_simulation_SH_ABD];
    consistency_freq_BCD(1,:) = [consistency_freq_simulation_LH_BCD consistency_freq_simulation_SH_BCD];
    consistency_freq_ACD(1,:) = [consistency_freq_simulation_LH_ACD consistency_freq_simulation_SH_ACD];

    consistency_freq_desc = {'LH_Consistent','SH_Consistent'};
    
end

