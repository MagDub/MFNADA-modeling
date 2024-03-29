function mo = initialise_model_MF_S0fixed_sgm0fixed(settings)


%% set up model structure
mo = [];

%% set up parameters
mo.params.tau           = [];   % decision temperature
mo.params.xi            = []; %0.01*ones(settings.task.N_games,1);   % lapse rate
mo.params.gamma         = [];   % variance scaling factor for UCB
mo.params.S0            = 0.8*ones(settings.task.N_games,1); % prior draw std (set up, so that learning can be implemented
mo.params.sgm0          = 1.5; % prior mean std (set up, so that learning can be implemented
mo.params.Q0            = []; %5*ones(settings.task.N_games,1); % prior mean (set up, so that learning can be implemented

%% set up matrices
mo.mat.Q(1:settings.task.N_hor,1:settings.task.Ngames_per_hor) = {nan(settings.task.N_trees,6)};   % Q-value(mean) - 4 trees, 6 draws (5 passive, 1 active)
mo.mat.sgm(1:settings.task.N_hor,1:settings.task.Ngames_per_hor) = {nan(settings.task.N_trees,6)};  % sigma: standard deviation
mo.mat.pi(1:settings.task.N_hor,1:settings.task.Ngames_per_hor) = {nan(settings.task.N_trees,6)};   % policy
mo.mat.k(1:settings.task.N_hor,1:settings.task.Ngames_per_hor) = {nan(6,1)};    % Kalman Gain
mo.mat.da(1:settings.task.N_hor,1:settings.task.Ngames_per_hor) = {nan(6,1)};    % prediction error

%% set up functions
mo.funs.decfun          = [];           % decision function default: softmax (only when UCB)
mo.funs.valuefun        = [];           % UCB, etc
mo.funs.priorfun        = [];           % how priors are set up
mo.funs.learningfun     = @kalman_filt; % learning model

%% other fun things
mo.warnings = {};