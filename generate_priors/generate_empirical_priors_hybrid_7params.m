
parameters = {'Q0' 'gamma' '' 'tau' '' 'xi'  '' 'sgm0' '' 'eta' '' 'w_hyb'};   % is same param name as prev, write ''

parameters = parameters(~cellfun('isempty',parameters)); % ignores emptu entries

%% fit distributions
prior = [];
for p = 1:length(parameters)
    % set up settings
    prior(p).name = parameters{p};
    if ~isempty(strfind(parameters{p},'Q0'))
        prior(p).dist = 'normal';
        prior(p).scale = 1; 
        prior(p).pd = makedist('Normal','mu',5,'sigma',2);
    elseif ~isempty(strfind(parameters{p},'sgm0'))
        prior(p).dist = 'normal';
        prior(p).scale = 1; 
        prior(p).pd = makedist('Normal','mu',1.4,'sigma',1);
    elseif ~isempty(strfind(parameters{p},'gamma'))
        prior(p).dist = 'uniform';
        prior(p).scale = 1;
        prior(p).pd = makedist('Uniform','lower',0,'upper',10);
    elseif ~isempty(strfind(parameters{p},'tau'))
        prior(p).dist = 'uniform';
        prior(p).scale = 1;
        prior(p).pd = makedist('Uniform','lower',0,'upper',7);
    elseif ~isempty(strfind(parameters{p},'xi'))        
        prior(p).dist = 'uniform';
        prior(p).scale = 1;
        prior(p).pd = makedist('Uniform','lower',0,'upper',0.5);
    elseif ~isempty(strfind(parameters{p},'eta'))        
        prior(p).dist = 'uniform';
        prior(p).scale = 1;
        prior(p).pd = makedist('Uniform','lower',0,'upper',5);
    elseif ~isempty(strfind(parameters{p},'w_hyb'))        
        prior(p).dist = 'uniform';
        prior(p).scale = 1;
        prior(p).pd = makedist('Uniform','lower',0,'upper',1);
    end
    
end

%% save
save('participant_data/priors/hybrid_7params/empirical_prior.mat','prior')
