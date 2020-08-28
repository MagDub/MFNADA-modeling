
 
sgm0 = 1.312;
xi = 0.1;
Q0 = 3.200;
part_num = 200;

eta_range = [0,1,2,3];

sim_folder = strcat('../../../data/simulation_data/sim_prob_mod12/changing_eta/sgm0_',num2str(sgm0),'_Q0_',num2str(Q0),'_xi_',num2str(xi),'/');

mean_consistency = [];
SEM_consistency = [];

for eta_iter = 1%:size(eta_range,2)
    
    eta = eta_range(eta_iter);
    
    for ID = 1%:part_num
        
        eta_file = strcat('eta_',num2str(eta_range(eta_iter)));

        sim_data_dir = strcat(sim_folder,eta_file,'/participant_',int2str(ID),'/');
        
        tmp_const = load(strcat(sim_data_dir,'sim_consistency_freq.mat'));
        
        tmp_trees = load(strcat(sim_data_dir,'sim_prob_choosing_exploit_trees_new_data.mat'));
        
        tmp_trees_bandits = load(strcat(sim_data_dir,'sim_prob_choosing_trees_new_data.mat'));
        
        mat_consistency(ID,:) = tmp_const.sim_consistency_freq*100; 
        
        mat_trees(ID,:) = tmp_trees.sim_prob_choosing_exploit_trees_new_data*100; % exploit, explore, C_SH, D_SH
    
        mat_trees_bandits(ID,:) = tmp_trees_bandits.sim_prob_choosing_trees_new_data*100; % A, B, C, D

    end
    
    mean_SEM_consistency(eta_iter,:) = [eta_SH eta_LH mean(mat_consistency,1) std(mat_consistency,1)];
    
    mean_SEM_tree_high(eta_iter,:) = [eta_SH eta_LH mean(mat_trees(:,1)) mean(mat_trees(:,5)) std(mat_trees(:,1)) std(mat_trees(:,5))];
    mean_SEM_tree_medium(eta_iter,:) = [eta_SH eta_LH mean(mat_trees(:,2)) mean(mat_trees(:,6)) std(mat_trees(:,2)) std(mat_trees(:,6))];
    mean_SEM_tree_novel(eta_iter,:) = [eta_SH eta_LH mean(mat_trees(:,3)) mean(mat_trees(:,7)) std(mat_trees(:,3)) std(mat_trees(:,7))];
    mean_SEM_tree_low(eta_iter,:) = [eta_SH eta_LH mean(mat_trees(:,4)) mean(mat_trees(:,8)) std(mat_trees(:,4)) std(mat_trees(:,8))];
    
    mean_SEM_tree_standard_certain(eta_iter,:) = [eta_SH eta_LH mean(mat_trees_bandits(:,1)) mean(mat_trees_bandits(:,5)) std(mat_trees_bandits(:,1)) std(mat_trees_bandits(:,5))];
    mean_SEM_tree_standard(eta_iter,:) = [eta_SH eta_LH mean(mat_trees_bandits(:,2)) mean(mat_trees_bandits(:,6)) std(mat_trees_bandits(:,2)) std(mat_trees_bandits(:,6))];
    
end

mat_mean_SEM_consistency = [mean_SEM_consistency(:,1) mean_SEM_consistency(:,3) mean_SEM_consistency(:,5); ...
                            mean_SEM_consistency(:,2) mean_SEM_consistency(:,4) mean_SEM_consistency(:,6)];

mat_mean_SEM_tree_high = [mean_SEM_tree_high(:,1) mean_SEM_tree_high(:,3) mean_SEM_tree_high(:,5); ...
                            mean_SEM_tree_high(:,2) mean_SEM_tree_high(:,4) mean_SEM_tree_high(:,6)];
                        
mat_mean_SEM_tree_medium = [mean_SEM_tree_medium(:,1) mean_SEM_tree_medium(:,3) mean_SEM_tree_medium(:,5); ...
                            mean_SEM_tree_medium(:,2) mean_SEM_tree_medium(:,4) mean_SEM_tree_medium(:,6)];

mat_mean_SEM_tree_novel = [mean_SEM_tree_novel(:,1) mean_SEM_tree_novel(:,3) mean_SEM_tree_novel(:,5); ...
                            mean_SEM_tree_novel(:,2) mean_SEM_tree_novel(:,4) mean_SEM_tree_novel(:,6)];
                                          
