clear all; close all; clc

%% get prior data

load('./results/20151107090817_mE_nonlinCS_1csk_1cs.mat')

%% get parameters
params = reshape([mE(:).params],length(parameters),length(mE))';

%% fit distributions
prior = [];
for p = 1:length(parameters)
    % set up settings
    prior(p).name = parameters{p};
    if ~isempty(strfind(parameters{p},'xi'))
        prior(p).dist = 'beta';
        prior(p).scale = 1;
    elseif ~isempty(strfind(parameters{p},'cs')) && isempty(strfind(parameters{p},'_'))
        prior(p).dist = 'beta';
        prior(p).scale = -1/10;        
    elseif ~isempty(strfind(parameters{p},'cs_p'))        
        prior(p).dist = 'beta';
        prior(p).scale = 1/25;
    elseif ~isempty(strfind(parameters{p},'cs_k'))        
        prior(p).dist = 'beta';
        prior(p).scale = 1/500;
    elseif  ~isempty(strfind(parameters{p},'tau'))   
        prior(p).dist = 'gamma';
        prior(p).scale = 1;
    else
        error('unknown parameter')
    end
    
    % fit distribution
    prior(p).pd = fitdist(params(:,p).*prior(p).scale,prior(p).dist);
    
    % plot
    max_p = max(params(:,p).*prior(p).scale);
    figure(p)
    subplot(2,1,1)
    hist(params(:,p).*prior(p).scale)
    title(prior(p).name)
    
    subplot(2,1,2)
    tmp = []; n = 1;
    for i =0.0001:max_p/100:max_p
        tmp(n) = prior(p).pd.pdf(i);
        n=n+1;
    end
    plot(0.0001:max_p/100:max_p,tmp,'m','LineWidth',2)
    
end

%% save
save('empirical_prior.mat','prior')