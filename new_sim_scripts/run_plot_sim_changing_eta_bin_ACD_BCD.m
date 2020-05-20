
clear 

sgm0_mat = 1.312;
xi_mat = 0.1;
Q0_mat = 3.200;

part_num = 200;

eta_range = [0,2];

sim_folder_A = strcat('D:\writing\MF\data_for_figs\sim_prob_mod12_changing_eta_ACD\sgm0_',num2str(sgm0_mat),'_Q0_',num2str(Q0_mat),'_xi_',num2str(xi_mat),'\');
sim_folder_B = strcat('D:\writing\MF\data_for_figs\sim_prob_mod12_changing_eta_BCD\sgm0_',num2str(sgm0_mat),'_Q0_',num2str(Q0_mat),'_xi_',num2str(xi_mat),'\');

mean_consistency = [];
SEM_consistency = [];

for eta_iter = 1:size(eta_range,2)

    Q0 = Q0_mat;

    sgm0 = [sgm0_mat, sgm0_mat];
    
    eta_SH = eta_range(eta_iter);
    eta_LH = 0.5+eta_range(eta_iter);

    eta = [eta_SH eta_LH];

    xi = [xi_mat, xi_mat];
    
    for ID = 1:part_num
        
        eta_file = strcat('etaSH_',num2str(eta_range(eta_iter)),'_etaLH_',num2str(eta_range(eta_iter)+0.5));

        sim_data_dir_A = strcat(sim_folder_A,eta_file,'\participant_',int2str(ID),'\');
        sim_data_dir_B = strcat(sim_folder_A,eta_file,'\participant_',int2str(ID),'\');

        tmp_const_A = load(strcat(sim_data_dir_A,'sim_consistency_freq.mat'));
        tmp_const_B = load(strcat(sim_data_dir_B,'sim_consistency_freq.mat'));

        tmp_trees_A = load(strcat(sim_data_dir_A,'sim_prob_choosing_exploit_trees_new_data.mat'));
        tmp_trees_B = load(strcat(sim_data_dir_B,'sim_prob_choosing_exploit_trees_new_data.mat'));

        mat_consistency(ID,:) = [(tmp_const_A.sim_consistency_freq(2)+tmp_const_B.sim_consistency_freq(2))/2 (tmp_const_A.sim_consistency_freq(1)+tmp_const_B.sim_consistency_freq(1))/2] * 100; %SH_consistency, LH_consistency    

        mat_trees(ID,:) = (tmp_trees_A.sim_prob_choosing_exploit_trees_new_data+tmp_trees_B.sim_prob_choosing_exploit_trees_new_data) * 100; 
    end
    
    mean_SEM_consistency(eta_iter,:) = [eta_SH eta_LH mean(mat_consistency,1) std(mat_consistency,1)];
    
    mean_SEM_tree_high(eta_iter,:) = [eta_SH eta_LH mean(mat_trees(:,1)) mean(mat_trees(:,5)) std(mat_trees(:,1)) std(mat_trees(:,5))];
    mean_SEM_tree_medium(eta_iter,:) = [eta_SH eta_LH mean(mat_trees(:,2)) mean(mat_trees(:,6)) std(mat_trees(:,2)) std(mat_trees(:,6))];
    mean_SEM_tree_novel(eta_iter,:) = [eta_SH eta_LH mean(mat_trees(:,3)) mean(mat_trees(:,7)) std(mat_trees(:,3)) std(mat_trees(:,7))];
    mean_SEM_tree_low(eta_iter,:) = [eta_SH eta_LH mean(mat_trees(:,4)) mean(mat_trees(:,8)) std(mat_trees(:,4)) std(mat_trees(:,8))];
    
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
                        
                        
col=[];

col(1,:) = [0.39215686917305 0.474509805440903 0.635294139385223];

out_dir = 'D:\writing\MF\figs\sim_changing_eta\ACD_BCD\';
addpath('D:\writing\export_fig')

%% picked A

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

bar(mat_mean_SEM_tree_high([1 2],1),mat_mean_SEM_tree_high([1 2],2),'FaceColor',col, 'FaceAlpha', 0.4, 'BarWidth',0.8); hold on;
errorbar(mat_mean_SEM_tree_high([1 2],1),mat_mean_SEM_tree_high([1 2],2),mat_mean_SEM_tree_high([1 2],3),'.','color','k', 'LineWidth',0.8);

ylabel('Proportion of draws') 
xlabel('Novelty bonus')          
title('High-value bandit')

ylim([0 78])
xlim([-1.5 3.5])
xticks([0 2])
yticks(0:15:100)

export_fig([out_dir 'Fig_high_value_bin.tif'],'-nocrop','-r200')


%% picked B

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

bar(mat_mean_SEM_tree_medium([1 2],1),mat_mean_SEM_tree_medium([1 2],2),'FaceColor',col, 'FaceAlpha', 0.4, 'BarWidth',0.8); hold on;
errorbar(mat_mean_SEM_tree_medium([1 2],1),mat_mean_SEM_tree_medium([1 2],2),mat_mean_SEM_tree_medium([1 2],3),'.','color','k', 'LineWidth',0.8);

ylabel('Proportion of draws') 
xlabel('Novelty bonus')          
title('Medium-value bandit')

ylim([0 16.5])
xlim([-1.5 3.5])
xticks([0 2])
yticks(0:4:100)

export_fig([out_dir 'Fig_medium_value_bin.tif'],'-nocrop','-r200')

%% picked C

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

bar(mat_mean_SEM_tree_novel([1 2],1),mat_mean_SEM_tree_novel([1 2],2),'FaceColor',col, 'FaceAlpha', 0.4, 'BarWidth',0.8); hold on;
errorbar(mat_mean_SEM_tree_novel([1 2],1),mat_mean_SEM_tree_novel([1 2],2),mat_mean_SEM_tree_novel([1 2],3),'.','color','k', 'LineWidth',0.8);

ylabel('Proportion of draws') 
xlabel('Novelty bonus')          
title('Novel bandit')

ylim([0 70.5])
xlim([-1.5 3.5])
xticks([0 2])
yticks(0:15:75)

export_fig([out_dir 'Fig_novel_bin.tif'],'-nocrop','-r200')

%% picked D

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

bar(mat_mean_SEM_tree_low([1 2],1),mat_mean_SEM_tree_low([1 2],2),'FaceColor',col, 'FaceAlpha', 0.4, 'BarWidth',0.8); hold on;
errorbar(mat_mean_SEM_tree_low([1 2],1),mat_mean_SEM_tree_low([1 2],2),mat_mean_SEM_tree_low([1 2],3),'.','color','k', 'LineWidth',0.8);

ylabel('Proportion of draws') 
xlabel('Novelty bonus')          
title('Low-value bandit')

ylim([0 15.5])
xlim([-1.5 3.5])
xticks([0 2])
yticks(0:5:20)

export_fig([out_dir 'Fig_low_value_bin.tif'],'-nocrop','-r200')

%% consistency

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

bar(mat_mean_SEM_consistency([1 2],1),mat_mean_SEM_consistency([1 2],2),'FaceColor',col, 'FaceAlpha', 0.4, 'BarWidth',0.8); hold on;
errorbar(mat_mean_SEM_consistency([1 2],1),mat_mean_SEM_consistency([1 2],2),mat_mean_SEM_consistency([1 2],3),'.','color','k', 'LineWidth',0.8);

ylabel('Proportion of same choices') 
xlabel('Novelty bonus')          
title('Consistency')

ylim([34 89])
xlim([-1.5 3.5])
xticks([0 2])
yticks(30:10:100)
set(gca,'YTick',30:10:100)


export_fig([out_dir 'Fig_consistency_bin.tif'],'-nocrop','-r200')





