function [output_summed] = posterior_distrib_argmax(pd_t, Q, sgm, n_samples)

app_size = 2:10;

for i = 1:size(app_size,2)
    [Q_future, sgm_future] = argmax_indiv(Q, sgm, app_size(i));
    p_apple_given_current(i) = pdf(pd_t,app_size(i));
    prob_distrib(i,:) = normrnd(Q_future,sgm_future,[1,n_samples]);
end

output = p_apple_given_current' .* prob_distrib; 

output_summed = sum(output,1);

end

