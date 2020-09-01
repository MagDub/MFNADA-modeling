
% heuristic model 
tau_mat = 1;
Q0_mat = 5;

part_num = 200;

sim_folder = strcat('../../data/simulation_data/sim_prob_mod5/changing_gamma/tau_',num2str(tau_mat),'_Q0_',num2str(Q0_mat),'/');
                                               
load(strcat(sim_folder,'mat_mean_SEM_tree_low.mat'));  

dec_num_1 = mat_mean_SEM_tree_low(3,1);
dec_num_2 = mat_mean_SEM_tree_low(7,1);

gamma_1 = dec_num_1;
gamma_2 = dec_num_2;

ind_1 = find(mat_mean_SEM_tree_low(:,1)==gamma_1);
ind_2 = find(mat_mean_SEM_tree_low(:,1)==gamma_2);

col = [0.803921580314636 0.878431379795074 0.968627452850342];

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 8 8]);
set(gca,'FontName','Arial','FontSize',9)
hold on

bar([0,2],mat_mean_SEM_tree_low([ind_1 ind_2],2),'FaceColor',col, 'FaceAlpha', 1, 'BarWidth',0.8); hold on;
errorbar([0,2],mat_mean_SEM_tree_low([ind_1 ind_2],2),mat_mean_SEM_tree_low([ind_1 ind_2],3)*sqrt(part_num),'.','color','k', 'LineWidth',0.8);

ylabel('Proportion of draws [%]','FontName','Arial','Fontweight','bold','FontSize',9);
title('Low-value bandit')

ylim([0 70.5])
xlim([-1.5 3.5])
xticks([0 2])
xticklabels({'Low','High'});
yticks(0:15:75)


addpath('../../export_fig/')
export_fig('Fig_UCB_low_gamma.tif','-nocrop','-r200')