mat_mean_SEM_tree_low = [mean_SEM_tree_low(:,1) mean_SEM_tree_low(:,3) mean_SEM_tree_low(:,5); ...
                            mean_SEM_tree_low(:,2) mean_SEM_tree_low(:,4) mean_SEM_tree_low(:,6)];
                        
mat_mean_SEM_tree_standard_certain = [mean_SEM_tree_standard_certain(:,1) mean_SEM_tree_standard_certain(:,3) mean_SEM_tree_standard_certain(:,5); ...
    mean_SEM_tree_standard_certain(:,2) mean_SEM_tree_standard_certain(:,4) mean_SEM_tree_standard_certain(:,6)];
                        
mat_mean_SEM_tree_standard = [mean_SEM_tree_standard(:,1) mean_SEM_tree_standard(:,3) mean_SEM_tree_standard(:,5); ...
    mean_SEM_tree_standard(:,2) mean_SEM_tree_standard(:,4) mean_SEM_tree_standard(:,6)];

save('../../../data/simulation_data/sim_prob_mod12/changing_eta/sgm0_1.312_Q0_3.2_xi_0.1/mat_mean_SEM_consistency.mat', 'mat_mean_SEM_consistency');    
save('../../../data/simulation_data/sim_prob_mod12/changing_eta/sgm0_1.312_Q0_3.2_xi_0.1/mat_mean_SEM_tree_high.mat', 'mat_mean_SEM_tree_high');  
save('../../../data/simulation_data/sim_prob_mod12/changing_eta/sgm0_1.312_Q0_3.2_xi_0.1/mat_mean_SEM_tree_medium.mat', 'mat_mean_SEM_tree_medium');  
save('../../../data/simulation_data/sim_prob_mod12/changing_eta/sgm0_1.312_Q0_3.2_xi_0.1/mat_mean_SEM_tree_novel.mat', 'mat_mean_SEM_tree_novel');  
save('../../../data/simulation_data/sim_prob_mod12/changing_eta/sgm0_1.312_Q0_3.2_xi_0.1/mat_mean_SEM_tree_low.mat', 'mat_mean_SEM_tree_low'); 
save('../../../data/simulation_data/sim_prob_mod12/changing_eta/sgm0_1.312_Q0_3.2_xi_0.1/mat_mean_SEM_tree_standard_certain.mat', 'mat_mean_SEM_tree_standard_certain');  
save('../../../data/simulation_data/sim_prob_mod12/changing_eta/sgm0_1.312_Q0_3.2_xi_0.1/mat_mean_SEM_tree_standard.mat', 'mat_mean_SEM_tree_standard'); 
                                               
col=[];

col(1,:) = [0.803921580314636 0.878431379795074 0.968627452850342];

% out_dir = 'D:\writing\MF\figs\sim_changing_eta\';
% addpath('D:\writing\export_fig')

