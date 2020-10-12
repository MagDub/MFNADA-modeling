function [mo] = nullvalue_eta(mo,idx_hor,idx_g,t)

    if length(mo.params.eta) > 1
        eta = mo.params.eta(idx_hor);
    else
        eta = mo.params.eta;
    end

    % load in current values
    V = zeros(3,1);
    
    if isempty(mo.mat.appleA{idx_hor,idx_g}) || isempty(mo.mat.appleB{idx_hor,idx_g}) %disp('no A - BCD || no B - ACD')
        V(2) = eta; 
    elseif isempty(mo.mat.appleD{idx_hor,idx_g}) %disp('no D - ABC')
        V(3) = eta; 
    end

    % calculate policy (only important for actual decision)
    pi = mo.funs.decfun(V,mo,idx_hor);

    % write to mo
    mo.mat.pi{idx_hor,idx_g}(:,t) = pi;

end



