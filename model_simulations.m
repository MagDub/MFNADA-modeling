

%%%%%%% IGargmaxall %%%%%%%
Q = [5 4 3];
sgm = [3 1 2];
gamma = 15;

V = []; IG = []; n_samples = 5;

for i = 1:length(Q)
    pd_t = truncate(makedist('Normal','mu',Q(i),'sigma',sgm(i)),2,10);
    distrib_current = random(pd_t,[1 n_samples]);
    distrib_future = posterior_distrib_argmax(pd_t, Q(i), sgm(i), n_samples);
    IG(i) = KLDiv(distrib_current,distrib_future);
    V(i) = Q(i) + (gamma*IG(i));
end


%%%%%%% IG %%%%%%%

Q = [mean([5,4,3]) 4 3];
Q_argmax = [max([5,4,3]) 4 3];
sgm = [0.1 0.4 0.4];
S = 0.8;

% Short horizon, participant = 504
gamma = 7.93;
gamma_UCB = 0.8;
gamma_argmax = 0.4;

V = []; IG = []; n_samples = 200;
  
for i = 1:length(Q)
    pd_t = truncate(makedist('Normal','mu',Q(i),'sigma',sgm(i)),2,10);
    distrib_current = random(pd_t,[1 n_samples]);
    distrib_future = posterior_distrib(pd_t, Q(i), sgm(i), S, n_samples);
    IG(i) = KLDiv(distrib_current,distrib_future);
    V(i) = Q(i) + (gamma*IG(i));
    V_UCB(i) = Q(i) + (gamma_UCB*sgm(i));
    V_UCB_argmax(i) = Q_argmax(i) + (gamma_argmax*sgm(i));
end

disp('-------------SHORT HORIZON-------------')
V
V_UCB
V_UCB_argmax

% Long horizon horizon, participant = 504
gamma = 0.04;
gamma_UCB = 1.5;
gamma_argmax = 0.8;

V = []; IG = []; n_samples = 200;
  
for i = 1:length(Q)
    pd_t = truncate(makedist('Normal','mu',Q(i),'sigma',sgm(i)),2,10);
    distrib_current = random(pd_t,[1 n_samples]);
    distrib_future = posterior_distrib(pd_t, Q(i), sgm(i), S, n_samples);
    IG(i) = KLDiv(distrib_current,distrib_future);
    V(i) = Q(i) + (gamma*IG(i));
    V_UCB(i) = Q(i) + (gamma_UCB*sgm(i));
    V_UCB_argmax(i) = Q_argmax(i) + (gamma_argmax*sgm(i));
end

disp('-------------LONG HORIZON-------------')
V
V_UCB
V_UCB_argmax
