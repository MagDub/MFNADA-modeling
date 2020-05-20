
addpath('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\')

% run simulations
% save in data/
% RUN_analysis sanity_check
% RUN_analysis_average
% compare simulation average and total average 
% vary paramters to see what happens 
% do this by drug group 

plot_average_AB = 0;

if plot_average_AB == 1
    
    i_ = 1;

    for k = 501%:502

            load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis\part_',int2str(k),'\mat_AB.mat'))
            load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis\part_',int2str(k),'\mat_ABD.mat')) 
            load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis\part_',int2str(k),'\mat_AD.mat'))
            load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis\part_',int2str(k),'\mat_BD.mat'))

            matAB = plot_all_AB_2(int2str(k), mat_AB); % 2 means no saving
            matAB_ABD = plot_all_AB_ABD_2(int2str(k), mat_ABD);

            condAB_short_diff(:,:,i_) = matAB.apple_difference.shortHor.prob_choosing;
            condAB_long_diff(:,:,i_) = matAB.apple_difference.longHor.prob_choosing;    
            condAB_short_mean(:,:,i_) = matAB.apple_mean.shortHor.prob_choosing;
            condAB_long_mean(:,:,i_) = matAB.apple_mean.longHor.prob_choosing;

            condAB_ABD_short_diff(:,:,i_) = matAB_ABD.apple_difference.shortHor.prob_choosing;
            condAB_ABD_long_diff(:,:,i_) = matAB_ABD.apple_difference.longHor.prob_choosing;
            condAB_ABD_short_mean(:,:,i_) = matAB_ABD.apple_mean.shortHor.prob_choosing;
            condAB_ABD_long_mean(:,:,i_) = matAB_ABD.apple_mean.longHor.prob_choosing;

            i_ = i_ + 1;

    end

    close all; 

    plot_average_AB_2([], condAB_short_diff, condAB_short_mean, condAB_long_diff, condAB_long_mean); % 2 means no saving
    plot_average_AB_from_ABD_2([], condAB_ABD_short_diff, condAB_ABD_short_mean, condAB_ABD_long_diff, condAB_ABD_long_mean);

end


C_is_higher_in_longH = [];
C_is_higher_in_shortH = [];

B_is_higher_in_longH = [];
B_is_higher_in_shortH = [];

plot_hist = 0;

for k = 501:560

    load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis\part_',int2str(k),'\hist_all.mat'))
    
    if plot_hist == 1

        hist_centers = 1:0.25:4;

        %make_hist_figure2(mat_AB, mat_ABD, mat_AD, mat_BD, int2str(k), []);

        histogram(hist_all_mat(1,:)-0.15,hist_centers-0.15, 'Normalization', 'probability'); hold on; % short horizon
        histogram(hist_all_mat(2,:)+0.15,hist_centers+0.15, 'Normalization', 'probability'); % long horizon

        set(gca, 'XTick', 1.1:1:4.1);
        xticklabels({'A','B','C','D'})
        xlabel('Tree')
        ylabel('Probability')
        legend('Short horizon', 'Long horizon')
        title('All trials')
    end

    C_in_shortH = size(find(hist_all_mat(1,:)==3),2);
    B_in_shortH = size(find(hist_all_mat(1,:)==2),2);
    C_in_longH = size(find(hist_all_mat(2,:)==3),2);
    B_in_longH = size(find(hist_all_mat(2,:)==2),2);

    if (C_in_longH >= C_in_shortH) 
        C_is_higher_in_longH(end+1) = k;
    else
        C_is_higher_in_shortH(end+1) = k;
    end

    if (B_in_longH >= B_in_shortH) 
        B_is_higher_in_longH(end+1) = k;
    else
        B_is_higher_in_shortH(end+1) = k;
    end

end

save('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis\all_part\C_is_higher_in_longH.mat', 'C_is_higher_in_longH')
save('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis\all_part\C_is_higher_in_shortH.mat', 'C_is_higher_in_shortH')

save('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis\all_part\B_is_higher_in_longH.mat', 'B_is_higher_in_longH')
save('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis\all_part\B_is_higher_in_shortH.mat', 'B_is_higher_in_shortH')









