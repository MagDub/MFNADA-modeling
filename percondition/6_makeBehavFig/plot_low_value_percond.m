
data_fold = ('../../../data/');

load('./frequencies/pickedlow_AB_SH.mat')
load('./frequencies/pickedlow_AB_LH.mat')
pickedlow_AB_mean = (pickedlow_AB_SH + pickedlow_AB_LH)/2;

load('./frequencies/pickedlow_ABD_SH.mat')
load('./frequencies/pickedlow_ABD_LH.mat')
pickedlow_ABD_mean = (pickedlow_ABD_SH + pickedlow_ABD_LH)/2;

load('./frequencies/pickedlow_AD_SH.mat')
load('./frequencies/pickedlow_AD_LH.mat')
pickedlow_AD_mean = (pickedlow_AD_SH + pickedlow_AD_LH)/2;

load('./frequencies/pickedlow_BD_SH.mat')
load('./frequencies/pickedlow_BD_LH.mat')
pickedlow_BD_mean = (pickedlow_BD_SH + pickedlow_BD_LH)/2;

% Remove ID
pickedlow_AB_mean(6,:) = nan;
pickedlow_ABD_mean(6,:) = nan;
pickedlow_AD_mean(6,:) = nan;
pickedlow_BD_mean(6,:) = nan;
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
b1= bar(x_ax(3),nanmean(pickedlow_AB_mean),'FaceColor',col.all(1,:), 'FaceAlpha', 1, 'BarWidth',1); 
b2 = bar(x_ax(6),nanmean(pickedlow_ABD_mean),'FaceColor',col.all(1,:), 'FaceAlpha', 1, 'BarWidth',1);
b3= bar(x_ax(9),nanmean(pickedlow_AD_mean),'FaceColor',col.all(1,:), 'FaceAlpha', 1, 'BarWidth',1); 
b4 = bar(x_ax(12),nanmean(pickedlow_BD_mean),'FaceColor',col.all(1,:), 'FaceAlpha', 1, 'BarWidth',1);

% data points
plot(x_ax(3)*ones(1,numel_n)+noise_plot(1,:)', pickedlow_AB_mean','.','MarkerEdgeColor',col.all(2,:), 'MarkerSize',3);
plot(x_ax(6)*ones(1,numel_n)+noise_plot(2,:)', pickedlow_ABD_mean','.','MarkerEdgeColor',col.all(2,:), 'MarkerSize',3); 
plot(x_ax(9)*ones(1,numel_n)+noise_plot(3,:)', pickedlow_AD_mean','.','MarkerEdgeColor',col.all(2,:), 'MarkerSize',3);
plot(x_ax(12)*ones(1,numel_n)+noise_plot(4,:)', pickedlow_BD_mean','.','MarkerEdgeColor',col.all(2,:), 'MarkerSize',3); 

h = errorbar(x_ax([3 6 9 12]),...
    [nanmean(pickedlow_AB_mean) nanmean(pickedlow_ABD_mean) nanmean(pickedlow_AD_mean) nanmean(pickedlow_BD_mean)], ...
    [nanstd(pickedlow_AB_mean)./sqrt(numel_n-1) nanstd(pickedlow_ABD_mean)./sqrt(numel_n-1) nanstd(pickedlow_AD_mean)./sqrt(numel_n-1) nanstd(pickedlow_BD_mean)./sqrt(numel_n-1)],'.','color','k');

set(h,'Marker','none')

xlim([0 2.8*2])   
set(gca,'XTick',[x_ax(3) x_ax(6) x_ax(9) x_ax(12)])

labels = {'No low-value', 'No novel', 'No standard', 'No certain-standard'};
xtickangle(45)

a = gca;
a.XTickLabel = labels;

ylabel('Proportion of draws [%]','FontName','Arial','Fontweight','bold','FontSize',12);
set(gca,'YTick',0:2:100)
ylim([0 6.2])

% Export
addpath('../../figures/export_fig')
export_fig(['./fig/Fig_behaviour_low_per_cond.tif'],'-nocrop','-r200')


