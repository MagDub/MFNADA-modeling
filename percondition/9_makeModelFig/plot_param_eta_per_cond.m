
function [] = plot_param_eta_per_cond(cond)

    data_folder = strcat('../../../data/modelfit/thompson_percond/thompson_',cond,'/');
    data_fold = ('../../../data/');
        
    % Data
    load(strcat(data_folder, 'concatenated_',cond,'/model_parameters.mat'));
    load(strcat(data_folder, 'concatenated_',cond,'/model_parameters_desc.mat'));
    ind_SH = find(contains(model_parameters_desc,'eta_short'));
    ind_LH = find(contains(model_parameters_desc,'eta_long'));
    param_SH = model_parameters(:,ind_SH);
    param_LH = model_parameters(:,ind_LH);

    % Drugs
    load(strcat(data_fold, 'data_for_figs/drug_code.mat')) %0: placebo, 1:amisulpride, 2:propranolol
    idx_plc = find(drug_code(:,2)==0);
    idx_ami = find(drug_code(:,2)==1);
    idx_prop = find(drug_code(:,2)==2);

    % Remove ID
    param_SH(6,:) = nan;
    param_LH(6,:) = nan;
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
    col_sim = [0.39215686917305 0.474509805440903 0.635294139385223];  
    col_sim_inside = [0.729411780834198 0.831372559070587 0.95686274766922];

    x_ax = 0.5:0.5:4;

    % Short horizon
    b1S= bar(x_ax(1),nanmean(param_SH(idx_prop)),'FaceColor',col.prop(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5); 
    b2S = bar(x_ax(4),nanmean(param_SH(idx_plc)),'FaceColor',col.plac(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);
    b3S = bar(x_ax(7),nanmean(param_SH(idx_ami)),'FaceColor',col.ami(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);

    % Short horizon data points
    plot(x_ax(1)*ones(1,size(param_SH(idx_prop),1)), param_SH(idx_prop)','.','MarkerEdgeColor',col.prop(2,:), 'MarkerSize',2); 
    plot(x_ax(4)*ones(1,size(param_SH(idx_plc),1)), param_SH(idx_plc)','.','MarkerEdgeColor',col.plac(2,:), 'MarkerSize',2); 
    plot(x_ax(7)*ones(1,size(param_SH(idx_ami),1)), param_SH(idx_ami)','.','MarkerEdgeColor',col.ami(2,:), 'MarkerSize',2); 

    % Long horizon
    b1L = bar(x_ax(2),nanmean(param_LH(idx_prop)),'FaceColor',col.prop(1,:), 'FaceAlpha', 1, 'BarWidth',.5);
    b2L = bar(x_ax(5),nanmean(param_LH(idx_plc)),'FaceColor',col.plac(1,:),'FaceAlpha', 1, 'BarWidth',.5);
    b3L = bar(x_ax(8),nanmean(param_LH(idx_ami)),'FaceColor',col.ami(1,:), 'FaceAlpha', 1, 'BarWidth',.5);

    % Long horizon data points
    plot(x_ax(2)*ones(1,size(param_LH(idx_prop),1)), param_LH(idx_prop)','.','MarkerEdgeColor',col.prop(2,:), 'MarkerSize',2); 
    plot(x_ax(5)*ones(1,size(param_LH(idx_plc),1)), param_LH(idx_plc)','.','MarkerEdgeColor',col.plac(2,:), 'MarkerSize',2); 
    plot(x_ax(8)*ones(1,size(param_LH(idx_ami),1)), param_LH(idx_ami)','.','MarkerEdgeColor',col.ami(2,:), 'MarkerSize',2); 

    % Line between data points
    for n = 1:size(idx_prop,1)
        lin1 = plot(x_ax(1:2),[param_SH(idx_prop(n)) param_LH(idx_prop(n))]); hold on;
        lin1.Color = [col.prop(2,:) 0.3]; 
    end

    for n = 1:size(idx_plc,1)
        lin2 = plot(x_ax(4:5),[param_SH(idx_plc(n)) param_LH(idx_plc(n))]); hold on;
        lin2.Color = [col.plac(2,:) 0.3]; 
    end

    for n = 1:size(idx_ami,1)
        lin3 = plot(x_ax(7:8),[param_SH(idx_ami(n)) param_LH(idx_ami(n))]); hold on;
        lin3.Color = [col.ami(2,:) 0.3]; 
    end

    h = errorbar(x_ax([1 2 4 5 7 8]),...
        [nanmean(param_SH(idx_prop)) nanmean(param_LH(idx_prop)) ...
        nanmean(param_SH(idx_plc)) nanmean(param_LH(idx_plc)) ...
        nanmean(param_SH(idx_ami)) nanmean(param_LH(idx_ami))], ...
        [nanstd(param_SH(idx_prop))./sqrt(numel(idx_prop)) nanstd(param_LH(idx_prop))./sqrt(numel(idx_prop))...
        nanstd(param_SH(idx_plc))./sqrt(numel(idx_plc)) nanstd(param_LH(idx_plc))./sqrt(numel(idx_plc))...
        nanstd(param_SH(idx_ami))./sqrt(numel_idx_ami) nanstd(param_LH(idx_ami))./sqrt(numel_idx_ami)],'.','color','k');
    set(h,'Marker','none')

    xlim([0 4.5])   
    set(gca,'XTick',[0.75 2.25 3.75])
    set(gca,'XTickLabel',{'Noradrenaline','Placebo', 'Dopamine'})

    max(max(param_SH,param_LH))
    ylabel('Best-fit parameter value','FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',0:1:10)
    ylim([0 5.2])

    % Export
    addpath('../../../export_fig')
    export_fig(['./fig/Fig_param_eta_',cond,'.tif'],'-nocrop','-r200')
    
end