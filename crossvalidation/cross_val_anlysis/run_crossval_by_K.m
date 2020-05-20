

%best
n=1;
algo{n}.algo = 'thompson';
algo{n}.name = 'thompsonnov(1sgm0,1Q01)+nov(2)+xi(2)';
algo{n}.path = 'crossval_thompson_noveltybonus_2nov\3params_2Hor_Q01\';

% best UCB
n=n+1;
algo{n}.algo = 'UCB';
algo{n}.name = 'UCB(2g,1t)+nov(2)+xi(2)';
algo{n}.path = 'crossval_UCB_noveltybonus_2nov\3params_2Hor_1tau\';

% best hybrid
n=n+1;
algo{n}.algo = 'hybrid';
algo{n}.name = 'hybrid(2g,2t,1w)+bothnov(1)+sgm0(1)';
algo{n}.path = 'crossval_hybrid_noveltybonus_both\4params_2Hor_1w\';

% random
n=n+1;
algo{n}.algo = 'UCB';
algo{n}.name = 'UCB2params1Hor';
algo{n}.path = 'crossval_UCB\2params_1Hor\';

% the worse
n=n+1;
algo{n}.algo = 'hybrid';
algo{n}.name = 'hybrid(1g,1t,1w)+xi(1)';
algo{n}.path = 'crossval_hybrid\3params_xi_1Hor\';

average_prob_all = [];

for n=1:size(algo,2)
    
    for ID = 501:560

        load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\',algo{n}.path ,'results\aver_prob_',algo{n}.algo,'_',num2str(ID),'.mat'))

        average_prob_all(ID-500,:) = average_prob;

    end

    figure()

    x = [1:10];

    bar(x,mean(average_prob_all,1)); hold on

    er = errorbar(x,mean(average_prob_all,1),std(average_prob_all,1)/sqrt(60),std(average_prob_all,1)/sqrt(60)); 

    er.Color = [0 0 0];     
    er.LineStyle = 'none';  

    % k-fold validation indexes
    range_test_mat = nan(10,2);
    for i=1:10
        k=i-1;
        range_test_mat(i,:) = [20*k+1,20*k+20];
        range_test_mat_legend{i} = strcat(num2str(range_test_mat(i,1)), '-', num2str(range_test_mat(i,2)));
    end

    xticks(1:10)
    xticklabels(range_test_mat_legend);
    xtickangle(45)
    xlabel('Validated on trials')
    ylabel('Prediciton accuracy (average across participants)')
    ylim([0.4 0.6])
    title(algo{n}.name)
end
