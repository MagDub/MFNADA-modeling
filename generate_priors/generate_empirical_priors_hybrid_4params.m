
%% get prior data
for i = 1:60
    ID = i+500;
    load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\hybrid\4params_1Hor\results\fmincon\res_hybrid_',int2str(ID),'_results.mat'))
    mEmat(i) = mE;
end

parameters = {'gamma'  'tau'  'sgm0' 'w_hyb'};
parameters = parameters(~cellfun('isempty',parameters)); % ignores emptu entries

%% get parameters
params = reshape([mEmat(:).params],length(parameters),length(mEmat))';


%% fit distributions
prior = [];
for p = 1:length(parameters)
    % set up settings
    prior(p).name = parameters{p};
    if ~isempty(strfind(parameters{p},'gamma'))
        ucb_prior = load('D:\MaggiesFarm\modeling_28_02\participant_data\priors\UCB_2params\empirical_prior.mat');
        prior(p).dist = ucb_prior.prior(p).dist;
        prior(p).scale = ucb_prior.prior(p).scale;
        prior(p).pd = ucb_prior.prior(p).pd;
    elseif ~isempty(strfind(parameters{p},'tau'))
       ucb_prior = load('D:\MaggiesFarm\modeling_28_02\participant_data\priors\UCB_2params\empirical_prior.mat');
        prior(p).dist = ucb_prior.prior(p).dist;
        prior(p).scale = ucb_prior.prior(p).scale;
        prior(p).pd = ucb_prior.prior(p).pd;
    elseif ~isempty(strfind(parameters{p},'sgm0'))
        prior(p).dist = 'normal';
        prior(p).scale = 1;
        prior(p).pd = makedist('Normal','mu',1.4,'sigma',1);
    elseif ~isempty(strfind(parameters{p},'w'))
        prior(p).dist = 'uniform';
        prior(p).scale = 1;
        prior(p).pd = makedist('Uniform','lower',0,'upper',1);
    else
        error('unknown parameter')
    end
   
    % plot
    max_p = max(params(:,p).*prior(p).scale);
    figure(p)
    subplot(2,1,1)
    hist(params(:,p).*prior(p).scale,12)
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
save('participant_data/priors/hybrid_4params/empirical_prior.mat','prior')
