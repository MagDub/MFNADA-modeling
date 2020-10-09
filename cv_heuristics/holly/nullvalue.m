function [mo] = nullvalue(mo,idx_hor,idx_g,t)

    % load in current values
    V = zeros(3,1);

    % calculate policy (only important for actual decision)
    pi = mo.funs.decfun(V,mo,idx_hor);

    % write to mo
    mo.mat.pi{idx_hor,idx_g}(:,t) = pi;

end



