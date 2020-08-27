
close all;

load('../../data/data_for_figs/model_selection_mat_q0.mat')

model = size(mod.name,2);

participant_list=501:560;

%% Models

mod.legend{1} = 'thompson';
mod.legend{2} = 'thompson + \epsilon';
mod.legend{3} = 'thompson + \eta';
mod.legend{4} = 'thompson + \epsilon + \eta';

mod.legend{5} = 'UCB';
mod.legend{6} = 'UCB + \epsilon';
mod.legend{7} = 'UCB + \eta';
mod.legend{8} = 'UCB + \epsilon + \eta';

mod.legend{9} = 'hybrid';
mod.legend{10} = 'hybrid + \epsilon';
mod.legend{11} = 'hybrid + \eta';
mod.legend{12} = 'hybrid + \epsilon + \eta';

%%%%%%%%%%
% ARGMAX %
%%%%%%%%%%
% 13
model = model + 1;
mod.file_name{model} = '../../data/crossval/mod_13/results/aver_prob_';
mod.model_type{model} = 'heuristics';
mod.name{model} = 'heuristics';
mod.legend{model} = 'argmax'; 
%%%%%%
% 14
model = model + 1;
mod.file_name{model} = '../../data/crossval/mod_14/results/aver_prob_';
mod.model_type{model} = 'heuristics';
mod.name{model} = 'heuristics';
mod.legend{model} = 'argmax + \epsilon';
%%%%%
% 15
model = model + 1;
mod.file_name{model} = '../../data/crossval/mod_15/results/aver_prob_';
mod.model_type{model} = 'heuristics';
mod.name{model} = 'heuristics';
mod.legend{model} = 'argmax + \eta'; 
%%%%%
% 16
model = model + 1;
mod.file_name{model} = '../../data/crossval/mod_16/results/aver_prob_';
mod.model_type{model} = 'heuristics';
mod.name{model} = 'heuristics';
mod.legend{model} = 'argmax + \eta + \epsilon'; 


%% Plotting  
average_prob_mat = [];
mean_all=nan(1,16);
mean_all_pp=nan(length(participant_list),16);
stderror_all=nan(1,16);
number_par_all=zeros(1,16);

for model = 13:size(mod.file_name,2)
    
    dirData = dir(strcat(mod.file_name{model},'*.mat'));
    
    n_part_for_model = size(dirData,1);
    
    tmp_part = [];
    
    for i = 1:n_part_for_model
        tmp_part(end + 1) = str2num(dirData(i).name(end-6:end-4));
    end
    
    tmp_part = sort(tmp_part);
            
    mod.participant_list{model} = tmp_part;
    mod.number_par{model} = size(tmp_part,2);
    
    average_prob_mat = nan(size(participant_list,2),10);
    
    for ID_ind = 1:size(participant_list,2)%n_part_for_model
        
        average_prob = nan(1,10);
        
        ID = participant_list(ID_ind);
        f_name = strcat(mod.file_name{model}, mod.model_type{model},'_',int2str(ID),'.mat');
        
        if exist(f_name)==2
            load(f_name);
        end
        
        average_prob_mat(ID_ind,:) = average_prob;
    end
        
    disp(strcat('participants for model', 32, int2str(model), 32,mod.legend{model}, 32, '=', 32, int2str(mod.number_par{model}),32,'selected =',32,int2str(size(average_prob_mat,1))));
        
    mean_av_prob = nanmean(average_prob_mat,2); % average over k iterations
    
    mod.mean_pp{model} = mean_av_prob;

    
    clear mean_av_prob
    
end

for model = 1:16
    
    mod.legend{model} = mod.legend{model};
    
    for ID = 1:size(participant_list,2)
        
        tmp_ = mod.mean_pp{model};
        
        mean_all_pp(ID, model) = tmp_(ID);
        
    end
end

% remove 506
mean_all_pp(6,:) = nan(1,16);

for model = 1:16
    
    mod.mean_all{model} = nanmean(mean_all_pp(:,model));
    mod.stderror_all{model} = nanstd(mean_all_pp(:,model)) / sqrt(mod.number_par{model});
    
    mean_all(model) = mod.mean_all{model};
    stderror_all(model) = mod.stderror_all{model};
    
    number_par_all(model) = mod.number_par{model};
    
end


% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.9251690160519562 0.839215695858002 0.839215695858002];
col_(2,:) = [0.5816313750267029 0.3882353007793163 0.3882353007793163];
col_(3,:) = [0.6716509823322296 0.16235291616322708 0.16235291616322708];


x = [1:4 6:9 11:14 16:19];

I = 1:1:size(mean_all,2); 

bar(x,mean_all(I)*100,'FaceColor',col_(1,:), 'FaceAlpha', 1); hold on;

er = errorbar(x,mean_all(I)*100,stderror_all(I)*100,stderror_all(I)*100);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
ylabel('Held-out data likelihood [%]')
yrange = [55 57]; 
ylim(yrange)
xticks(x)
xticklabels(mod.legend(I));
xtickangle(45)
set(gca,'YTick',0:2:100)

hold off


save('model_selection_heuristics.mat', 'mod')
save('mean_all_pp_heuristics.mat', 'mean_all_pp')

save('../../data/data_for_figs/model_selection_heuristics.mat', 'mod')
save('../../data/data_for_figs/mean_all_pp_heuristics.mat', 'mean_all_pp')

% % Export
% addpath('../../export_fig')
% export_fig(['./Fig_model_comparison.png'],'-nocrop','-r160')