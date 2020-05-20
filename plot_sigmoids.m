
addpath('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\')

% run simulations
% save in data/
% RUN_analysis sanity_check
% RUN_analysis_average
% compare simulation average and total average 
% vary paramters to see what happens 
% do this by drug group 

part_num='501';



% matBD = plot_all_BD(part_num, mat_BD);
% matAD = plot_all_AD(part_num, mat_AD);
% matABD = plot_all_ABD(part_num, mat_ABD);
% matAB_ABD = plot_all_AB_ABD(part_num, mat_ABD); 





%% Average

i_ = 1;

for k = 501:502

        load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis\part_',int2str(k),'\mat_AB.mat'))
        matAB = plot_all_AB_2(int2str(k), mat_AB); % 2 means no saving

        condAB_short_diff(:,:,i_) = matAB.apple_difference.shortHor.prob_choosing;
        condAB_long_diff(:,:,i_) = matAB.apple_difference.longHor.prob_choosing;    
        condAB_short_mean(:,:,i_) = matAB.apple_mean.shortHor.prob_choosing;
        condAB_long_mean(:,:,i_) = matAB.apple_mean.longHor.prob_choosing;
 
%         condAD_short_diff(:,:,i_) = matAD.apple_difference.shortHor.prob_choosing;
%         condAD_long_diff(:,:,i_) = matAD.apple_difference.longHor.prob_choosing;    
%         condAD_short_mean(:,:,i_) = matAD.apple_mean.shortHor.prob_choosing;
%         condAD_long_mean(:,:,i_) = matAD.apple_mean.longHor.prob_choosing;
% 
%         condBD_short_diff(:,:,i_) = matBD.apple_difference.shortHor.prob_choosing;
%         condBD_long_diff(:,:,i_) = matBD.apple_difference.longHor.prob_choosing;    
%         condBD_short_mean(:,:,i_) = matBD.apple_mean.shortHor.prob_choosing;
%         condBD_long_mean(:,:,i_) = matBD.apple_mean.longHor.prob_choosing;
% 
%         condABD_short_diff(:,:,i_) = matABD.apple_difference.shortHor.prob_choosing;
%         condABD_long_diff(:,:,i_) = matABD.apple_difference.longHor.prob_choosing;    
%         condABD_short_mean(:,:,i_) = matABD.apple_mean.shortHor.prob_choosing;
%         condABD_long_mean(:,:,i_) = matABD.apple_mean.longHor.prob_choosing;
%         
%         condAB_ABD_short_diff(:,:,i_) = matAB_ABD.apple_difference.shortHor.prob_choosing;
%         condAB_ABD_long_diff(:,:,i_) = matAB_ABD.apple_difference.longHor.prob_choosing;
%         condAB_ABD_short_mean(:,:,i_) = matAB_ABD.apple_mean.shortHor.prob_choosing;
%         condAB_ABD_long_mean(:,:,i_) = matAB_ABD.apple_mean.longHor.prob_choosing;
        
%         histAB_all_part(:,:,i_) = hist_AB_mat; 
%         histAD_all_part(:,:,i_) = hist_AD_mat;
%         histBD_all_part(:,:,i_) = hist_BD_mat;
%         histABD_all_part(:,:,i_) = hist_ABD_mat;
%         histtot_all_part(:,:,i_) = hist_all_mat;

        i_ = i_ + 1;
        
end

plot_average_AB_2([], condAB_short_diff, condAB_short_mean, condAB_long_diff, condAB_long_mean); % 2 means no saving
% plot_average_AD(dir_all, condAD_short_diff, condAD_short_mean, condAD_long_diff, condAD_long_mean);
% plot_average_ABD(dir_all, condABD_short_diff, condABD_short_mean, condABD_long_diff, condABD_long_mean);
% plot_average_AB_from_ABD(dir_all, condAB_ABD_short_diff, condAB_ABD_short_mean, condAB_ABD_long_diff, condAB_ABD_long_mean);
% plot_average_BD(dir_all, condBD_short_diff, condBD_short_mean, condBD_long_diff, condBD_long_mean);

% [freq_tot_long, freq_tot_short, freq_AB_long, freq_AB_short, ...
%     freq_AD_long, freq_AD_short,freq_BD_long, freq_BD_short, freq_ABD_long, freq_ABD_short]...
%     = plot_average_hist(histAB_all_part, histAD_all_part, histBD_all_part, histABD_all_part, histtot_all_part);


