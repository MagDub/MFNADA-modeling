
data_fold = ('../../../data/');
    
load('./params/param_epsilon_AB_SH.mat')
load('./params/param_epsilon_AB_LH.mat')
param_epsilon_AB_mean = (param_epsilon_SH + param_epsilon_LH)/2;

load('./params/param_epsilon_ABD_SH.mat')
load('./params/param_epsilon_ABD_LH.mat')
param_epsilon_ABD_mean = (param_epsilon_SH + param_epsilon_LH)/2;

load('./params/param_epsilon_AD_SH.mat')
load('./params/param_epsilon_AD_LH.mat')
param_epsilon_AD_mean = (param_epsilon_SH + param_epsilon_LH)/2;

load('./params/param_epsilon_BD_SH.mat')
load('./params/param_epsilon_BD_LH.mat')
param_epsilon_BD_mean = (param_epsilon_SH + param_epsilon_LH)/2;

% Remove ID
param_epsilon_AB_mean(6,:) = nan;
param_epsilon_ABD_mean(6,:) = nan;
param_epsilon_AD_mean(6,:) = nan;
param_epsilon_BD_mean(6,:) = nan;
numel_n = 60;

noise_plot = (rand(4,numel_n,1)-0.5)/5;

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col.all(1,:) = [0.803921580314636 0.878431379795074 0.968627452850342]; 
col.all(2,:) = [0.39215686917305 0.474509805440903 0.635294139385223]; % data points

x_ax = 0:0.4:8;

% SH
b1= bar(x_ax(3),nanmean(param_epsilon_AB_mean),'FaceColor',col.all(1,:), 'FaceAlpha', 1, 'BarWidth',1); 
b2 = bar(x_ax(6),nanmean(param_epsilon_ABD_mean),'FaceColor',col.all(1,:), 'FaceAlpha', 1, 'BarWidth',1);
b3= bar(x_ax(9),nanmean(param_epsilon_AD_mean),'FaceColor',col.all(1,:), 'FaceAlpha', 1, 'BarWidth',1); 
b4 = bar(x_ax(12),nanmean(param_epsilon_BD_mean),'FaceColor',col.all(1,:), 'FaceAlpha', 1, 'BarWidth',1);

% data points
plot(x_ax(3)*ones(1,size(param_epsilon_AB_mean,1))+noise_plot(1,:)', param_epsilon_AB_mean','.','MarkerEdgeColor',col.all(2,:), 'MarkerSize',3);
plot(x_ax(6)*ones(1,size(param_epsilon_ABD_mean,1))+noise_plot(2,:)', param_epsilon_ABD_mean','.','MarkerEdgeColor',col.all(2,:), 'MarkerSize',3); 
plot(x_ax(9)*ones(1,size(param_epsilon_AD_mean,1))+noise_plot(3,:)', param_epsilon_AD_mean','.','MarkerEdgeColor',col.all(2,:), 'MarkerSize',3);
plot(x_ax(12)*ones(1,size(param_epsilon_BD_mean,1))+noise_plot(4,:)', param_epsilon_BD_mean','.','MarkerEdgeColor',col.all(2,:), 'MarkerSize',3); 

h = errorbar(x_ax([3 6 9 12]),...
    [nanmean(param_epsilon_AB_mean) nanmean(param_epsilon_ABD_mean) nanmean(param_epsilon_AD_mean) nanmean(param_epsilon_BD_mean)], ...
    [nanstd(param_epsilon_AB_mean)./sqrt(numel_n-1) nanstd(param_epsilon_ABD_mean)./sqrt(numel_n-1) nanstd(param_epsilon_AD_mean)./sqrt(numel_n-1) nanstd(param_epsilon_BD_mean)./sqrt(numel_n-1)],'.','color','k');

set(h,'Marker','none')

xlim([0 2.8*2])   
set(gca,'XTick',[x_ax(3) x_ax(6) x_ax(9) x_ax(12)])

labels = {'No low-value', 'No novel', 'No standard', 'No certain-standard'};
xtickangle(45)

a = gca;
a.XTickLabel = labels;

ylabel('Best-fit parameter value','FontName','Arial','Fontweight','bold','FontSize',12);
set(gca,'YTick',0:0.1:1)
ylim([0 0.51])

% Export
addpath('../../figures/export_fig')
export_fig(['./fig/Fig_param_epsilon_per_cond.tif'],'-nocrop','-r200')


