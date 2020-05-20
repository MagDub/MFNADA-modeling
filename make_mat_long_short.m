function param_mat = make_mat_long_short(all_parameters, placebo_ind, amisulpride_ind, propanolol_ind, col1, col2)

param_mat_short = nan(20,3);
param_mat_long = nan(20,3); 

param_mat_short(1:size(all_parameters(placebo_ind,col1),1),1) = all_parameters(placebo_ind,col1);
param_mat_short(1:size(all_parameters(amisulpride_ind,col1),1),2) = all_parameters(amisulpride_ind,col1);
param_mat_short(1:size(all_parameters(propanolol_ind,col1),1),3) = all_parameters(propanolol_ind,col1);

param_mat_long(1:size(all_parameters(placebo_ind,col2),1),1) = all_parameters(placebo_ind,col2);
param_mat_long(1:size(all_parameters(amisulpride_ind,col2),1),2) = all_parameters(amisulpride_ind,col2);
param_mat_long(1:size(all_parameters(propanolol_ind,col2),1),3) = all_parameters(propanolol_ind,col2);

param_mat = [param_mat_short param_mat_long];

end

