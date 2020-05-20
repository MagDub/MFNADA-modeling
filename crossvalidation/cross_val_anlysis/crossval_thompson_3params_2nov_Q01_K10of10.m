
k = 10;

params = nan(60,6);

for ID = 501:560
    tmp = load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\crossval_thompson_noveltybonus_2nov\3params_2Hor_Q01\results\res_thompson_',num2str(k),num2str(ID),'_results.mat'));
    params((ID-500),1:6) = tmp.mE.params;
end
