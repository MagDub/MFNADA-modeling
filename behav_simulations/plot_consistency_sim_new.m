
%% Data

load('D:\writing\MF\data_for_figs\consistency_freq.mat')
consist_SH_nosim = consistency_freq(:,2);
consist_LH_nosim = consistency_freq(:,1);

load('D:\writing\MF\data_for_figs\consistency_freq_simulation_1Norm.mat') % from run_make_consistency_from_sim
consist_SH = consistency_freq_simulation_1Norm(:,2)*100;
consist_LH = consistency_freq_simulation_1Norm(:,1)*100;

%% Drugs
load('data_for_figs\drug_code.mat') %0: placebo, 1:amisulpride, 2:propranolol
idx_plc = find(drug_code(:,2)==0);
idx_ami = find(drug_code(:,2)==1);
idx_prop = find(drug_code(:,2)==2);

% Remove 506
consist_SH(6,1) = nan;
consist_LH(6,1) = nan;
consist_SH_nosim(6,1) = nan;
consist_LH_nosim(6,1) = nan;
numel_idx_ami = numel(idx_ami-1);

%% Figure
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
%b1S= bar(x_ax(1),nanmean(consist_SH(idx_prop)),'FaceColor',col.prop(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5, 'LineStyle', '--'); 
b1S= bar(x_ax(1),nanmean(consist_SH(idx_prop)),'FaceColor',col_sim, 'FaceAlpha', 0.05, 'BarWidth',.5); 
b2S = bar(x_ax(4),nanmean(consist_SH(idx_plc)),'FaceColor',col_sim, 'FaceAlpha', 0.05, 'BarWidth',.5);
b3S = bar(x_ax(7),nanmean(consist_SH(idx_ami)),'FaceColor',col_sim, 'FaceAlpha', 0.05, 'BarWidth',.5);

% Short horizon data points
plot(x_ax(1)*ones(1,size(consist_SH(idx_prop),1)), consist_SH(idx_prop)','.','MarkerEdgeColor',col_sim_inside, 'MarkerSize',2); 
plot(x_ax(4)*ones(1,size(consist_SH(idx_plc),1)), consist_SH(idx_plc)','.','MarkerEdgeColor',col_sim_inside, 'MarkerSize',2); 
plot(x_ax(7)*ones(1,size(consist_SH(idx_ami),1)), consist_SH(idx_ami)','.','MarkerEdgeColor',col_sim_inside, 'MarkerSize',2); 

% Long horizon
% b1L = bar(x_ax(2),nanmean(consist_LH(idx_prop)),'FaceColor',col.prop(1,:), 'FaceAlpha', 1, 'BarWidth',.5, 'LineStyle', '--');
b1L = bar(x_ax(2),nanmean(consist_LH(idx_prop)),'FaceColor',col_sim, 'FaceAlpha', 0.35, 'BarWidth',.5);
b2L = bar(x_ax(5),nanmean(consist_LH(idx_plc)),'FaceColor',col_sim,'FaceAlpha', 0.35, 'BarWidth',.5);
b3L = bar(x_ax(8),nanmean(consist_LH(idx_ami)),'FaceColor',col_sim, 'FaceAlpha', 0.35, 'BarWidth',.5);

% Long horizon data points
plot(x_ax(2)*ones(1,size(consist_LH(idx_prop),1)), consist_LH(idx_prop)','.','MarkerEdgeColor',col_sim_inside, 'MarkerSize',2); 
plot(x_ax(5)*ones(1,size(consist_LH(idx_plc),1)), consist_LH(idx_plc)','.','MarkerEdgeColor',col_sim_inside, 'MarkerSize',2); 
plot(x_ax(8)*ones(1,size(consist_LH(idx_ami),1)), consist_LH(idx_ami)','.','MarkerEdgeColor',col_sim_inside, 'MarkerSize',2); 

% Line between data points
for n = 1:size(idx_prop,1)
    lin1 = plot(x_ax(1:2),[consist_SH(idx_prop(n)) consist_LH(idx_prop(n))]); hold on;
    lin1.Color = [col_sim 0.3]; % transparency
end

for n = 1:size(idx_plc,1)
    lin2 = plot(x_ax(4:5),[consist_SH(idx_plc(n)) consist_LH(idx_plc(n))]); hold on;
    lin2.Color = [col_sim 0.3]; % transparency
end

for n = 1:size(idx_ami,1)
    lin3 = plot(x_ax(7:8),[consist_SH(idx_ami(n)) consist_LH(idx_ami(n))]); hold on;
    lin3.Color = [col_sim 0.3]; % transparency
end

h = errorbar(x_ax([1 2 4 5 7 8]),...
    [nanmean(consist_SH(idx_prop)) nanmean(consist_LH(idx_prop)) ...
    nanmean(consist_SH(idx_plc)) nanmean(consist_LH(idx_plc)) ...
    nanmean(consist_SH(idx_ami)) nanmean(consist_LH(idx_ami))], ...
    [nanstd(consist_SH(idx_prop))./sqrt(numel(idx_prop)) nanstd(consist_LH(idx_prop))./sqrt(numel(idx_prop))...
    nanstd(consist_SH(idx_plc))./sqrt(numel(idx_plc)) nanstd(consist_LH(idx_plc))./sqrt(numel(idx_plc))...
    nanstd(consist_SH(idx_ami))./sqrt(numel_idx_ami) nanstd(consist_LH(idx_ami))./sqrt(numel_idx_ami)],'.','color','k');
set(h,'Marker','none')


% h = errorbar(x_ax([1 2])+0.25,...
%     [nanmean(consist_SH_nosim(idx_prop)) nanmean(consist_LH_nosim(idx_prop))], ...
%     [nanstd(consist_SH_nosim(idx_prop))./sqrt(numel(idx_prop)) nanstd(consist_LH_nosim(idx_prop))./sqrt(numel(idx_prop))],'.','color',col.prop(2,:), 'MarkerSize',6, 'MarkerEdgeColor',col_sim,'MarkerFaceColor',col_sim);
% set(h,'Marker','d')
% 
% h = errorbar(x_ax([4 5])+0.25,...
%     [nanmean(consist_SH_nosim(idx_plc)) nanmean(consist_LH_nosim(idx_plc))], ...
%     [nanstd(consist_SH_nosim(idx_plc))./sqrt(numel(idx_plc)) nanstd(consist_LH_nosim(idx_plc))./sqrt(numel(idx_plc))],'.','color',col.plac(2,:), 'MarkerSize',6, 'MarkerEdgeColor',col_sim,'MarkerFaceColor',col_sim);
% set(h,'Marker','d')
% 
% h = errorbar(x_ax([7 8])+0.25,...
%     [nanmean(consist_SH_nosim(idx_ami)) nanmean(consist_LH_nosim(idx_ami))], ...
%     [nanstd(consist_SH_nosim(idx_ami))./sqrt(numel_idx_ami) nanstd(consist_LH_nosim(idx_ami))./sqrt(numel_idx_ami)],'.','color',col.ami(2,:), 'MarkerSize',6, 'MarkerEdgeColor',col_sim,'MarkerFaceColor',col_sim);
% set(h,'Marker','d')
% 
% 
% h = plot(x_ax([1 2])+0.25,...
%     [nanmean(consist_SH_nosim(idx_prop)) nanmean(consist_LH_nosim(idx_prop))], ...
%     '.','color',col_sim, 'MarkerSize',6, 'MarkerEdgeColor',col.prop(2,:),'MarkerFaceColor',col.prop(1,:), 'LineWidth', 1.5);
% set(h,'Marker','d')
% 
% hm = plot(x_ax([4 5])+0.25,...
%     [nanmean(consist_SH_nosim(idx_plc)) nanmean(consist_LH_nosim(idx_plc))], ...
%     '.','color',col_sim, 'MarkerSize',6, 'MarkerEdgeColor',col.plac(2,:),'MarkerFaceColor',col.plac(1,:), 'LineWidth', 1.5);
% set(hm,'Marker','d')
% 
% h = plot(x_ax([7 8])+0.25,...
%     [nanmean(consist_SH_nosim(idx_ami)) nanmean(consist_LH_nosim(idx_ami))], ...
%     '.','color',col_sim, 'MarkerSize',6, 'MarkerEdgeColor',col.ami(2,:),'MarkerFaceColor',col.ami(1,:), 'LineWidth', 1.5);
% set(h,'Marker','d')

% 
% legend([b2S b2L],{'Short horizon', 'Long horizon'}, 'Position',[0.5003645269693 0.809932376748651 0.530386728723405 0.143988915936108]);
% legend boxoff  

% legend([b2S b2L hm],{'Short horizon', 'Long horizon', 'Data'}, 'Position',[0.585999886085322 0.787189968079064 0.339778999597328 0.175438591785598]);
% legend boxoff 

xlim([0 4.5])   
set(gca,'XTick',[0.75 2.25 3.75])
set(gca,'XTickLabel',{'Noradrenaline','Placebo', 'Dopamine'})
% labels = {strcat('Noradrenaline&',32,32,32,'blockade'),'Placebo',strcat('Dopamine&',32,'blockade')};
% labels = cellfun(@(x) strrep(x,'&','\newline'), labels,'UniformOutput',false);
% a = gca;
% a.XTickLabel = labels;

ylabel('Same choices [%]','FontName','Arial','Fontweight','bold','FontSize',12,'Interpreter','tex');
% set(gca,'YTick',0:0.05:0.25)
set(gca,'YTick',30:10:100)
ylim([40.5 95])

% title('1st picked apple')


%% Export
out_dir = 'figs\';
addpath('D:\writing\export_fig')
export_fig([out_dir 'Fig_consistency_sim_new.tif'],'-nocrop','-r200')


