


function [consistency_freq_BCD, consistency_freq_desc] = make_consistency_from_sim_percond_BCD(data_dir)

    consistency_freq = nan(1,2);

    load(strcat(data_dir,'data.mat'));
    
    game_mat_SH_BCD= [];
    game_mat_LH_BCD= [];

    for g = 1:size(data,2)

        c=1;
        
        if data(c,g).unshown_tree == 1
            game_mat_SH_BCD(end+1,:) = [data(c,g).gameID data(c,g).chosen data(c,g).unshown_tree];
        end

    end

    for g = 1:size(data,2)

        c=2;

        if data(c,g).unshown_tree == 1
            game_mat_LH_BCD(end+1,:) = [data(c,g).gameID data(c,g).chosen data(c,g).unshown_tree];
        end

    end
        
    gameIDmaxN_BCD= max(max(game_mat_LH_BCD(:,1)), max(game_mat_SH_BCD(:,1)));
    
    [game_mat_sorted_SH_BCD,index_sorted_SH_BCD] = sort(game_mat_SH_BCD(:,1),'ascend');
    [game_mat_sorted_LH_BCD,index_sorted_LH_BCD] = sort(game_mat_LH_BCD(:,1),'ascend');
    
    game_mat_sorted_SH_BCD(:,2:3) = game_mat_SH_BCD(index_sorted_SH_BCD,2:3);
    game_mat_sorted_LH_BCD(:,2:3) = game_mat_LH_BCD(index_sorted_LH_BCD,2:3);
    

    % BCD
    choices_LH_BCD= [];
    for i=1:100
        ind_=find(game_mat_sorted_LH_BCD(:,1)==i);
        if ~isempty(ind_)
            choices_LH_BCD(end+1,:) = [game_mat_sorted_LH_BCD(ind_,2)' i];
        end
        choices_LH_decs = {'chosen_on_sametrial_1','chosen_on_sametrial_1', 'GameID'};
    end

    choices_SH_BCD= [];
    for i=1:100
        ind_=find(game_mat_sorted_SH_BCD(:,1)==i);
        if ~isempty(ind_)
            choices_SH_BCD(end+1,:) = [game_mat_sorted_SH_BCD(ind_,2)' i];
        end
        choices_SH_decs = {'chosen_on_sametrial_1','chosen_on_sametrial_1', 'GameID'};
    end
    
    consistency_freq_simulation_LH_BCD= sum(choices_LH_BCD(:,1)==choices_LH_BCD(:,2))/size(choices_LH_BCD,1);
    consistency_freq_simulation_SH_BCD= sum(choices_SH_BCD(:,1)==choices_SH_BCD(:,2))/size(choices_SH_BCD,1);
    
    consistency_freq_BCD(1,:) = [consistency_freq_simulation_LH_BCD consistency_freq_simulation_SH_BCD];

    consistency_freq_desc = {'LH_Consistent','SH_Consistent'};
    
end

