



% testing marginal likelihood and AIC
for i = 1
    
    fit_ucb_h6 = load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\3params\results\hor6\fmincon\res_UCB_50',int2str(i),'_results.mat'));
    fit_thomp_h6 = load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson\3params\results\hor6\fmincon\res_thompson_50',int2str(i),'_results.mat'));
    
    fit_ucb_h11 = load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\UCB\3params\results\hor11\fmincon\res_UCB_50',int2str(i),'_results.mat'));
    fit_thomp_h11 = load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson\3params\results\hor11\fmincon\res_thompson_50',int2str(i),'_results.mat'));

    % UCB Hor 6
    K = 3;
    h = log(det(fit_ucb_h6.He)); 
    lme_h6(1,i) = fit_ucb_h6.mEmle + 0.5*(K*log(2*pi) - h); % the posterior is the likelihood in the case where there is no prior
    AIC_h6(1,i) = -2.*fit_ucb_h6.mEmle + 2* K;
    
    % UCB Hor 11
    K = 3;
    h = log(det(fit_ucb_h11.He)); 
    lme_h11(1,i) = fit_ucb_h11.mEmle + 0.5*(K*log(2*pi) - h); % the posterior is the likelihood in the case where there is no prior
    AIC_h11(1,i) = -2.*fit_ucb_h11.mEmle + 2* K;

    % Thompson Hor 6
    K = 3;
    h = log(det(fit_thomp_h6.He));
    lme_h6(2,i) = fit_thomp_h6.mEmle + 0.5*(K*log(2*pi) - h);
    AIC_h6(2,i) = -2.*fit_thomp_h6.mEmle + 2* K; 
    
    % Thompson Hor 11
    K = 3;
    h = log(det(fit_thomp_h11.He));
    lme_h11(2,i) = fit_thomp_h11.mEmle + 0.5*(K*log(2*pi) - h);
    AIC_h11(2,i) = -2.*fit_thomp_h11.mEmle + 2* K; 
    
end
