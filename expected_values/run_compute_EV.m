% 
% 

[EV_SH_mat_AB,EV_LH_mat_AB] = compute_EV_AB();

[EV_SH_mat_AD,EV_LH_mat_AD] = compute_EV_AD();

[EV_SH_mat_BD,EV_LH_mat_BD] = compute_EV_BD();

[EV_SH_mat_ABD,EV_LH_mat_ABD] = compute_EV_ABD();

[EV_SH_mat_all,EV_LH_mat_all] = compute_EV_all();

EV_SH_mat_AB(6)=nan;
EV_LH_mat_AB(6)=nan;

EV_SH_mat_AD(6)=nan;
EV_LH_mat_AD(6)=nan;

EV_SH_mat_BD(6)=nan;
EV_LH_mat_BD(6)=nan;

EV_SH_mat_ABD(6)=nan;
EV_LH_mat_ABD(6)=nan;

EV_SH_mat_all(6)=nan;
EV_LH_mat_all(6)=nan;

numel_n = 59;

nanmean(EV_SH_mat_all)
nanmean(EV_LH_mat_all)

