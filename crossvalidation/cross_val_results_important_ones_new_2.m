
model = 0;


%% Initialisation 

%%%%%%%%%%%%
% Thompson %
%%%%%%%%%%%%
model = model+1;
mod.file_name{model} = 'D:\MaggiesFarm\modeling_28_02\participant_data\k10\crossval_thompson\2params_1Hor_2sgm0\results\aver_prob_';
mod.model_type{model} = 'thompson';
mod.name{model} = 'thompson2params1Hor';
mod.legend{model} = 'thompson(2sgm0,1Q01)';
%%%%%%
model = model+1;
mod.file_name{model} = 'D:\MaggiesFarm\modeling_28_02\participant_data\k10\crossval_thompson\3params_2Hor_Q01_2sgm0\results\aver_prob_';
mod.model_type{model} = 'thompson';
mod.name{model} = 'thompson3params2Hor';
mod.legend{model} = 'thompson(2sgm0,1Q01)+xi(2)'; 
%%%%%
model = model+1;
mod.file_name{model} = 'D:\MaggiesFarm\modeling_28_02\participant_data\crossval_thompson_noveltybonus_2nov\2params_2Hor_Q01_2sgm0\results\aver_prob_';
mod.model_type{model} = 'thompson';
mod.name{model} = 'thompson2params2Hor2novQ012s';
mod.legend{model} = 'thompsonnov(2sgm0,1Q01)+nov(2)';
%%%%%
model = model+1;
mod.file_name{model} = 'D:\MaggiesFarm\modeling_28_02\participant_data\crossval_thompson_noveltybonus_2nov\3params_2Hor_Q01_2sgm0\results\aver_prob_';
mod.model_type{model} = 'thompson';
mod.name{model} = 'thompson3params2Hor2novQ012s';
mod.legend{model} = 'thompsonnov(2sgm0,1Q01)+nov(2)+xi(2)';
%%%%%
model = model+1;
mod.file_name{model} = 'D:\MaggiesFarm\modeling_28_02\participant_data\crossval_thompson_noveltybonus_2nov\3params_2Hor_Q01_2sgm0_new\results\aver_prob_';
mod.model_type{model} = 'thompson';
mod.name{model} = 'thompson3params2Hor2novQ012s';
mod.legend{model} = 'thompsonnov(2sgm0,1Q01)+nov(2)+xi(2) new';

%%%%%%%
% UCB %
%%%%%%%
model = model+1;
mod.file_name{model} = 'D:\MaggiesFarm\modeling_28_02\participant_data\k10\crossval_UCB\2params_2Hor_Q01\results\aver_prob_';
mod.model_type{model} = 'UCB';
mod.name{model} = 'UCB2params2Hor';
mod.legend{model} = 'UCB(2g,2t,1Q0)';
%%%
model = model+1;
mod.file_name{model} = 'D:\MaggiesFarm\modeling_28_02\participant_data\k10\crossval_UCB\2params_2Hor_2nov_Q01\results\aver_prob_';
mod.model_type{model} = 'UCB';
mod.name{model} = 'UCB2params2Hor';
mod.legend{model} = 'UCB(2g,2t,1Q0)+nov(2)';
%%%%
model = model+1;
mod.file_name{model} = 'D:\MaggiesFarm\modeling_28_02\participant_data\k10\crossval_UCB\3params_2Hor_Q01\results\aver_prob_';
mod.model_type{model} = 'UCB';
mod.name{model} = 'UCB3params2Hor';
mod.legend{model} = 'UCB(2g,2t,1Q0)+xi(2)';
%%%%
model = model+1;
mod.file_name{model} = 'D:\MaggiesFarm\modeling_28_02\participant_data\k10\crossval_UCB_noveltybonus_2nov\3params_2Hor_Q01\results\aver_prob_';
mod.model_type{model} = 'UCB';
mod.name{model} = 'UCBnoveltybonus3params2Hor2nov';
mod.legend{model} = 'UCB(2g,2t,1Q0)+nov(2)+xi(2)'; 

