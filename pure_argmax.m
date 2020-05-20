function [mo] = pure_argmax(mo,idx_hor,idx_g,t)

% %% load parameters
% if length(mo.params.xi) > 1
%     gamma = mo.params.gamma(idx_hor);
% else
%     gamma = mo.params.gamma;
% end
% if isempty(gamma) || isnan(gamma) || isinf(abs(gamma))
%     error('gamma parameter not set properly for UCB')
% end

%% load in current values
Q = mo.mat.Q{idx_hor,idx_g}(:,t);
%sgm = mo.mat.sgm{idx_hor,idx_g}(:,t);

% %% compute values
% V = [];
% for i = 1:length(Q)
%     V(i) = Q(i); % + (gamma*sgm(i));
% end

%% calculate policy (only important for actual decision)
pi = mo.funs.decfun(Q,mo,idx_hor);

%% write to mo
mo.mat.V_UCB{idx_hor,idx_g}(:,t) = Q;
mo.mat.pi{idx_hor,idx_g}(:,t) = pi;




