function [mo] = heuristics(mo,idx_hor,idx_g,t)

    % load in current values
    Q = mo.mat.Q{idx_hor,idx_g}(:,t);
    
    % compute values
    V = Q;
    
    % calculate policy (only important for actual decision)
    pi = mo.funs.decfun(V,mo,idx_hor);

    % write to mo
    mo.mat.pi{idx_hor,idx_g}(:,t) = pi;

end



