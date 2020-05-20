



%% Thompson2params

% for ID = 552 
% 
% results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\thompson\2params_1Hor\results\fmincon\';
%     
% load(strcat(results_dir_,'res_thompson_',int2str(ID),'_results.mat')); mE
% 
% data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\';
% [data,gameIDs] = aggregateData(ID,data_dir);
% 
% modelfun = @(x) modelMF_S0fixed(x,settings.params.param_names,ID,settings,data,gameIDs); 
% 
% HeY = NumHessianYtest(modelfun,mE.params);
% 
% save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY)
% 
% end


%% Thompson3params1Hor

% for ID = 506 
% 
% disp(ID)
% 
% results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\thompson\3params_1Hor\results\fmincon\';
%     
% load(strcat(results_dir_,'res_thompson_',int2str(ID),'_results.mat')); %mE
% 
% data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\'; 
% [data,gameIDs] = aggregateData(ID,data_dir);
% 
% modelfun = @(x) modelMF_S0fixed(x,settings.params.param_names,ID,settings,data,gameIDs); 
% 
% HeY = NumHessianYtest(modelfun,mE.params);
% 
% save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY)
% 
% end


%% UCB2params2Hor

% for ID = 530 
% 
% results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\UCB\2params_2Hor\results\fmincon\';
%     
% load(strcat(results_dir_,'res_UCB_',int2str(ID),'_results.mat')); mE
% 
% data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\'; 
% [data,gameIDs] = aggregateData(ID,data_dir);
% 
% modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed(x,settings.params.param_names,ID,settings,data,gameIDs); 
% 
% HeY = NumHessianYtest(modelfun,mE.params);
% 
% save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY);
% 
% end


%% UCB2paramsnoveltybonus2Hor

% for ID = [521, 522, 525] 
% 
% results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\UCB_noveltybonus\3params_2Hor\results\fmincon\';
%     
% load(strcat(results_dir_,'res_UCB_',int2str(ID),'_results.mat')); mE
% 
% data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\'; 
% [data,gameIDs] = aggregateData(ID,data_dir);
% 
% modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed_eta(x,settings.params.param_names,ID,settings,data,gameIDs); 
% 
% HeY = NumHessianYtest(modelfun,mE.params);
% 
% save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY);
% 
% end


%% UCB3params2Hor
% for ID = [502, 552] 
% 
% results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\UCB\3params_2Hor\results\fmincon\';
%     
% load(strcat(results_dir_,'res_UCB_',int2str(ID),'_results.mat')); mE
% 
% data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\'; 
% [data,gameIDs] = aggregateData(ID,data_dir);
% 
% modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed_lapse(x,settings.params.param_names,ID,settings,data,gameIDs); 
% 
% HeY = NumHessianYtest(modelfun,mE.params);
% 
% save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY);
% 
% end

%% UCB3paramsnoveltybonus2Hor
% 
% for ID = [501, 503, 524] 
% 
% results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\UCB_noveltybonus\4params_2Hor\results\fmincon\';
%     
% load(strcat(results_dir_,'res_UCB_',int2str(ID),'_results.mat')); mE
% 
% data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\'; 
% [data,gameIDs] = aggregateData(ID,data_dir);
% 
% modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed_lapse_eta(x,settings.params.param_names,ID,settings,data,gameIDs); 
% 
% HeY = NumHessianYtest(modelfun,mE.params);
% 
% save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY);
% 
% end

% %% hybrid3params2Hor
% 
% for ID = [521, 541, 554]
% 
% results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\3params_2Hor\results\fmincon\';
%     
% load(strcat(results_dir_,'res_hybrid_',int2str(ID),'_results.mat')); mE
% 
% data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\'; 
% [data,gameIDs] = aggregateData(ID,data_dir);
% 
% modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed(x,settings.params.param_names,ID,settings,data,gameIDs); 
% 
% HeY = NumHessianYtest(modelfun,mE.params);
% 
% save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY);
% 
% end
% 
% %% hybrid3paramsnoveltybonus2Hor
% 
% for ID = [503, 506, 519, 521, 523, 527, 546, 556] 
% 
% results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\hybrid_noveltybonus\3params_2Hor\results\fmincon\';
%     
% load(strcat(results_dir_,'res_hybrid_',int2str(ID),'_results.mat')); mE
% 
% data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\'; 
% [data,gameIDs] = aggregateData(ID,data_dir);
% 
% modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed_eta(x,settings.params.param_names,ID,settings,data,gameIDs); 
% 
% HeY = NumHessianYtest(modelfun,mE.params);
% 
% save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY);
% 
% end
%  
% %% hybrid3paramsxi2Hor
% 
% for ID = [501, 504, 506, 513, 519, 520, 545]
% 
% results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\3params_xi_2Hor\results\fmincon\';
%     
% load(strcat(results_dir_,'res_hybrid_',int2str(ID),'_results.mat')); mE
% 
% data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\'; 
% [data,gameIDs] = aggregateData(ID,data_dir);
% 
% modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed_lapse(x,settings.params.param_names,ID,settings,data,gameIDs); 
% 
% HeY = NumHessianYtest(modelfun,mE.params);
% 
% save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY);
% 
% end
% 
% %% hybrid3paramsxinoveltybonus2Hor
% 
% for ID = [501, 513, 527, 540, 554, 559]
% 
% results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\hybrid_noveltybonus\3params_xi_2Hor\results\fmincon\';
%     
% load(strcat(results_dir_,'res_hybrid_',int2str(ID),'_results.mat')); mE
% 
% data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\'; 
% [data,gameIDs] = aggregateData(ID,data_dir);
% 
% modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed_lapse_eta(x,settings.params.param_names,ID,settings,data,gameIDs); 
% 
% HeY = NumHessianYtest(modelfun,mE.params);
% 
% save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY);
% 
% end

