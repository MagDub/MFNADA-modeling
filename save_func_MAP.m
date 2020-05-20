function save_func_MAP(ID, settings, results_dir, mEparams, mEmle, mEexitflag, mEsubj, mEMAP)

    mE.subj = mEsubj;
    mE.params = mEparams;
    mE.mle = mEmle;
    mE.map = mEMAP;
    mE.exitflag = mEexitflag;

    % save
    save([results_dir 'sim_res_' settings.desc '_' int2str(ID) '.mat'],'mE','settings')
    save([results_dir 'sim_res_' settings.desc '_' int2str(ID) '_results.mat'])
    
end

