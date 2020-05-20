function save_func(ID, settings, results_dir, mEparams, mEmle, mEexitflag, mEsubj)

    mE.subj = mEsubj;
    mE.params = mEparams;
    mE.mle = mEmle;
    mE.exitflag = mEexitflag;

    % save
    save([results_dir 'sim_res_' settings.desc '_' int2str(ID) '.mat'],'mE','settings')
    save([results_dir 'sim_res_' settings.desc '_' int2str(ID) '_results.mat'])
    
end

