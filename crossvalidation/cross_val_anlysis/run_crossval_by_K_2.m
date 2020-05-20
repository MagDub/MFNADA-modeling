
average_prob_all = nan(60,2);

%best
n=1;
algo{n}.algo = 'thompson';
algo{n}.name = 'thompsonnov(1sgm0,1Q01)+nov(2)+xi(2)';
algo{n}.path = 'crossval_thompson_noveltybonus_2nov\3params_2Hor_Q01_K2\';

for n=1:size(algo,2)
    
    for ID = 501:560

        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\',algo{n}.path ,'results\aver_prob_',algo{n}.algo,'_',num2str(ID),'.mat'))

        average_prob_all(ID-500,:) = average_prob;

    end

    figure()

    x = [1:2];

    bar(x,mean(average_prob_all,1)); hold on

    er = errorbar(x,mean(average_prob_all,1),std(average_prob_all,1)/sqrt(60),std(average_prob_all,1)/sqrt(60)); 

    er.Color = [0 0 0];     
    er.LineStyle = 'none';  

    % k-fold validation indexes
    range_test_mat(1,:) = [101,200];
    range_test_mat(2,:) = [1,100];

    for i=1:2
        range_test_mat_legend{i} = strcat(num2str(range_test_mat(i,1)), '-', num2str(range_test_mat(i,2)));
    end

    xticks(1:2)
    xticklabels(range_test_mat_legend);
    xtickangle(45)
    xlabel('Validated on trials')
    ylabel('Prediciton accuracy (average across participants)')
    ylim([0.4 0.6])
    title(algo{n}.name)
end
