
dir_data = 'D:\MaggiesFarm\2019_01_07_NADA_explore\MaggiesFarm_task\2019_07_01_apple_task_training\data_analysis\';

for ID=501:560
    crossvalidation_thompson_2param_nov_2Hor_2nov_Q01_2sgm0(ID)
end

% file_list = dir(strcat(dir_data,'part_*'));
% 
% ID_mat = [];
% for part_n = 1:size(file_list,1)
%     ID_mat(part_n) = str2num(file_list(part_n).name(6:8));
% end
% 
% for ID_n = 1:size(ID_mat,2)
%     
%         ID = ID_mat(ID_n);
%         
%         cv_mod15_heuristics(ID)
%         cv_mod13_heuristics(ID)
%         cv_mod14_heuristics(ID)
% %         cv_mod16_heuristics(ID)
%     
% end

