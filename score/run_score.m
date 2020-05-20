
%% DO FOR EACH PARTICIPANT AND FOR SHORT - THEN COMPARE BY DRUG GROUPS

score_long = nan(60,3);
score_long_firstapp = nan(60,3);

for ID = 501:560
    
    tmp1 = load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis_with_logreg\part_',num2str(ID),'\logs\logABDlong.mat'));
    tmp2 = load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis_with_logreg\part_',num2str(ID),'\logs\logABlong.mat'));
    tmp3 = load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis_with_logreg\part_',num2str(ID),'\logs\logADlong.mat'));
    tmp4 = load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis_with_logreg\part_',num2str(ID),'\logs\logBDlong.mat'));

    tmp1_first.logABDlong = [];
    tmp1_second.logABDlong = [];
    for i = 1:size(tmp1.logABDlong,1)
        if tmp1.logABDlong(i,1) == 1 || tmp1.logABDlong(i,1) == 2
            tmp1_first.logABDlong(end+1,:) = tmp1.logABDlong(i,:);
        elseif tmp1.logABDlong(i,1) == 3 || tmp1.logABDlong(i,1) == 4
            tmp1_second.logABDlong(end+1,:) = tmp1.logABDlong(i,:);
        end
    end

    tmp2_first.logABlong = [];
    tmp2_second.logABlong = [];
    for i = 1:size(tmp2.logABlong,1)
        if tmp2.logABlong(i,1) == 1 || tmp2.logABlong(i,1) == 2
            tmp2_first.logABlong(end+1,:) = tmp2.logABlong(i,:);
        elseif tmp2.logABlong(i,1) == 3 || tmp2.logABlong(i,1) == 4
            tmp2_second.logABlong(end+1,:) = tmp2.logABlong(i,:);
        end
    end

    tmp3_first.logADlong = [];
    tmp3_second.logADlong = [];
    for i = 1:size(tmp3.logADlong,1)
        if tmp3.logADlong(i,1) == 1 || tmp3.logADlong(i,1) == 2
            tmp3_first.logADlong(end+1,:) = tmp3.logADlong(i,:);
        elseif tmp3.logADlong(i,1) == 3 || tmp3.logADlong(i,1) == 4
            tmp3_second.logADlong(end+1,:) = tmp3.logADlong(i,:);
        end
    end

    tmp4_first.logBDlong = [];
    tmp4_second.logBDlong = [];
    for i = 1:size(tmp4.logBDlong,1)
        if tmp4.logBDlong(i,1) == 1 || tmp4.logBDlong(i,1) == 2
            tmp4_first.logBDlong(end+1,:) = tmp4.logBDlong(i,:);
        elseif tmp4.logBDlong(i,1) == 3 || tmp4.logBDlong(i,1) == 4
            tmp4_second.logBDlong(end+1,:) = tmp4.logBDlong(i,:);
        end
    end
    
    % All trials
    score_long(ID-500,1) = sum(tmp1.logABDlong(:,7)) + sum(tmp2.logABlong(:,7)) + sum(tmp3.logADlong(:,7)) + sum(tmp4.logBDlong(:,7));
    % First half
    score_long(ID-500,2) = sum(tmp1_first.logABDlong(:,7)) + sum(tmp2_first.logABlong(:,7)) + sum(tmp3_first.logADlong(:,7)) + sum(tmp4_first.logBDlong(:,7));
    % Second half
    score_long(ID-500,3) = sum(tmp1_second.logABDlong(:,7)) + sum(tmp2_second.logABlong(:,7)) + sum(tmp3_second.logADlong(:,7)) + sum(tmp4_second.logBDlong(:,7));

    %%% Same for first apple only %%%
    % All trials 
    
    it1 = tmp1.logABDlong(:,7);
    it1(tmp1.logABDlong(:,5)~=6) = [];
    
    it1_first = tmp1_first.logABDlong(:,7);
    it1_first(tmp1_first.logABDlong(:,5)~=6) = [];
    
    it1_second = tmp1_second.logABDlong(:,7);
    it1_second(tmp1_second.logABDlong(:,5)~=6) = [];
    
    it2 = tmp2.logABlong(:,7);
    it2(tmp2.logABlong(:,5)~=6) = [];
    
    it2_first = tmp2_first.logABlong(:,7);
    it2_first(tmp2_first.logABlong(:,5)~=6) = [];
    
    it2_second = tmp2_second.logABlong(:,7);
    it2_second(tmp2_second.logABlong(:,5)~=6) = [];
    
    it3 = tmp3.logADlong(:,7);
    it3(tmp3.logADlong(:,5)~=6) = [];
    
    it3_first = tmp3_first.logADlong(:,7);
    it3_first(tmp3_first.logADlong(:,5)~=6) = [];
    
    it3_second = tmp3_second.logADlong(:,7);
    it3_second(tmp3_second.logADlong(:,5)~=6) = [];
    
    it4 = tmp4.logBDlong(:,7);
    it4(tmp4.logBDlong(:,5)~=6) = [];
    
    it4_first = tmp4_first.logBDlong(:,7);
    it4_first(tmp4_first.logBDlong(:,5)~=6) = [];
    
    it4_second = tmp4_second.logBDlong(:,7);
    it4_second(tmp4_second.logBDlong(:,5)~=6) = [];
    
    score_long_firstapp(ID-500,1) = sum(it1) + sum(it2) + sum(it3) + sum(it4);
    % First half
    score_long_firstapp(ID-500,2) = sum(it1_first) + sum(it2_first) + sum(it3_first) + sum(it4_first);
    % Second half
    score_long_firstapp(ID-500,3) = sum(it1_second) + sum(it2_second) + sum(it3_second) + sum(it4_second);
    

