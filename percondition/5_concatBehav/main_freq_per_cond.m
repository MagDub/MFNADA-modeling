cond = [];

addpath('./functions/')

data_fold = ('../../../data/');

dir_data = (strcat(data_fold,'data_analysis/'));
dir_save = (strcat(data_fold,'data_for_figs_per_cond/'));

cond_mat = [];

for ID = 501:560
    
        ID_n = ID-500;
    
        %%% cond AB

        cond{ID_n}.AB = [];

        load(strcat(dir_data, 'part_',int2str(ID),'/mat_AB.mat'));

        short_ind = find(mat_AB(:,3)==6);
        long_ind = find(mat_AB(:,3)==11);

        tmp = short_ind;
        cond{ID_n}.AB(1:4) = [size(find(mat_AB(tmp,9)==1),1),size(find(mat_AB(tmp,9)==2),1), size(find(mat_AB(tmp,9)==3),1), size(find(mat_AB(tmp,9)==4),1)];

        tmp = long_ind;
        cond{ID_n}.AB(5:8) = [size(find(mat_AB(tmp,9)==1),1),size(find(mat_AB(tmp,9)==2),1), size(find(mat_AB(tmp,9)==3),1), size(find(mat_AB(tmp,9)==4),1)];

        %%% cond BD

        cond{ID_n}.BD = [];

        load(strcat(dir_data, 'part_',int2str(ID),'/mat_BD.mat'));

        short_ind = find(mat_BD(:,3)==6);
        long_ind = find(mat_BD(:,3)==11);

        tmp = short_ind;
        cond{ID_n}.BD(1:4) = [size(find(mat_BD(tmp,7)==1),1),size(find(mat_BD(tmp,7)==2),1), size(find(mat_BD(tmp,7)==3),1), size(find(mat_BD(tmp,7)==4),1)];

        tmp = long_ind;
        cond{ID_n}.BD(5:8) = [size(find(mat_BD(tmp,7)==1),1),size(find(mat_BD(tmp,7)==2),1), size(find(mat_BD(tmp,7)==3),1), size(find(mat_BD(tmp,7)==4),1)];


        %%% cond ABD

        cond{ID_n}.ABD = []; 

        load(strcat(dir_data, 'part_',int2str(ID),'/mat_ABD.mat'));

        short_ind = find(mat_ABD(:,3)==6);
        long_ind = find(mat_ABD(:,3)==11);

        tmp = short_ind;
        cond{ID_n}.ABD(1:4) = [size(find(mat_ABD(tmp,10)==1),1),size(find(mat_ABD(tmp,10)==2),1), size(find(mat_ABD(tmp,10)==3),1), size(find(mat_ABD(tmp,10)==4),1)];

        tmp = long_ind;
        cond{ID_n}.ABD(5:8) = [size(find(mat_ABD(tmp,10)==1),1),size(find(mat_ABD(tmp,10)==2),1), size(find(mat_ABD(tmp,10)==3),1), size(find(mat_ABD(tmp,10)==4),1)];


        %%% cond AD

        cond{ID_n}.AD = []; 

        load(strcat(dir_data, 'part_',int2str(ID),'/mat_AD.mat'));

        short_ind = find(mat_AD(:,3)==6);
        long_ind = find(mat_AD(:,3)==11);

        tmp = short_ind;
        cond{ID_n}.AD(1:4) = [size(find(mat_AD(tmp,9)==1),1),size(find(mat_AD(tmp,9)==2),1), size(find(mat_AD(tmp,9)==3),1), size(find(mat_AD(tmp,9)==4),1)];

        tmp = long_ind;
        cond{ID_n}.AD(5:8) = [size(find(mat_AD(tmp,9)==1),1),size(find(mat_AD(tmp,9)==2),1), size(find(mat_AD(tmp,9)==3),1), size(find(mat_AD(tmp,9)==4),1)];

        % desc
        cond{ID_n}.desc = {'A_short', 'B_short', 'C_short', 'D_short', 'A_long', 'B_long', 'C_long', 'D_long'};

end

for ID = 501:560
    
       ID_n = ID-500;
    
       cond_mat_AB(ID_n, 1:8) = cond{ID_n}.AB; 
       cond_mat_BD(ID_n, 1:8) = cond{ID_n}.BD; 
       cond_mat_ABD(ID_n, 1:8) = cond{ID_n}.ABD; 
       cond_mat_AD(ID_n, 1:8) = cond{ID_n}.AD; 
end


frequencies_desc = [{'all_A_short'} {'all_B_short'} {'all_C_short'} {'all_D_short'} ...
                {'all_A_long'} {'all_B_long'} {'all_C_long'} {'all_D_long'}];
            
frequencies_AB = cond_mat_AB;
frequencies_BD = cond_mat_BD;
frequencies_ABD = cond_mat_ABD;
frequencies_AD = cond_mat_AD;

save(strcat(dir_save, 'frequencies_desc.mat'), 'frequencies_desc');            
save(strcat(dir_save, 'frequencies_AB.mat'), 'frequencies_AB');
save(strcat(dir_save, 'frequencies_BD.mat'), 'frequencies_BD');
save(strcat(dir_save, 'frequencies_ABD.mat'), 'frequencies_ABD');
save(strcat(dir_save, 'frequencies_AD.mat'), 'frequencies_AD');



