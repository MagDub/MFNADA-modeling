function [mo] = heuristics_noveltybonus(mo,idx_hor,idx_g,t)

    % load in current values
    Q = mo.mat.Q{idx_hor,idx_g}(:,t);
    
    % load parameters
    if length(mo.params.eta) > 1
        eta = mo.params.eta(idx_hor);
    else
        eta = mo.params.eta;
    end
    
    % compute values
    V = Q;
    
    if isempty(mo.mat.appleA{idx_hor,idx_g}) || isempty(mo.mat.appleB{idx_hor,idx_g})
        %disp('no A - BCD || no B - ACD')
        V(2) = Q(2) + eta; %novelty bonus on tree C
    elseif isempty(mo.mat.appleD{idx_hor,idx_g})
        %disp('no D - ABC')
        V(3) = Q(3) + eta; %novelty bonus on tree C
    end
    
    % calculate policy (only important for actual decision)
    pi = mo.funs.decfun(V,mo,idx_hor);

    % write to mo
    mo.mat.pi{idx_hor,idx_g}(:,t) = pi;

end



