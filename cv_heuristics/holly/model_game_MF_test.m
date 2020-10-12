function [logL,mo] = model_game_MF_test(mo,data,idx_hor,idx_g,TLT)

    %% loop through trials of game
    for t = 1:size(data.alltrees,1)+1 %Changed / Added one because [Q0 Q]

        mo.mat.appleA{idx_hor,idx_g} = data.a;
        mo.mat.appleB{idx_hor,idx_g} = data.b;
        mo.mat.appleD{idx_hor,idx_g} = data.d;

        if t == 1 % plug in priors
            mo.mat.Q{idx_hor,idx_g}(:,t) = mo.params.Q0;
            mo.mat.sgm{idx_hor,idx_g}(:,t) = mo.params.sgm0(1);
        end

        if t <= size(data.alltrees,1)%+1 %Changed / Added one because [Q0 Q]
            mo = mo.funs.learningfun(mo,data,idx_hor,idx_g,t);
        else
            % calculate policy
            if strcmp(func2str(mo.funs.valuefun),'mvnorm_Thompson_lookup')
                mo = mo.funs.valuefun(mo,idx_hor,idx_g,t,TLT);
            else
                mo = mo.funs.valuefun(mo,idx_hor,idx_g,t);
            end

            % add lapse if needed
            if ~isempty(mo.params.xi)
                mo = lapse(mo,idx_hor,idx_g,t);
            end

        end
    end

    %% calculate log likelihood for first free choice (t==6)
    idx_chosen = data.chosen;
    
    if data.unshown_tree == 1
        tree_vec = [2, 3, 4];
    elseif data.unshown_tree == 2
        tree_vec = [1, 3, 4];
    elseif data.unshown_tree == 3
        tree_vec = [1, 2, 4];
    elseif data.unshown_tree == 4
        tree_vec = [1, 2, 3];
    end

    idx_chosen_tmp = find(tree_vec == idx_chosen); 
        
    tmp_mo_pi = nanmean(mo.mat.pi{idx_hor,idx_g},2); %the policy is not always in the last column
        
    pi_chos = tmp_mo_pi(idx_chosen_tmp); 
    
    if pi_chos == 1
        pi_chos = 1-2*realmin;
    elseif pi_chos == 0
        pi_chos = realmin;
    end

    logL = log(pi_chos);
        
end