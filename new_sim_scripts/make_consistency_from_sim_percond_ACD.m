


function [consistency_freq_ACD, consistency_freq_desc] = make_consistency_from_sim_percond_ACD(data_dir)

    consistency_freq = nan(1,2);

    load(strcat(data_dir,'data.mat'));
    
    game_mat_SH_ACD = [];
    game_mat_LH_ACD = [];

    for g = 1:size(data,2)

        c=1;
        
        if data(c,g).unshown_tree == 2
            game_mat_SH_ACD(end+1,:) = [data(c,g).gameID data(c,g).chosen data(c,g).unshown_tree];
        end

    end

    for g = 1:size(data,2)

        c=2;

        if data(c,g).unshown_tree == 2
            game_mat_LH_ACD(end+1,:) = [data(c,g).gameID data(c,g).chosen data(c,g).unshown_tree];
        end

    end
        
    gameIDmaxN_ACD = max(max(game_mat_LH_ACD(:,1)), max(game_mat_SH_ACD(:,1)));
    
    [game_mat_sorted_SH_ACD,index_sorted_SH_ACD] = sort(game_mat_SH_ACD(:,1),'ascend');
    [game_mat_sorted_LH_ACD,index_sorted_LH_ACD] = sort(game_mat_LH_ACD(:,1),'ascend');
    
    game_mat_sorted_SH_ACD(:,2:3) = game_mat_SH_ACD(index_sorted_SH_ACD,2:3);
    game_mat_sorted_LH_ACD(:,2:3) = game_mat_LH_ACD(index_sorted_LH_ACD,2:3);
    

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
    
    consistency_freq_simulation_LH_ACD = sum(choices_LH_ACD(:,1)==choices_LH_ACD(:,2))/size(choices_LH_ACD,1);
    consistency_freq_simulation_SH_ACD = sum(choices_SH_ACD(:,1)==choices_SH_ACD(:,2))/size(choices_SH_ACD,1);
    
    consistency_freq_ACD(1,:) = [consistency_freq_simulation_LH_ACD consistency_freq_simulation_SH_ACD];

    consistency_freq_desc = {'LH_Consistent','SH_Consistent'};
    
end

