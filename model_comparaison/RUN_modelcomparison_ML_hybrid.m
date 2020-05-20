clear

% clear all; close all; clc
addpath(genpath('D:\myDocuments\work\Projects\gen_funct\'))
res_dir = 'D:\MaggiesFarm\modeling_28_02\participant_data\';

% Number of participants
npart = 60; 

%% folder where to save figures

folder_name = strcat('D:\MaggiesFarm\modeling_28_02\participant_data\ModelSelection\');

if ~exist(folder_name)
    mkdir(folder_name)
end

%% model space
n=0; 


n=n+1;
mod(n).desc  = 'Hybrid3param';
mod(n).fname = strcat('hybrid\3params_1Hor\results\fmincon\res_hybrid_');

n=n+1;
mod(n).desc  = 'Hybrid3paramxi';
mod(n).fname = strcat('hybrid\3params_xi_1Hor\results\fmincon\res_hybrid_');

n=n+1;
mod(n).desc  = 'Hybrid4param';
mod(n).fname = strcat('hybrid\4params_1Hor\results\fmincon\res_hybrid_');

n=n+1;
mod(n).desc  = 'Hybrid4paramxi';
mod(n).fname = strcat('hybrid\5params_1Hor\results\fmincon\res_hybrid_');




%% calculate modelfits
    for n = 1:length(mod)
        clear tmp tmpp

        %load data
        for i=501:(500+npart)
            tmp=load([res_dir mod(n).fname int2str(i) '_results.mat']);
            disp(i)
            tmpMat(i-500).mle = tmp.mE.mle;
            if strcmp(mod(n).desc,'Thompson3params')
                tmpMat(i-500).HeY = tmp.mE.HeY;
            elseif strcmp(mod(n).desc,'UCB3params')
                tmpMat(i-500).HeY = tmp.mE.He_LL;
            elseif strcmp(mod(n).desc,'Hybrid5param')
                tmpMat(i-500).HeY = [];
            end
        end

        % log Likelihood
        logL(n,:) = [tmpMat(:).mle].*-1; % neg LL * -1

%         % Det Hessian
%         for i =1:npart
%             if ~isempty(tmpMat(i).HeY)
%                 if det(tmpMat(i).HeY) < 0         
%                     logdetHess(n,i) = nan;
%                     disp(strcat('hess neg for part', int2str(i), 32, 'in', 32, mod(n).desc))
%                 elseif det(tmpMat(i).HeY) == 0   
%                     logdetHess(n,i) = nan;
%                     disp(strcat('hess null for part', int2str(i), 32, 'in', 32, mod(n).desc))
%                 elseif -log(det(tmpMat(i).HeY)) > realmax
%                     logdetHess(n,i) = -realmax;
%                 else
%                     logdetHess(n,i) = log(det(tmpMat(i).HeY));
%                 end
%             end
%         end

        % calculate AIC & BIC punishment (depending on the trial number where param was used  
        tmpp = tmp.settings.params;

        n_paramAll = length(tmpp.param_names); %- numel(find(strcmp(tmpp.param_names,''))) %* 2   % params for both conditions
        n_param1Cond = length(tmpp.param_names) - numel(find(strcmp(tmpp.param_names,''))); %* 2;                            % params for 1 condition

        % criterions
        BIC(n,:) = -2.*logL(n,:) + n_paramAll * log(tmp.settings.task.N_games) + n_param1Cond * log(tmp.settings.task.Ngames_per_hor);   % adjusted for the No trials the parameter are relevant for
        AIC(n,:) = -2.*logL(n,:) + 2 * length(tmpp.param_names);
%         if n<6
%             lme(n,:) = logL(n,:) + 0.5*(n_paramAll*log(2*pi) - logdetHess(n,:)); % posterior = logL * uniform distrib = logL
%         end
        desc{n} = mod(n).desc;
    end

%% plot
CT = [.5 .5 .5];
fs = 15;

odesc = desc;
figure('Color','w','units','normalized','outerposition',[0 0 1 1])
set(gca,'FontSize',fs,'FontName','Arial')

% logL
subplot(1,4,1)
bar(sum(-logL,2))
% h = findobj(gca,'Type','patch');
h = findobj(gca,'Type','BAR');
set(h(1),'FaceColor',CT(:),'EdgeColor','k');
ylabel('summed negative logL','FontSize',fs,'FontWeight','bold')

xlim([0 length(mod)+1])
set(gca,'FontSize',fs)

my_xticklabels(1:length(desc),desc,'Rotation',90,'VerticalAlignment','middle','HorizontalAlignment','left','FontSize',fs,'FontWeight','normal');

% if stage==2
%     ylim([1500 2100])
% end

% % lme
% subplot(1,4,4)
% % bar([ nansum(lme(1,:)/sum(~isnan(lme(1,:))))  nansum(lme(2,:)/sum(~isnan(lme(2,:)))) nansum(lme(3,:)/sum(~isnan(lme(3,:))))   nansum(lme(4,:)/sum(~isnan(lme(4,:))))  nansum(lme(5,:)/sum(~isnan(lme(5,:)))) nansum(lme(6,:)/sum(~isnan(lme(6,:)))) nansum(lme(7,:)/sum(~isnan(lme(7,:))))]) %some are nan, so we calculate the mean per participant (excluding nans)
% %bar([ nansum(lme(1,:)/sum(~isnan(lme(1,:))))  nansum(lme(2,:)/sum(~isnan(lme(2,:)))) nansum(lme(3,:)/sum(~isnan(lme(3,:))))   nansum(lme(4,:)/sum(~isnan(lme(4,:))))  nansum(lme(5,:)/sum(~isnan(lme(5,:)))) nansum(lme(6,:)/sum(~isnan(lme(6,:)))) nansum(lme(7,:)/sum(~isnan(lme(7,:)))) nansum(lme(8,:)/sum(~isnan(lme(8,:)))) nansum(lme(9,:)/sum(~isnan(lme(9,:)))) nansum(lme(10,:)/sum(~isnan(lme(10,:)))) nansum(lme(11,:)/sum(~isnan(lme(11,:))))]) %some are nan, so we calculate the mean per participant (excluding nans)
% bar(nansum(lme,2))
% % h = findobj(gca,'Type','patch');
% h = findobj(gca,'Type','BAR');
% set(h(1),'FaceColor',CT(:),'EdgeColor','k');
% ylabel('Averaged marginal likelihood (model evidence)','FontSize',fs,'FontWeight','bold')
% 
% xlim([0 length(mod)+1])
% set(gca,'FontSize',fs)
% 
% my_xticklabels(1:length(desc),desc,'Rotation',90,'VerticalAlignment','middle','HorizontalAlignment','left','FontSize',fs,'FontWeight','normal');

% AIC
subplot(1,4,2)
bar(sum(AIC,2)-min(sum(AIC,2)))
% h = findobj(gca,'Type','patch');
h = findobj(gca,'Type','BAR');
set(h(1),'FaceColor',CT(:),'EdgeColor','k');
hold on
[~,tmp] = min(sum(AIC,2));
% bar(tmp,sum(AIC(tmp,:)-min(sum(AIC,2))),'FaceColor',[.7 .7 .7],'EdgeColor','k');
ylabel('summed \DeltaAIC','FontSize',fs,'FontWeight','bold')
xlim([0 length(mod)+1])
desc_tmp = desc(tmp); desc(tmp) = {''};
my_xticklabels(1:length(desc),desc,'Rotation',90,'VerticalAlignment','middle','HorizontalAlignment','left','FontSize',fs,'FontWeight','normal');
text('String',desc_tmp, ...
        'Units','data', ...
        'VerticalAlignment', 'middle', ...
        'HorizontalAlignment', 'left ', ...
        'Position',[tmp 0], ...
        'FontSize',fs, ...
        'FontWeight','bold', ...
        'Rotation',90,...
        'Tag','MUXTL');

set(gca,'FontSize',fs)
% if stage==2
%     ylim([3750 4600])
% end

% BIC
subplot(1,4,3)
bar(sum(BIC,2)-min(sum(BIC,2)))
% h = findobj(gca,'Type','patch');
h = findobj(gca,'Type','BAR');
set(h(1),'FaceColor',CT(:),'EdgeColor','k');
hold on
[~,tmp] = min(sum(BIC,2));
% bar(tmp,sum(BIC(tmp,:)-min(sum(BIC,2))),'FaceColor',[.7 .7 .7],'EdgeColor','k');
ylabel('summed \DeltaBIC','FontSize',fs,'FontWeight','bold')

xlim([0 length(mod)+1])
my_xticklabels(1:length(desc),desc,'Rotation',90,'VerticalAlignment','middle','HorizontalAlignment','left','FontSize',fs,'FontWeight','normal');
text('String',desc_tmp, ...
        'Units','data', ...
        'VerticalAlignment', 'middle', ...
        'HorizontalAlignment', 'left ', ...
        'Position',[tmp 0], ...
        'FontSize',fs, ...
        'FontWeight','bold', ...
        'Rotation',90,...
        'Tag','MUXTL');

set(gca,'FontSize',fs)
% if stage==2
%     ylim([3900 4700])
% end

% export_fig(['D:\myDocuments\work\Publications\NaDa_IST\Figs\model_cmp.tif'],'-nocrop','-r100')+


savefig(strcat(folder_name, 'BICandAIC'));
%close all;

% %% print out
% sLogL = sum(logL,2);
% sAIC = sum(AIC,2);
% sBIC = sum(BIC,2);
% for m = 1:length(odesc)
%     output = [odesc{m} ': logL: '];
%     output = [output num2str(sLogL(m),'%.0f') ', AIC: '];
%     output = [output num2str(sAIC(m),'%.0f') ', BIC: '];
%     output = [output num2str(sBIC(m),'%.0f') '\n'];
%     fprintf(output)
% end
% 
%% per participant
% figure()
% for part = 1:60
%     subplot(9,7,part)
%     bar((BIC(:,part)))
%     title(int2str(part))
%     ylim([min(BIC(:,part))-0.1*min(BIC(:,part)) max(BIC(:,part))+0.1*max(BIC(:,part))])
% end
% 
% figure()
% for part = 1:60
%     subplot(9,7,part)
%     bar((lme(:,part)))
%     title(int2str(part))
%     ylim([min(lme(:,part))-0.1*min(lme(:,part)) max(lme(:,part))+0.1*max(lme(:,part))])
% end
 
% % savefig(strcat(folder_name, 'BICandAIC_individual'));
% % close all;
% % 
% % Thompson fmin
% % UCB fmin
% % Thompson genetic
% % UCB genetic
% 
% figure()
% BIC_thompson = BIC([1 3],:);
% barh(BIC_thompson(2,:)-BIC_thompson(1,:))
% title('Comparison in Thompson between 2 optimisation algorithms')
% ylabel('Participant')
% xlabel('BIC genetic - BIC fmin')
% 
% % savefig(strcat(folder_name, 'BIC_individual_Thompson_genetic_vs_fmin'));
% % close all;
% 
% figure()
% BIC_UCB = BIC([2 4],:);
% barh(BIC_UCB(2,:)-BIC_UCB(1,:))
% title('Comparison in UCB between 2 optimisation algorithms')
% ylabel('Participant')
% xlabel('BIC genetic - BIC fmin')
% 
% % savefig(strcat(folder_name, 'BIC_individual_UCB_genetic_vs_fmin'));
% % close all;
% 
% figure()
% BIC_fmincon = BIC([1 2],:);
% barh(BIC_fmincon(2,:)-BIC_fmincon(1,:))
% title('Comparison between UCB and thompson both optimised by fmincon')
% ylabel('Participant')
% xlabel('BIC UCB - BIC Thompson')
% 
% % savefig(strcat(folder_name, 'BIC_individual_UCB_vs_thompson_fmin'));
% % close all;
% 
% figure()
% BIC_GA = BIC([3 4],:);
% barh(BIC_GA(2,:)-BIC_GA(1,:))
% title('Comparison between UCB and thompson both optimised by genetic algorithms')
% ylabel('Participant')
% xlabel('BIC UCB - BIC Thompson')
% 
% % savefig(strcat(folder_name, 'BIC_individual_UCB_vs_thompson_genetic'));
% % close all;

