
% heuristic model 
eta_mat = 0;
Q0_mat = 5;

part_num = 200;

sim_folder = strcat('../../data/simulation_data/sim_prob_mod16/changing_xi/Q0_',num2str(Q0_mat),'_eta_',num2str(eta_mat),'/');

load(strcat(sim_folder,'mat_mean_SEM_consistency.mat'));  

xi_1 = mat_mean_SEM_consistency(2,1);
xi_2 = mat_mean_SEM_consistency(4,1);

ind_1 = find(mat_mean_SEM_consistency(:,1)==xi_1);
ind_2 = find(mat_mean_SEM_consistency(:,1)==xi_2);

% picked high

col = [0.803921580314636 0.878431379795074 0.968627452850342];

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 8 8]);
set(gca,'FontName','Arial','FontSize',9)
hold on

bar([0,2],mat_mean_SEM_consistency([ind_1 ind_2],2),'FaceColor',col, 'FaceAlpha', 1, 'BarWidth',0.8); hold on;
errorbar([0,2],mat_mean_SEM_consistency([ind_1 ind_2],2),mat_mean_SEM_consistency([ind_1 ind_2],3)*sqrt(part_num),'.','color','k', 'LineWidth',0.8);

ylabel('Proportion of same choices [%]','FontName','Arial','Fontweight','bold','FontSize',9);
title('Consistency')

ylim([35 105])
xlim([-1.5 3.5])
xticks([0 2])
xticklabels({'Low','High'});
yticks(0:20:100)

addpath('../../export_fig/')
export_fig('Fig_argmax_consist_xi.tif','-nocrop','-r200')





