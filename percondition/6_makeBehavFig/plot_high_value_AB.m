
data_fold = ('../../../data/');

% Data
load(strcat(data_fold, 'data_for_figs/chosenOption.mat'))
pickedhigh_AB_SH = (chosenOption.AB.freq(:,1))/4*100;
pickedhigh_AB_LH = (chosenOption.AB.freq(:,4))/4*100;

save('./frequencies/pickedhigh_AB_SH.mat', 'pickedhigh_AB_SH')
save('./frequencies/pickedhigh_AB_LH.mat', 'pickedhigh_AB_LH')

save('../../../data/data_for_figs/pickedhigh_AB_SH.mat', 'pickedhigh_AB_SH')
save('../../../data/data_for_figs/pickedhigh_AB_LH.mat', 'pickedhigh_AB_LH')

% Drugs
load(strcat(data_fold, 'data_for_figs/drug_code.mat')) %0: placebo, 1:amisulpride, 2:propranolol
idx_plc = find(drug_code(:,2)==0);
idx_ami = find(drug_code(:,2)==1);
idx_prop = find(drug_code(:,2)==2);

% Remove ID
pickedhigh_AB_SH(6,:) = nan;
pickedhigh_AB_LH(6,:) = nan;
numel_idx_ami = numel(idx_ami-1);

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col.plac(1,:) = [0.862745106220245 0.862745106220245 0.862745106220245];
col.prop(1,:) = [0.952941179275513 0.87058824300766 0.733333349227905]; 
col.ami(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002]; 

% data points
col.plac(2,:) = [0.380392163991928 0.380392163991928 0.380392163991928];
col.prop(2,:) = [0.784313750267029 0.588235300779343 0.388235300779343];
col.ami(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

% sim
col_sim = [0.39215686917305 0.474509805440903 0.635294139385223];  %[0 0.447058826684952 0.74117648601532] %[0.39215686917305 0.474509805440903 0.635294139385223]; 
col_sim_inside = [0.729411780834198 0.831372559070587 0.95686274766922];

x_ax = 0.5:0.5:4;

% Short horizon
%b1S= bar(x_ax(1),nanmean(pickedhigh_AB_SH(idx_prop)),'FaceColor',col.prop(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5, 'LineStyle', '--'); 
b1S= bar(x_ax(1),nanmean(pickedhigh_AB_SH(idx_prop)),'FaceColor',col.prop(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5); 
b2S = bar(x_ax(4),nanmean(pickedhigh_AB_SH(idx_plc)),'FaceColor',col.plac(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);
b3S = bar(x_ax(7),nanmean(pickedhigh_AB_SH(idx_ami)),'FaceColor',col.ami(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);

% Short horizon data points
plot(x_ax(1)*ones(1,size(pickedhigh_AB_SH(idx_prop),1)), pickedhigh_AB_SH(idx_prop)','.','MarkerEdgeColor',col.prop(2,:), 'MarkerSize',2); 
plot(x_ax(4)*ones(1,size(pickedhigh_AB_SH(idx_plc),1)), pickedhigh_AB_SH(idx_plc)','.','MarkerEdgeColor',col.plac(2,:), 'MarkerSize',2); 
plot(x_ax(7)*ones(1,size(pickedhigh_AB_SH(idx_ami),1)), pickedhigh_AB_SH(idx_ami)','.','MarkerEdgeColor',col.ami(2,:), 'MarkerSize',2); 

% Long horizon
% b1L = bar(x_ax(2),nanmean(pickedhigh_AB_LH(idx_prop)),'FaceColor',col.prop(1,:), 'FaceAlpha', 1, 'BarWidth',.5, 'LineStyle', '--');
b1L = bar(x_ax(2),nanmean(pickedhigh_AB_LH(idx_prop)),'FaceColor',col.prop(1,:), 'FaceAlpha', 1, 'BarWidth',.5);
b2L = bar(x_ax(5),nanmean(pickedhigh_AB_LH(idx_plc)),'FaceColor',col.plac(1,:),'FaceAlpha', 1, 'BarWidth',.5);
b3L = bar(x_ax(8),nanmean(pickedhigh_AB_LH(idx_ami)),'FaceColor',col.ami(1,:), 'FaceAlpha', 1, 'BarWidth',.5);

% Long horizon data points
plot(x_ax(2)*ones(1,size(pickedhigh_AB_LH(idx_prop),1)), pickedhigh_AB_LH(idx_prop)','.','MarkerEdgeColor',col.prop(2,:), 'MarkerSize',2); 
plot(x_ax(5)*ones(1,size(pickedhigh_AB_LH(idx_plc),1)), pickedhigh_AB_LH(idx_plc)','.','MarkerEdgeColor',col.plac(2,:), 'MarkerSize',2); 
plot(x_ax(8)*ones(1,size(pickedhigh_AB_LH(idx_ami),1)), pickedhigh_AB_LH(idx_ami)','.','MarkerEdgeColor',col.ami(2,:), 'MarkerSize',2); 

% Line between data points
for n = 1:size(idx_prop,1)
    lin1 = plot(x_ax(1:2),[pickedhigh_AB_SH(idx_prop(n)) pickedhigh_AB_LH(idx_prop(n))]); hold on;
    lin1.Color = [col.prop(2,:) 0.3]; % transparency
end

for n = 1:size(idx_plc,1)
    lin2 = plot(x_ax(4:5),[pickedhigh_AB_SH(idx_plc(n)) pickedhigh_AB_LH(idx_plc(n))]); hold on;
    lin2.Color = [col.plac(2,:) 0.3]; % transparency
end

for n = 1:size(idx_ami,1)
    lin3 = plot(x_ax(7:8),[pickedhigh_AB_SH(idx_ami(n)) pickedhigh_AB_LH(idx_ami(n))]); hold on;
    lin3.Color = [col.ami(2,:) 0.3]; % transparency
end

h = errorbar(x_ax([1 2 4 5 7 8]),...
    [nanmean(pickedhigh_AB_SH(idx_prop)) nanmean(pickedhigh_AB_LH(idx_prop)) ...
    nanmean(pickedhigh_AB_SH(idx_plc)) nanmean(pickedhigh_AB_LH(idx_plc)) ...
    nanmean(pickedhigh_AB_SH(idx_ami)) nanmean(pickedhigh_AB_LH(idx_ami))], ...
    [nanstd(pickedhigh_AB_SH(idx_prop))./sqrt(numel(idx_prop)) nanstd(pickedhigh_AB_LH(idx_prop))./sqrt(numel(idx_prop))...
    nanstd(pickedhigh_AB_SH(idx_plc))./sqrt(numel(idx_plc)) nanstd(pickedhigh_AB_LH(idx_plc))./sqrt(numel(idx_plc))...
    nanstd(pickedhigh_AB_SH(idx_ami))./sqrt(numel_idx_ami) nanstd(pickedhigh_AB_LH(idx_ami))./sqrt(numel_idx_ami)],'.','color','k');
set(h,'Marker','none')

xlim([0 4.5])   
set(gca,'XTick',[0.75 2.25 3.75])
set(gca,'XTickLabel',{'Noradrenaline','Placebo', 'Dopamine'})

max(max(pickedhigh_AB_SH, pickedhigh_AB_LH))

ylabel('Proportion of draws [%]','FontName','Arial','Fontweight','bold','FontSize',12);
set(gca,'YTick',0:5:100)
ylim([0 26])

% Export
addpath('../../figures/export_fig')
export_fig(['./fig/Fig_behaviour_high_AB_value.tif'],'-nocrop','-r200')