% %% picked A
% 
% figure('Color','w');
% set(gcf,'Unit','centimeters','OuterPosition',[0 0 8 8]);
% set(gca,'FontName','Arial','FontSize',9)
% hold on
% 
% bar(mat_mean_SEM_tree_high([1 3],1),mat_mean_SEM_tree_high([1 3],2),'FaceColor',col, 'FaceAlpha', 1, 'BarWidth',0.8); hold on;
% errorbar(mat_mean_SEM_tree_high([1 3],1),mat_mean_SEM_tree_high([1 3],2),mat_mean_SEM_tree_high([1 3],3),'.','color','k', 'LineWidth',0.8);
% 
% ylabel('Proportion of draws [%]','FontName','Arial','Fontweight','bold','FontSize',9);
% xlabel('Novelty exploration')          
% title('High-value bandit')
% 
% ylim([0 78])
% xlim([-1.5 3.5])
% xticks([0 2])
% xticklabels({'Low','High'});
% yticks(0:15:100)
% 
% export_fig([out_dir 'Fig_high_value_bin.tif'],'-nocrop','-r200')
% 
% 
% %% picked B
% 
% figure('Color','w');
% set(gcf,'Unit','centimeters','OuterPosition',[0 0 8 8]);
% set(gca,'FontName','Arial','FontSize',9)
% hold on
% 
% bar(mat_mean_SEM_tree_medium([1 3],1),mat_mean_SEM_tree_medium([1 3],2),'FaceColor',col, 'FaceAlpha', 1, 'BarWidth',0.8); hold on;
% errorbar(mat_mean_SEM_tree_medium([1 3],1),mat_mean_SEM_tree_medium([1 3],2),mat_mean_SEM_tree_medium([1 3],3),'.','color','k', 'LineWidth',0.8);
% 
% ylabel('Proportion of draws [%]','FontName','Arial','Fontweight','bold','FontSize',9);
% xlabel('Novelty exploration')          
% title('Medium-value bandit')
% 
% ylim([0 16.5])
% xlim([-1.5 3.5])
% xticks([0 2])
% xticklabels({'Low','High'});
% yticks(0:4:100)
% 
% export_fig([out_dir 'Fig_medium_value_bin.tif'],'-nocrop','-r200')
% 
% %% picked C
% 
% figure('Color','w');
% set(gcf,'Unit','centimeters','OuterPosition',[0 0 8 8]);
% set(gca,'FontName','Arial','FontSize',9)
% hold on
% 
% bar(mat_mean_SEM_tree_novel([1 3],1),mat_mean_SEM_tree_novel([1 3],2),'FaceColor',col, 'FaceAlpha', 1, 'BarWidth',0.8); hold on;
% errorbar(mat_mean_SEM_tree_novel([1 3],1),mat_mean_SEM_tree_novel([1 3],2),mat_mean_SEM_tree_novel([1 3],3),'.','color','k', 'LineWidth',0.8);
% 
% ylabel('Proportion of draws [%]','FontName','Arial','Fontweight','bold','FontSize',9);
% xlabel('Novelty exploration')          
% title('Novel bandit')
% 
% ylim([0 70.5])
% xlim([-1.5 3.5])
% xticks([0 2])
% xticklabels({'Low','High'});
% yticks(0:15:75)
% 
% % export_fig([out_dir 'Fig_novel_bin.tif'],'-nocrop','-r200')
% 
% % %% picked D
% % 
% % figure('Color','w');
% % set(gcf,'Unit','centimeters','OuterPosition',[0 0 8 8]);
% % set(gca,'FontName','Arial','FontSize',9)
% % hold on
% % 
% % bar(mat_mean_SEM_tree_low([1 3],1),mat_mean_SEM_tree_low([1 3],2),'FaceColor',col, 'FaceAlpha', 1, 'BarWidth',0.8); hold on;
% % errorbar(mat_mean_SEM_tree_low([1 3],1),mat_mean_SEM_tree_low([1 3],2),mat_mean_SEM_tree_low([1 3],3),'.','color','k', 'LineWidth',0.8);
% % 
% % ylabel('Proportion of draws [%]','FontName','Arial','Fontweight','bold','FontSize',9);
% % xlabel('Novelty exploration')          
% % title('Low-value bandit')
% % 
% % ylim([0 15.5])
% % xlim([-1.5 3.5])
% % xticks([0 2])
% % xticklabels({'Low','High'});
% % yticks(0:5:20)
% % 
% % export_fig([out_dir 'Fig_low_value_bin.tif'],'-nocrop','-r200')
% % 
% %% consistency
% 
% figure('Color','w');
% set(gcf,'Unit','centimeters','OuterPosition',[0 0 8 8]);
% set(gca,'FontName','Arial','FontSize',9)
% hold on
% 
% bar(mat_mean_SEM_consistency([1 3],1),mat_mean_SEM_consistency([1 3],2),'FaceColor',col, 'FaceAlpha', 1, 'BarWidth',0.8); hold on;
% errorbar(mat_mean_SEM_consistency([1 3],1),mat_mean_SEM_consistency([1 3],2),mat_mean_SEM_consistency([1 3],3),'.','color','k', 'LineWidth',0.8);
% 
% ylabel('Proportion of same choices [%]','FontName','Arial','Fontweight','bold','FontSize',9);
% xlabel('Novelty exploration')          
% title('Consistency')
% 
% ylim([34 89])
% xlim([-1.5 3.5])
% xticks([0 2])
% xticklabels({'Low','High'});
% yticks(30:10:100)
% set(gca,'YTick',30:10:100)
% 
% % 
% % export_fig([out_dir 'Fig_consistency_bin.tif'],'-nocrop','-r200')