% %% hybrid3paramsxinoveltybonus2Hor1Tau
% 
% for ID = 501:560
% 
% results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\hybrid_noveltybonus\3params_xi_2Hor1Tau\results\fmincon\';
%     
% load(strcat(results_dir_,'res_hybrid_',int2str(ID),'_results.mat')); mE
% 
% data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\'; 
% [data,gameIDs] = aggregateData(ID,data_dir);
% 
% modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed_lapse_eta(x,settings.params.param_names,ID,settings,data,gameIDs); 
% 
% HeY = NumHessianYtest(modelfun,mE.params);
% 
% save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY, mEmatparams, mEmatmle);
% 
% end

%% hybrid3paramsxinoveltybonus2Hor1Xi

for ID = 537:560

results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\hybrid_noveltybonus\3params_xi_2Hor1Xi\results\fmincon\';
    
load(strcat(results_dir_,'res_hybrid_',int2str(ID),'_results.mat')); mE

data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\'; 
[data,gameIDs] = aggregateData(ID,data_dir);

modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed_lapse_eta(x,settings.params.param_names,ID,settings,data,gameIDs); 

HeY = NumHessianYtest(modelfun,mE.params);

save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY, mEmatparams, mEmatmle);

end

%% hybrid3paramsxinoveltybonus2Hor1whyb

for ID = 501:560

results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\hybrid_noveltybonus\3params_xi_2Hor1whyb\results\fmincon\';
    
load(strcat(results_dir_,'res_hybrid_',int2str(ID),'_results.mat')); mE

data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\'; 
[data,gameIDs] = aggregateData(ID,data_dir);

modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed_lapse_eta(x,settings.params.param_names,ID,settings,data,gameIDs); 

HeY = NumHessianYtest(modelfun,mE.params);

save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY, mEmatparams, mEmatmle);

end

%% hybrid3paramsxinoveltybonus2Hor1Tau1Xi

for ID = 501:560

results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\hybrid_noveltybonus\3params_xi_2Hor1Tau1Xi\results\fmincon\';
    
load(strcat(results_dir_,'res_hybrid_',int2str(ID),'_results.mat')); mE

data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\'; 
[data,gameIDs] = aggregateData(ID,data_dir);

modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed_lapse_eta(x,settings.params.param_names,ID,settings,data,gameIDs); 

HeY = NumHessianYtest(modelfun,mE.params);

save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY, mEmatparams, mEmatmle);

end

%% hybrid3paramsxinoveltybonus2Hor1Tau1Xi1whyb

for ID = 501:560

results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\hybrid_noveltybonus\3params_xi_2Hor1Tau1Xi1whyb\results\fmincon\';
    
load(strcat(results_dir_,'res_hybrid_',int2str(ID),'_results.mat')); mE

data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\'; 
[data,gameIDs] = aggregateData(ID,data_dir);

modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed_lapse_eta(x,settings.params.param_names,ID,settings,data,gameIDs); 

HeY = NumHessianYtest(modelfun,mE.params);

save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY, mEmatparams, mEmatmle);

end

