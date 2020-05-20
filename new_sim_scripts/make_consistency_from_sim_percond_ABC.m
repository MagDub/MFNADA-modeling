


function [consistency_freq_ABC, consistency_freq_desc] = make_consistency_from_sim_percond_ABC(data_dir)

    consistency_freq = nan(1,2);

    load(strcat(data_dir,'data.mat'));
    
    game_mat_SH_ABC = [];
    game_mat_LH_ABC = [];

    for g = 1:size(data,2)

        c=1;
        
        if data(c,g).unshown_tree == 4
            game_mat_SH_ABC(end+1,:) = [data(c,g).gameID data(c,g).chosen data(c,g).unshown_tree];
        end

    end

    for g = 1:size(data,2)

        c=2;

        if data(c,g).unshown_tree == 4
            game_mat_LH_ABC(end+1,:) = [data(c,g).gameID data(c,g).chosen data(c,g).unshown_tree];
        end

    end
        
    gameIDmaxN_ABC = max(max(game_mat_LH_ABC(:,1)), max(game_mat_SH_ABC(:,1)));
    
    [game_mat_sorted_SH_ABC,index_sorted_SH_ABC] = sort(game_mat_SH_ABC(:,1),'ascend');
    [game_mat_sorted_LH_ABC,index_sorted_LH_ABC] = sort(game_mat_LH_ABC(:,1),'ascend');
    
    game_mat_sorted_SH_ABC(:,2:3) = game_mat_SH_ABC(index_sorted_SH_ABC,2:3);
    game_mat_sorted_LH_ABC(:,2:3) = game_mat_LH_ABC(index_sorted_LH_ABC,2:3);
    

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
    
    consistency_freq_simulation_LH_ABC = sum(choices_LH_ABC(:,1)==choices_LH_ABC(:,2))/size(choices_LH_ABC,1);
    consistency_freq_simulation_SH_ABC = sum(choices_SH_ABC(:,1)==choices_SH_ABC(:,2))/size(choices_SH_ABC,1);
    
    consistency_freq_ABC(1,:) = [consistency_freq_simulation_LH_ABC consistency_freq_simulation_SH_ABC];

    consistency_freq_desc = {'LH_Consistent','SH_Consistent'};
    
end

