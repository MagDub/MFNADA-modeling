%addpath('D:\myDocuments\work\Projects\gen_funct\')
%clean()

%% settings
sim_name = 'sim_UCB';


%% get data
%sim_dir = 'D:\DATA\MaggiesFarm\modelling\sim\confusionMats\data\res\';
sim_dir = 'D:\MaggiesFarm\modeling_28_02\simulation_data\UCB\3params\3perdim\results\';
list = dir([sim_dir '*' sim_name '*_results.mat']);
n_junks = length(list);

%% loop through data and assemble
disp('aggregating data...')
out = [];

for i = 1:n_junks
    clear tmp tmp2
    if mod(i,500) == 0
        disp(i)
    end
    
    % load
    tmp = load([sim_dir list(i).name]);
    
    if i == 1   % instantiate matrices
        out.org = nan(n_junks,length(tmp.settings.params.param_names));
        out.fitted = nan(n_junks,length(tmp.mE.params));
    end
    
    % fill in fitted
    out.fitted(tmp.ID,:) = tmp.mE.params;
    
    % load and fill original
    tmp2 = load([sim_dir 'sim_' int2str(tmp.ID) '.mat']);
    out.org(tmp.ID,:) = tmp2.para_vals;
    
end

%% save
disp('saving')
%save(['D:\DATA\MaggiesFarm\modelling\sim\confusionMats\data\out_' sim_name '.mat'],'out')
save(['D:\MaggiesFarm\modeling_28_02\simulation_data\UCB\3params\3perdim\out_' sim_name '.mat'],'out')

%% plot
figure()
for i = 1:length(tmp.mE.params)
    subplot(2,2,i)
    plot(out.org(:,i),out.fitted(:,i),'.')
    xlabel('original param')
    ylabel('fitted param')
    rho = corr(out.org(:,i),out.fitted(:,i), 'rows','complete');
    title([tmp.settings.params.param_names{i} ': rho=' num2str(rho)])
end