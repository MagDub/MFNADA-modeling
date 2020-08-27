function [nLogL, mo, logL] = modelMF_S0fixed_sgm0fixed_crossval_eta(param_val,param_names,sID,settings,data,gameIDs, game_ini, game_fin)

    %% fill in missing input arguments
    if nargin < 5   % load data
        load(['./data/' int2str(sID) '_aggdata.mat'])
    end


    %% initialise model
    mo = initialise_model_MF_S0fixed_sgm0fixed_eta(settings);

    %% fill in parameters, model-funs etc
    mo = prep_model_MF(mo,settings,param_val,param_names);

    %% fill in priors if not constant
    if ~isempty(mo.funs.priorfun)
        mo = mo.funs.priorfun(mo);
    end

    %% loop through trials (and conditions)
    logL = [];
    for c = 1:settings.task.N_hor
        for g = game_ini:game_fin
    %        disp([int2str(c) '_' int2str(g)])

            % to speed things up: only calculate if same game is not already
            % played
            g_idx = find(gameIDs(c,:)==gameIDs(c,g),1,'first');

            % data
            clear tmp_dat
            tmp_dat = data(c,g);

            % compute model game
            [logL(c,g),mo] = model_game_MF(mo,tmp_dat,c,g,settings.opts.TLT);
        end
    end

    % replace inf values
    logL(isinf(logL)) = -realmax;
    
    %% calculate LogLikelihood
    nLogL = sum(sum(logL)) * -1;
    
    nLogL(isinf(nLogL)) = realmax/(10^10);
end