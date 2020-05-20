
for ID = 501:560

    load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\crossval_UCB_noveltybonus_fmincon8\3params\results\aver_prob_UCB_',int2str(ID),'.mat'));

    average_prob_mat(ID-500,:) = average_prob;

end

figure()

stderror = std(average_prob_mat') / sqrt(length(average_prob_mat));

h1 = plot(0:size(average_prob_mat,1)+1, 1/3*ones(1,size(average_prob_mat,1)+2), 'b', 'LineWidth',3); hold on;

h2 = bar(1:size(average_prob_mat,1),mean(average_prob_mat,2));      

hold on

er = errorbar(1:size(average_prob_mat,1),mean(average_prob_mat,2),stderror,stderror);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

h3 = plot(0:size(average_prob_mat,1)+1, 1/3*ones(1,size(average_prob_mat,1)+2), 'b', 'LineWidth',3);

xticks([1:size(average_prob_mat,1)])

title('10-fold cross-validation')
xlabel('Participant')
ylabel('Average prediction on test trials')

mean_av_prob = mean(average_prob_mat,2);
mean_all = mean(mean_av_prob)
stderror_all = std(mean_av_prob') / sqrt(length(mean_av_prob));

h4 = plot(0:size(average_prob_mat,1)+1,(mean_all+stderror_all)*ones(1,size(average_prob_mat,1)+2), '--k', 'LineWidth',0.75); 
h5 = plot(0:size(average_prob_mat,1)+1,mean_all*ones(1,size(average_prob_mat,1)+2), 'k', 'LineWidth',1);
h6 = plot(0:size(average_prob_mat,1)+1,(mean_all-stderror_all)*ones(1,size(average_prob_mat,1)+2), '--k', 'LineWidth',0.75);

ylim([0 1])

legend([h1 h5],{'Chance', 'Participant mean'});