% %% hybrid4params2Hor
% 
% for ID = [501, 507, 510, 511, 512, 521, 526, 532, 534,  545, 547, 551, 554, 557, 559] 
% 
% results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\4params_2Hor\results\fmincon\';
%     
% load(strcat(results_dir_,'res_hybrid_',int2str(ID),'_results.mat')); mE
% 
% data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\'; 
% [data,gameIDs] = aggregateData(ID,data_dir);
% 
% modelfun = @(x) modelMF_S0fixed_Q0fixed(x,settings.params.param_names,ID,settings,data,gameIDs); 
% 
% HeY = NumHessianYtest(modelfun,mE.params);
% 
% save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY);
% 
% end
% 
% 
% %% hybrid4paramsnoveltybonus2Hor
% 
% 
% for ID = [502, 504,  510, 512, 513, 514,  518, 522, 524,  535, 537, 539, 541, 547, 557, 558, 560] 
% 
% results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\hybrid_noveltybonus\4params_2Hor\results\fmincon\';
%     
% load(strcat(results_dir_,'res_hybrid_',int2str(ID),'_results.mat')); mE
% 
% data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\'; 
% [data,gameIDs] = aggregateData(ID,data_dir);
% 
% modelfun = @(x) modelMF_S0fixed_Q0fixed_eta(x,settings.params.param_names,ID,settings,data,gameIDs); 
% 
% HeY = NumHessianYtest(modelfun,mE.params);
% 
% save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY);
% 
% end
% 
% %% hybrid4paramsxi2Hor
% 
% for ID = [503, 506, 507, 509, 515, 519, 538, 539, 543,548, 552, 557] 
% 
% results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\5params_2Hor\results\fmincon\';
%     
% load(strcat(results_dir_,'res_hybrid_',int2str(ID),'_results.mat')); mE
% 
% data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\'; 
% [data,gameIDs] = aggregateData(ID,data_dir);
% 
% modelfun = @(x) modelMF_S0fixed_Q0fixed_lapse(x,settings.params.param_names,ID,settings,data,gameIDs); 
% 
% HeY = NumHessianYtest(modelfun,mE.params);
% 
% save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY);
% 
% end
% 
% %% hybrid4paramsxinoveltybonus2Hor
% 
% 
% for ID = [501, 503, 509,  513, 517, 521, 547 , 551, 553, 555, 557] 
% 
% results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\hybrid_noveltybonus\5params_2Hor\results\fmincon\';
%     
% load(strcat(results_dir_,'res_hybrid_',int2str(ID),'_results.mat')); mE
% 
% data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\'; 
% [data,gameIDs] = aggregateData(ID,data_dir);
% 
% modelfun = @(x) modelMF_S0fixed_Q0fixed_lapse_eta(x,settings.params.param_names,ID,settings,data,gameIDs); 
% 
% HeY = NumHessianYtest(modelfun,mE.params);
% 
% save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY);
% 
% end

% %% UCB3paramsnoveltybonus2Hor1Tau
% 
% for ID = [509, 511] 
% 
% results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\UCB_noveltybonus\4params_2Hor_excepttau\results\fmincon\';
%     
% load(strcat(results_dir_,'res_UCB_',int2str(ID),'_results.mat')); mE
% 
% data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\'; 
% [data,gameIDs] = aggregateData(ID,data_dir);
% 
% modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed_lapse_eta(x,settings.params.param_names,ID,settings,data,gameIDs); 
% 
% HeY = NumHessianYtest(modelfun,mE.params);
% 
% save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY, mEmatparams, mEmatmle);
% 
% end
% 
% %% UCB3paramsnoveltybonus2Hor1Xi
% 
% for ID = [502 503 518 530 535 541 552] 
% 
% results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\UCB_noveltybonus\4params_2Hor_exceptxi\results\fmincon\';
%     
% load(strcat(results_dir_,'res_UCB_',int2str(ID),'_results.mat')); mE
% 
% data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\'; 
% [data,gameIDs] = aggregateData(ID,data_dir);
% 
% modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed_lapse_eta(x,settings.params.param_names,ID,settings,data,gameIDs); 
% 
% HeY = NumHessianYtest(modelfun,mE.params);
% 
% save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY, mEmatparams, mEmatmle);
% 
% end
% 
% %% UCB3paramsnoveltybonus2Hor1Xi1Tau
% 
% for ID = [502 509 524 532]
%     
% results_dir_ = 'D:\MaggiesFarm\modeling_28_02\participant_data\UCB_noveltybonus\4params_2Hor_exceptxitau\results\fmincon\';
%     
% load(strcat(results_dir_,'res_UCB_',int2str(ID),'_results.mat')); mE
% 
% data_dir = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data\'; 
% [data,gameIDs] = aggregateData(ID,data_dir);
% 
% modelfun = @(x) modelMF_S0fixed_Q0fixed_sgm0fixed_lapse_eta(x,settings.params.param_names,ID,settings,data,gameIDs); 
% 
% HeY = NumHessianYtest(modelfun,mE.params);
% 
% save_func_data(ID, settings, results_dir_, mEparams, mEmle, [], mEexitflag, mEsubj, [], HeY, mEmatparams, mEmatmle);
% 
% end
