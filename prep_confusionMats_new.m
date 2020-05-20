function prep_confusionMats_new(n_per_dim)
    
    pb_sgm0 = [0.01,6];
    pb_Q0 = [1,10]; 
    pb_xi = [10^-8,0.5];  
    pb_eta = [0,5];

    param_names = {'sgm0', 'Q0','xi', '', 'eta', ''}; 

    grd = [];
    grd.dim{1} = linspace(pb_sgm0(1),pb_sgm0(2),n_per_dim);
    grd.dim{2} = linspace(pb_Q0(1),pb_Q0(2),n_per_dim);
    grd.dim{3} = linspace(pb_xi(1),pb_xi(2),n_per_dim);
    grd.dim{4} = linspace(pb_xi(1),pb_xi(2),n_per_dim);
    grd.dim{5} = linspace(pb_eta(1),pb_eta(2),n_per_dim);
    grd.dim{6} = linspace(pb_eta(1),pb_eta(2),n_per_dim);

    [x1, x2, x3, x4, x5, x6] = ndgrid(grd.dim{1},grd.dim{2},grd.dim{3},grd.dim{4},grd.dim{5},grd.dim{6});
    inp_params = single([x1(:) x2(:) x3(:) x4(:) x5(:) x6(:)]);
    clear x*

    saving_dir = strcat('D:\MaggiesFarm\modeling_28_02\simulation_data\mod12\', int2str(n_per_dim), 'perdim\');

    if exist(saving_dir) == 0
        mkdir(saving_dir)
    end

    save(strcat(saving_dir,'inp_params_mod12.mat'),'inp_params');
        
end