%%%%%%%%%%
% HYBRID %
%%%%%%%%%%
model = model+1;
mod.file_name{model} = 'D:\MaggiesFarm\modeling_28_02\participant_data\k10\crossval_hybrid\4params_2Hor_1w_1Q0\results\aver_prob_';
mod.model_type{model} = 'hybrid';
mod.name{model} = 'hybrid4params2Hor1w';
mod.legend{model} = 'hybrid(2g,2t,1w,1Q0,2sgm0)';
%%%%%%
model = model+1;
mod.file_name{model} = 'D:\MaggiesFarm\modeling_28_02\participant_data\k10\crossval_hybrid\5params_2Hor_1w_1Q0\results\aver_prob_';
mod.model_type{model} = 'hybrid';
mod.name{model} = 'hybrid5params2Hor1w';
mod.legend{model} = 'hybrid(2g,2t,1w,1Q0,2sgm0)+xi(2)';
%%%%%
model = model+1;
mod.file_name{model} = 'D:\MaggiesFarm\modeling_28_02\participant_data\k10\crossval_hybrid_noveltybonus_both\4params_2Hor_1w_2eta_1Q0\results\aver_prob_';
mod.model_type{model} = 'hybrid';
mod.name{model} = 'hybridnovboth4params2Hor1w';
mod.legend{model} = 'hybrid(2g,2t,1w,1Q01,2sgm0)+nov(2)'; 
%%%%%
model = model+1;
mod.file_name{model} = 'D:\MaggiesFarm\modeling_28_02\participant_data\k10\crossval_hybrid_noveltybonus_both_2nov\5params_2Hor_1w_Q01\results\aver_prob_';
mod.model_type{model} = 'hybrid';
mod.name{model} = 'hybridnovboth4paramsxi2Hor2nov';
mod.legend{model} = 'hybrid(2g,2t,1w,1Q01,2sgm0)+nov(2)+xi(2)'; 




%% Plotting  

for model = 1:size(mod.file_name,2)
    
    dirData = dir(strcat(mod.file_name{model},'*.mat'));
    mod.number_par{model} = size(dirData,1);
    disp(strcat('participants for model', 32, int2str(model), '(',mod.name{model},'),', 32,mod.legend{model}, 32, '=', 32, int2str(mod.number_par{model})))
        
    average_prob_mat = [];
    for ID = 501:560 %mod.number_par{model}
        if ID~=506
            load(strcat(mod.file_name{model}, mod.model_type{model},'_',int2str(ID),'.mat'));
            average_prob_mat(ID-500,:) = average_prob;
        else
          average_prob_mat(ID-500,:) = nan;
        end
    end
    
    mod.prob{model} = average_prob_mat ;
        
    mean_av_prob = nanmean(average_prob_mat,2); 
    
    mod.mean_pp{model} = mean_av_prob;
    mod.mean_all{model} = nanmean(mean_av_prob);
    mod.stderror_all{model} = nanstd(mean_av_prob) / sqrt(mod.number_par{model});
    
    clear mean_av_prob
end

mod_pp = nan(60,size(mod.file_name,2));

for model = 1:size(mod.file_name,2)
   mod_pp(:,model) = mod.mean_pp{model};
   mean_all(model) = mod.mean_all{model};
   stderror_all(model) = mod.stderror_all{model};
   legend_all{model} = mod.legend{model};
   number_par_all(model) = mod.number_par{model};
end

figure()

x = 1:size(mean_all,2);

% [~,I] = sort(mean_all);
I = x;

bar(x,mean_all(I))                

hold on

er = errorbar(x,mean_all(I),stderror_all(I),stderror_all(I));    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
title('10-fold crossvalidation performance per model')
ylabel('Average perforamnce accuracy [%]')
yrange = [0.5 0.57];
ylim(yrange)
xticks(1:numel(mean_all))
xticklabels(legend_all(I));
xtickangle(45)

for i1=1:numel(mean_all)
    text(x(i1),yrange(1)+0.01,num2str(number_par_all(I(i1))),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
   text(x(i1),yrange(1)+0.025,'n = ',...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
end

hold off


%% Individual model selection
for model = 1:size(mod.mean_pp,2)
    all_models(model,:) = mod.mean_pp{model}';
end

[highest_acc_pp,best_model_ind_pp] = max(all_models,[],1);
figure()
hist(best_model_ind_pp,size(mod.mean_pp,2))
xlim([1 numel(mean_all)])
ylim([1 25])
x_ax = 1:numel(mean_all);
% xticks(x_ax);
% xticklabels(legend_all(I));
% xtickangle(45)

% save('D:\writing\MF\data_for_figs\model_selection_mat_q0.mat', 'mod')
