


function [consistency_freq_ABD, consistency_freq_desc] = make_consistency_from_sim_percond_ABD(data_dir)

    consistency_freq = nan(1,2);

    load(strcat(data_dir,'data.mat'));
    
    game_mat_SH_ABD = [];
    game_mat_LH_ABD = [];

    for g = 1:size(data,2)

        c=1;
        
        if data(c,g).unshown_tree == 3
            game_mat_SH_ABD(end+1,:) = [data(c,g).gameID data(c,g).chosen data(c,g).unshown_tree];
        end

    end

    for g = 1:size(data,2)

        c=2;

        if data(c,g).unshown_tree == 3
            game_mat_LH_ABD(end+1,:) = [data(c,g).gameID data(c,g).chosen data(c,g).unshown_tree];
        end

    end
        
    gameIDmaxN_ABD = max(max(game_mat_LH_ABD(:,1)), max(game_mat_SH_ABD(:,1)));
    
    [game_mat_sorted_SH_ABD,index_sorted_SH_ABD] = sort(game_mat_SH_ABD(:,1),'ascend');
    [game_mat_sorted_LH_ABD,index_sorted_LH_ABD] = sort(game_mat_LH_ABD(:,1),'ascend');
    
    game_mat_sorted_SH_ABD(:,2:3) = game_mat_SH_ABD(index_sorted_SH_ABD,2:3);
    game_mat_sorted_LH_ABD(:,2:3) = game_mat_LH_ABD(index_sorted_LH_ABD,2:3);
    

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
    
    consistency_freq_simulation_LH_ABD = sum(choices_LH_ABD(:,1)==choices_LH_ABD(:,2))/size(choices_LH_ABD,1);
    consistency_freq_simulation_SH_ABD = sum(choices_SH_ABD(:,1)==choices_SH_ABD(:,2))/size(choices_SH_ABD,1);
    
    consistency_freq_ABD(1,:) = [consistency_freq_simulation_LH_ABD consistency_freq_simulation_SH_ABD];

    consistency_freq_desc = {'LH_Consistent','SH_Consistent'};
    
end

