
for part = 501:560

    %% log ABD condition
    load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis\part_',int2str(part),'\logs\logABDlong_all.mat'))
    load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis\part_',int2str(part),'\logs\logABDshort_all.mat'))

    % long Horizon
    for i = 1:6
        tmp = logABDlong_all(find(logABDlong_all(:,5)==5+i),:);
        [rowA, ~] = find(~isnan(tmp(:,6)));
        [rowB, ~] = find(~isnan(tmp(:,7)));
        [rowC, ~] = find(~isnan(tmp(:,8)));
        [rowD, ~] = find(~isnan(tmp(:,9)));
        num_data_longH_ABD_A(i) = size(tmp(rowA,:),1);
        num_data_longH_ABD_B(i) = size(tmp(rowB,:),1);
        num_data_longH_ABD_C(i) = size(tmp(rowC,:),1);
        num_data_longH_ABD_D(i) = size(tmp(rowD,:),1);
    end

    % Short Horizon
    for i = 1
        tmp = logABDshort_all(find(logABDshort_all(:,5)==5+i),:);
        [rowA, ~] = find(~isnan(tmp(:,6)));
        [rowB, ~] = find(~isnan(tmp(:,7)));
        [rowC, ~] = find(~isnan(tmp(:,8)));
        [rowD, ~] = find(~isnan(tmp(:,9)));
        num_data_shortH_ABD_A(i) = size(tmp(rowA,:),1);
        num_data_shortH_ABD_B(i) = size(tmp(rowB,:),1);
        num_data_shortH_ABD_C(i) = size(tmp(rowC,:),1);
        num_data_shortH_ABD_D(i) = size(tmp(rowD,:),1);
    end

    %% log AB condition
    load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis\part_',int2str(part),'\logs\logABlong_all.mat'))
    load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis\part_',int2str(part),'\logs\logABshort_all.mat'))

    % long Horizon
    for i = 1:6
        tmp = logABlong_all(find(logABlong_all(:,5)==4+i),:);
        [rowA, ~] = find(~isnan(tmp(:,6)));
        [rowB, ~] = find(~isnan(tmp(:,7)));
        [rowC, ~] = find(~isnan(tmp(:,8)));
        [rowD, ~] = find(~isnan(tmp(:,9)));
        num_data_longH_AB_A(i) = size(tmp(rowA,:),1);
        num_data_longH_AB_B(i) = size(tmp(rowB,:),1);
        num_data_longH_AB_C(i) = size(tmp(rowC,:),1);
        num_data_longH_AB_D(i) = size(tmp(rowD,:),1);
    end

    % Short Horizon
    for i = 1
        tmp = logABshort_all(find(logABshort_all(:,5)==4+i),:);
        [rowA, ~] = find(~isnan(tmp(:,6)));
        [rowB, ~] = find(~isnan(tmp(:,7)));
        [rowC, ~] = find(~isnan(tmp(:,8)));
        [rowD, ~] = find(~isnan(tmp(:,9)));
        num_data_shortH_AB_A(i) = size(tmp(rowA,:),1);
        num_data_shortH_AB_B(i) = size(tmp(rowB,:),1);
        num_data_shortH_AB_C(i) = size(tmp(rowC,:),1);
        num_data_shortH_AB_D(i) = size(tmp(rowD,:),1);
    end


    %% log AD condition
    load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis\part_',int2str(part),'\logs\logADlong_all.mat'))
    load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis\part_',int2str(part),'\logs\logADshort_all.mat'))

    % long Horizon
    for i = 1:6
        tmp = logADlong_all(find(logADlong_all(:,5)==4+i),:);
        [rowA, ~] = find(~isnan(tmp(:,6)));
        [rowB, ~] = find(~isnan(tmp(:,7)));
        [rowC, ~] = find(~isnan(tmp(:,8)));
        [rowD, ~] = find(~isnan(tmp(:,9)));
        num_data_longH_AD_A(i) = size(tmp(rowA,:),1);
        num_data_longH_AD_B(i) = size(tmp(rowB,:),1);
        num_data_longH_AD_C(i) = size(tmp(rowC,:),1);
        num_data_longH_AD_D(i) = size(tmp(rowD,:),1);
    end

    % Short Horizon
    for i = 1
        tmp = logADshort_all(find(logADshort_all(:,5)==4+i),:);
        [rowA, ~] = find(~isnan(tmp(:,6)));
        [rowB, ~] = find(~isnan(tmp(:,7)));
        [rowC, ~] = find(~isnan(tmp(:,8)));
        [rowD, ~] = find(~isnan(tmp(:,9)));
        num_data_shortH_AD_A(i) = size(tmp(rowA,:),1);
        num_data_shortH_AD_B(i) = size(tmp(rowB,:),1);
        num_data_shortH_AD_C(i) = size(tmp(rowC,:),1);
        num_data_shortH_AD_D(i) = size(tmp(rowD,:),1);
    end

    %% log BD condition
    load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis\part_',int2str(part),'\logs\logBDlong.mat'))
    load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis\part_',int2str(part),'\logs\logBDshort.mat'))

    % long Horizon
    for i = 1:6
        tmp = logBDlong(find(logBDlong(:,5)==2+i),:);
        [rowA, ~] = find(tmp(:,6)==1);
        [rowB, ~] = find(tmp(:,6)==2);
        [rowC, ~] = find(tmp(:,6)==3);
        [rowD, ~] = find(tmp(:,6)==4);
        num_data_longH_BD_A(i) = size(tmp(rowA,:),1);
        num_data_longH_BD_B(i) = size(tmp(rowB,:),1);
        num_data_longH_BD_C(i) = size(tmp(rowC,:),1);
        num_data_longH_BD_D(i) = size(tmp(rowD,:),1);
    end

    % Short Horizon
    for i = 1
        tmp = logBDshort(find(logBDshort(:,5)==2+i),:);
        [rowA, ~] = find(tmp(:,6)==1);
        [rowB, ~] = find(tmp(:,6)==2);
        [rowC, ~] = find(tmp(:,6)==3);
        [rowD, ~] = find(tmp(:,6)==4);
        num_data_shortH_BD_A(i) = size(tmp(rowA,:),1);
        num_data_shortH_BD_B(i) = size(tmp(rowB,:),1);
        num_data_shortH_BD_C(i) = size(tmp(rowC,:),1);
        num_data_shortH_BD_D(i) = size(tmp(rowD,:),1);
    end

    %% ALL

    % LongH
    num_data_longH_all_A = num_data_longH_ABD_A + num_data_longH_AB_A + num_data_longH_AD_A + num_data_longH_BD_A;
    num_data_longH_all_B = num_data_longH_ABD_B + num_data_longH_AB_B + num_data_longH_AD_B + num_data_longH_BD_B;
    num_data_longH_all_C = num_data_longH_ABD_C + num_data_longH_AB_C + num_data_longH_AD_C + num_data_longH_BD_C;
    num_data_longH_all_D = num_data_longH_ABD_D + num_data_longH_AB_D + num_data_longH_AD_D + num_data_longH_BD_D;

    % ShortH
    num_data_shortH_all_A = [num_data_shortH_ABD_A + num_data_shortH_AB_A + num_data_shortH_AD_A + num_data_shortH_BD_A, nan(1,5)];
    num_data_shortH_all_B = [num_data_shortH_ABD_B + num_data_shortH_AB_B + num_data_shortH_AD_B + num_data_shortH_BD_B, nan(1,5)];
    num_data_shortH_all_C = [num_data_shortH_ABD_C + num_data_shortH_AB_C + num_data_shortH_AD_C + num_data_shortH_BD_C, nan(1,5)];
    num_data_shortH_all_D = [num_data_shortH_ABD_D + num_data_shortH_AB_D + num_data_shortH_AD_D + num_data_shortH_BD_D, nan(1,5)];


    %% Plot
    figure()

    subplot(2,2,1)
    bar([num_data_shortH_all_A', num_data_longH_all_A']./200)
    title('Apple A')
    legend('Short H', 'Long H')
    ylim([0 1])
    xlabel('Draw')
    ylabel('Proportion')

    subplot(2,2,2)
    bar([num_data_shortH_all_B', num_data_longH_all_B']./200)
    title('Apple B')
    legend('Short H', 'Long H')
    ylim([0 1])
    xlabel('Draw')
    ylabel('Proportion')

    subplot(2,2,3)
    bar([num_data_shortH_all_C', num_data_longH_all_C']./200)
    title('Apple C')
    legend('Short H', 'Long H')
    ylim([0 1])
    xlabel('Draw')
    ylabel('Proportion')

    subplot(2,2,4)
    bar([num_data_shortH_all_D', num_data_longH_all_D']./200)
    title('Apple D')
    legend('Short H', 'Long H')
    ylim([0 1])
    xlabel('Draw')
    ylabel('Proportion')


    savefig(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis\part_',int2str(part),'\histograms_alldraws.fig'))

end