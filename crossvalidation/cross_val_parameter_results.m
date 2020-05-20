
for ID = 501:560%:560
    
    for k = 1:10
                
        n=ID + k*1000;

        tmp = load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\crossval_UCB_noveltybonus_fmincon8\3params\results\res_UCB_',int2str(n),'_results.mat'));

        all_params(ID-500,:,k) = tmp.mEparams;
    
    end

    average_allparams = mean(all_params,3);
end

disp(average_allparams)

