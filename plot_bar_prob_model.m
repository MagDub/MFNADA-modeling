
g_ = [-g(:,1) g(:,2) -g(:,3) g(:,4)];
barh(g_)
xlabel('Posterior belief that model k generated the data for the i-th subject')
ylabel('participant')
legend('Thompson', 'UCB', 'UCB mean', 'UCB arg max')
yticks([1:60])
%yticks(a)
yticklabels(a)