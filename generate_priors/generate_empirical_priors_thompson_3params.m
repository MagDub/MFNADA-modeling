


parameters = {'sgm0' '' 'Q0' 'eta'  ''};   % is same param name as prev, write ''

parameters = parameters(~cellfun('isempty',parameters)); % ignores emptu entries


%% fit distributions
prior = [];
for p = 1:length(parameters)
    % set up settings
    prior(p).name = parameters{p};
    if ~isempty(strfind(parameters{p},'sgm0'))
        prior(p).dist = 'normal';
        prior(p).scale = 1;
        prior(p).pd = makedist('Normal','mu',1.4,'sigma',1);
    elseif ~isempty(strfind(parameters{p},'Q0'))
        prior(p).dist = 'normal';
        prior(p).scale = 1; 
        prior(p).pd = makedist('Normal','mu',5,'sigma',2);
    elseif ~isempty(strfind(parameters{p},'eta'))        
        prior(p).dist = 'uniform';
        prior(p).scale = 1;
        prior(p).pd = makedist('Uniform','lower',0,'upper',5);
    else
        error('unknown parameter')
    end
    
end

%% save
save('D:\MaggiesFarm\modeling_28_02\participant_data\priors\thompson_3params_xi_eta_uni\empirical_prior.mat','prior')
