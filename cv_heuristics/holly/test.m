
N_trees = 3;

% A matrix (to be computed to calculate difference scores for Thompson)
A = zeros(N_trees-1,N_trees,N_trees);
for i = 1:N_trees
    A(:,i,i) = 1;
    tmp = 1;
    for ii = 1:N_trees
        if i ~= ii
            A(tmp,ii,i) = -1;
            tmp = tmp + 1;
        end
    end
end

Q = [5, 3, 6]';
sgm = [0.6, 1.2, 1]';
n_opts = length(Q);

% Mean vector: differences of means

%  | q1-q2  q2-q1  q3-q1 |
%  | q1-q3  q2-q3  q3-q2 |

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
pi = y./sum(y);

x1 = -3:0.2:3;
x2 = -3:0.2:3;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];

for b=1:3
    subplot(1,3,b);
    mu_ = -dQ(:,b)';
    sigma_ = msgm(:,:,b);
    y_cdf = mvncdf(X, mu_, sigma_);
    y_cdf = reshape(y_cdf,length(x2),length(x1));
    surf(x1,x2,y_cdf); hold on;
    plot3([0,0],[0,0],[0,1], 'k', 'LineWidth', 2);
end


% pass through a softmax
tau = 1;
Vs = pi;
VsT = (Vs - max(Vs)) ./ tau; % remove max to avoid numerical overflow (cf Friston spm_softmax)
pi_soft = (exp(VsT) / sum(exp(VsT)));

disp(pi)
disp(pi_soft)