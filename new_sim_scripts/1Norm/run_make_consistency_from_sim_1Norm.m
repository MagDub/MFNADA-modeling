
consistency_freq_simulation_1Norm = nan(60,2);

num_trials = 10*400;

for ID = 501:560
    
    load(strcat('D:\MaggiesFarm\modeling_28_02\simulation_data\simulated_data_from_fitted_params_mod12_1norm\num_trials_',int2str(num_trials),'\participant_',int2str(ID),'\data.mat'))

    %data(1,:) = short horizon
    %data(2,:) = long horizon

    game_mat_SH = [];
    game_mat_LH = [];

    for g = 1:size(data,2)

        c=1;

        game_mat_SH(end+1,:) = [data(c,g).gameID data(c,g).chosen data(c,g).unshown_tree];

    end

    for g = 1:size(data,2)

        c=2;

        game_mat_LH(end+1,:) = [data(c,g).gameID data(c,g).chosen data(c,g).unshown_tree];

    end

    gameIDmaxN = max(max(game_mat_LH(:,1)), max(game_mat_SH(:,1)));

    [game_mat_sorted_SH,index_sorted_SH] = sort(game_mat_SH(:,1),'ascend');
    [game_mat_sorted_LH,index_sorted_LH] = sort(game_mat_LH(:,1),'ascend');

    game_mat_sorted_SH(:,2:3) = game_mat_SH(index_sorted_SH,2:3);
    game_mat_sorted_LH(:,2:3) = game_mat_LH(index_sorted_LH,2:3);

    for i=1:gameIDmaxN
        ind_=find(game_mat_sorted_LH(:,1)==i);
        choices_LH(i,:) = game_mat_sorted_LH(ind_,2)';
        choices_LH_decs = {'chosen_on_sametrial_1','chosen_on_sametrial_1'};
    end

    for i=1:gameIDmaxN
        ind_=find(game_mat_sorted_SH(:,1)==i);
        choices_SH(i,:) = game_mat_sorted_SH(ind_,2)';
        choices_SH_decs = {'chosen_on_sametrial_1','chosen_on_sametrial_1'};
    end

    consistency_freq_simulation_1Norm_LH = sum(choices_LH(:,1)==choices_LH(:,2))/size(choices_LH,1);
    consistency_freq_simulation_1Norm_SH = sum(choices_SH(:,1)==choices_SH(:,2))/size(choices_SH,1);

    consistency_freq_simulation_1Norm(ID-500,:) = [consistency_freq_simulation_1Norm_LH consistency_freq_simulation_1Norm_SH];
end

consistency_freq_simulation_1Norm_desc = {'LH_Consistent','SH_Consistent'};

save('D:\writing\MF\data_for_figs\consistency_freq_simulation_1Norm.mat', 'consistency_freq_simulation_1Norm');
save('D:\writing\MF\data_for_figs\consistency_freq_simulation_1Norm_desc.mat', 'consistency_freq_simulation_1Norm_desc');

