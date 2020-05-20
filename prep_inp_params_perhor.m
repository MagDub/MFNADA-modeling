function prep_inp_params_perhor(n_per_dim,algo, n_param, param_bounds)


    %% settings
    n_junks = 1500;
    
    if strcmp (algo, 'thompson')
        %% create grid for Thompson
        if n_param == 4

            param_names = {'sgm0', 'sgm0', 'Q0','xi', 'xi', 'eta', 'eta'};

            grd = [];
            grd.dim{1} = linspace(param_bounds.sgm0(1),param_bounds.sgm0(2),n_per_dim);
            grd.dim{2} = linspace(param_bounds.sgm0(1),param_bounds.sgm0(2),n_per_dim);
            grd.dim{3} = linspace(param_bounds.Q0(1),param_bounds.Q0(2),n_per_dim);
            grd.dim{4} = linspace(param_bounds.xi(1),param_bounds.xi(2),n_per_dim);
            grd.dim{5} = linspace(param_bounds.xi(1),param_bounds.xi(2),n_per_dim);
            grd.dim{6} = linspace(param_bounds.eta(1),param_bounds.eta(2),n_per_dim);
            grd.dim{7} = linspace(param_bounds.eta(1),param_bounds.eta(2),n_per_dim);

            [x1, x2, x3, x4, x5, x6, x7] = ndgrid(grd.dim{1},grd.dim{2},grd.dim{3},grd.dim{4},grd.dim{5},grd.dim{6},grd.dim{7});
            inp_params = single([x1(:) x2(:) x3(:) x4(:) x5(:) x6(:) x7(:)]);
            clear x*
            
        end
        
        saving_dir = strcat('D:\MaggiesFarm\modeling_28_02\simulation_data\thompson\parhor\', int2str(n_per_dim), 'perdim\');
        
        if exist(saving_dir) == 0
            mkdir(saving_dir)
        end
        
        save(strcat(saving_dir,'inp_params_thompson.mat'),'inp_params');
        
    end
end