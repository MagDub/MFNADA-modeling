


function [consistency_freq, consistency_freq_desc] = make_consistency_from_sim(data_dir)

    consistency_freq = [];

    load(strcat(data_dir,'data.mat'))

    game_mat_SH = [];

    for g = 1:size(data,2)

        c=1;

        game_mat_SH(end+1,:) = [data(c,g).gameID data(c,g).chosen data(c,g).unshown_tree];

    end
    
    gameIDmaxN = max(game_mat_SH(:,1));

    [game_mat_sorted_SH,index_sorted_SH] = sort(game_mat_SH(:,1),'ascend');
    
    game_mat_sorted_SH(:,2:3) = game_mat_SH(index_sorted_SH,2:3);

    for i=1:gameIDmaxN
        ind_=find(game_mat_sorted_SH(:,1)==i);
        choices_SH(i,:) = game_mat_sorted_SH(ind_,2)';
        choices_SH_decs = {'chosen_on_sametrial_1','chosen_on_sametrial_1'};
    end

    consistency_freq_simulation_SH = sum(choices_SH(:,1)==choices_SH(:,2))/size(choices_SH,1);

    consistency_freq(1,:) = [consistency_freq_simulation_SH];

    consistency_freq_desc = {'SH_Consistent'};
    
end

