
Q0_mat = 5;

part_num = 200;

% SH
tau_mat = 0.2;

sim_folder_SH = strcat('../../../data/simulation_data/sim_prob_mod5/changing_gamma/tau_',num2str(tau_mat),'_Q0_',num2str(Q0_mat),'/');
tmp_SH = load(strcat(sim_folder_SH,'mat_mean_SEM_tree_high.mat'));  

gamma_1_SH = tmp_SH.mat_mean_SEM_tree_high(2,1);
gamma_2_SH = tmp_SH.mat_mean_SEM_tree_high(5,1);

ind_1_SH = find(tmp_SH.mat_mean_SEM_tree_high(:,1)==gamma_1_SH);
ind_2_SH = find(tmp_SH.mat_mean_SEM_tree_high(:,1)==gamma_2_SH);

% LH
tau_mat = 0.7;

sim_folder_LH = strcat('../../../data/simulation_data/sim_prob_mod5/changing_gamma/tau_',num2str(tau_mat),'_Q0_',num2str(Q0_mat),'/');
tmp_LH = load(strcat(sim_folder_LH,'mat_mean_SEM_tree_high.mat'));  

gamma_1_LH = tmp_LH.mat_mean_SEM_tree_high(4,1);
gamma_2_LH = tmp_LH.mat_mean_SEM_tree_high(8,1);

ind_1_LH = find(tmp_LH.mat_mean_SEM_tree_high(:,1)==gamma_1_LH);
ind_2_LH = find(tmp_LH.mat_mean_SEM_tree_high(:,1)==gamma_2_LH);

% Figure

col = [0.803921580314636 0.878431379795074 0.968627452850342];

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 8 8]);
set(gca,'FontName','Arial','FontSize',9)
hold on

h(1) = bar([0],tmp_SH.mat_mean_SEM_tree_high([ind_1_SH],2),'FaceColor',col, 'FaceAlpha', 0.2, 'BarWidth',0.9); hold on;
errorbar([0],tmp_SH.mat_mean_SEM_tree_high([ind_1_SH],2),tmp_SH.mat_mean_SEM_tree_high([ind_1_SH],3)*sqrt(part_num),'.','color','k', 'LineWidth',0.8); hold on;

h(2) = bar([1],tmp_LH.mat_mean_SEM_tree_high([ind_1_LH],2),'FaceColor',col, 'FaceAlpha', 1, 'BarWidth',0.9); hold on;
errorbar([1],tmp_LH.mat_mean_SEM_tree_high([ind_1_LH],2),tmp_LH.mat_mean_SEM_tree_high([ind_1_LH],3)*sqrt(part_num),'.','color','k', 'LineWidth',0.8); hold on;

h(3) = bar([3],tmp_SH.mat_mean_SEM_tree_high([ind_2_SH],2),'FaceColor',col, 'FaceAlpha', 0.2, 'BarWidth',0.9); hold on;
errorbar([3],tmp_SH.mat_mean_SEM_tree_high([ind_2_SH],2),tmp_SH.mat_mean_SEM_tree_high([ind_2_SH],3)*sqrt(part_num),'.','color','k', 'LineWidth',0.8); hold on;

h(4) = bar([4],tmp_LH.mat_mean_SEM_tree_high([ind_2_LH],2),'FaceColor',col, 'FaceAlpha', 1, 'BarWidth',0.9); hold on;
errorbar([4],tmp_LH.mat_mean_SEM_tree_high([ind_2_LH],2),tmp_LH.mat_mean_SEM_tree_high([ind_2_LH],3)*sqrt(part_num),'.','color','k', 'LineWidth',0.8); hold on;

ylabel('Proportion of draws [%]','FontName','Arial','Fontweight','bold','FontSize',9);
title('High-value bandit')

% leg1 = legend(h(1:2), 'Short horizon', 'Long horizon');
% set(leg1,'Position',[0.466960352422908 0.652228453364818 0.436123348017621 0.211776859504132]);
% legend boxoff;

ylim([0 85])
xlim([-1 5])
xticks([0.5 3.5])
xticklabels({'Low exploration','High exploration'});
yticks(0:20:100)

addpath('../../../export_fig/')
export_fig('Fig_mod5_high_gamma.tif','-nocrop','-r200')