end

score_short = nan(60,3);

for ID = 501:560
    
    tmp1 = load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis_with_logreg\part_',num2str(ID),'\logs\logABDshort.mat'));
    tmp2 = load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis_with_logreg\part_',num2str(ID),'\logs\logABshort.mat'));
    tmp3 = load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis_with_logreg\part_',num2str(ID),'\logs\logADshort.mat'));
    tmp4 = load(strcat('D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis_with_logreg\part_',num2str(ID),'\logs\logBDshort.mat'));

    tmp1_first.logABDshort = [];
    tmp1_second.logABDshort = [];
    for i = 1:size(tmp1.logABDshort,1)
        if tmp1.logABDshort(i,1) == 1 || tmp1.logABDshort(i,1) == 2
            tmp1_first.logABDshort(end+1,:) = tmp1.logABDshort(i,:);
        elseif tmp1.logABDshort(i,1) == 3 || tmp1.logABDshort(i,1) == 4
            tmp1_second.logABDshort(end+1,:) = tmp1.logABDshort(i,:);
        end
    end

    tmp2_first.logABshort = [];
    tmp2_second.logABshort = [];
    for i = 1:size(tmp2.logABshort,1)
        if tmp2.logABshort(i,1) == 1 || tmp2.logABshort(i,1) == 2
            tmp2_first.logABshort(end+1,:) = tmp2.logABshort(i,:);
        elseif tmp2.logABshort(i,1) == 3 || tmp2.logABshort(i,1) == 4
            tmp2_second.logABshort(end+1,:) = tmp2.logABshort(i,:);
        end
    end

    tmp3_first.logADshort = [];
    tmp3_second.logADshort = [];
    for i = 1:size(tmp3.logADshort,1)
        if tmp3.logADshort(i,1) == 1 || tmp3.logADshort(i,1) == 2
            tmp3_first.logADshort(end+1,:) = tmp3.logADshort(i,:);
        elseif tmp3.logADshort(i,1) == 3 || tmp3.logADshort(i,1) == 4
            tmp3_second.logADshort(end+1,:) = tmp3.logADshort(i,:);
        end
    end

    tmp4_first.logBDshort = [];
    tmp4_second.logBDshort = [];
    for i = 1:size(tmp4.logBDshort,1)
        if tmp4.logBDshort(i,1) == 1 || tmp4.logBDshort(i,1) == 2
            tmp4_first.logBDshort(end+1,:) = tmp4.logBDshort(i,:);
        elseif tmp4.logBDshort(i,1) == 3 || tmp4.logBDshort(i,1) == 4
            tmp4_second.logBDshort(end+1,:) = tmp4.logBDshort(i,:);
        end
    end
    
    % All trials
    score_short(ID-500,1) = sum(tmp1.logABDshort(:,7)) + sum(tmp2.logABshort(:,7)) + sum(tmp3.logADshort(:,7)) + sum(tmp4.logBDshort(:,7));
    % First half
    score_short(ID-500,2) = sum(tmp1_first.logABDshort(:,7)) + sum(tmp2_first.logABshort(:,7)) + sum(tmp3_first.logADshort(:,7)) + sum(tmp4_first.logBDshort(:,7));
    % Second half
    score_short(ID-500,3) = sum(tmp1_second.logABDshort(:,7)) + sum(tmp2_second.logABshort(:,7)) + sum(tmp3_second.logADshort(:,7)) + sum(tmp4_second.logBDshort(:,7));

end

score_desc = [{'score_long_horizon'} {'score_long_horizon_first_half'} {'score_long_horizon_scond_half'} {'score_short_horizon'} {'score_short_horizon_first_half'} {'score_short_horizon_scond_half'}];
score = [score_long score_short];
