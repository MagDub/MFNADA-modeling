function [mo] = mvnorm_Thompson_softmax(mo,idx_hor,idx_g,t)

    % load parameters
    A = mo.mat.A;

    % load in current values
    Q = mo.mat.Q{idx_hor,idx_g}(:,t);
    sgm = mo.mat.sgm{idx_hor,idx_g}(:,t);
    n_opts = length(Q);

    % Mean vector: differences of means
    dQ = [];
    for i = 1:n_opts
        dQ(:,i) = A(:,:,i)*Q;
    end

    % covariance matrix
    msgm = [];
    for i = 1:n_opts
        msgm(:,:,i) = A(:,:,i)*diag(sgm.^2)*A(:,:,i)';
    end

    % compute multivariat normal
    y = [];
    for i = 1:n_opts
        y(i) = mvncdf([0 0],-dQ(:,i)',msgm(:,:,i));  
    end
    pi_tmp = y./sum(y);
    
    % pass it through softmax
    pi = mo.funs.decfun(pi_tmp,mo,idx_hor);

    % write to mo
    mo.mat.pi{idx_hor,idx_g}(:,t) = pi;

end