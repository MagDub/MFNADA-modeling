function [nMAP,nlogL,params_prior] = IST_MAP(subj,params,parameters,type)

%% load priors and define densities
load('empirical_prior.mat');
p_params = {prior(:).name}; params_prior = [];
for p = 1:length(parameters)
    % get equivalend
    idx = find(strcmp(p_params,parameters{p}));
    if isempty(idx)
        idx = find(cell2mat(strfind(p_params,parameters{p}(1:end-1))));
    end
    if isempty(idx) || numel(idx)>1
        error(['error when looking for prior of ' parameters{p}])
    end
    
    % get estimate
    params_prior(p) = prior(idx).pd.pdf(params(p).* prior(idx).scale);
end

% get rid of inf
params_prior(find(params_prior==inf)) = realmax;

%% get logL
[nlogL, mo1, mo2, logL] = model_optimIST(subj,params,parameters,type);

%% merge to get MAP
MAP = nlogL*-1 + sum(log(params_prior));
nMAP = -1*MAP;