function pi = basic_softmax(Vs,mo,idx_hor)
        
    %%data hygiene
    VsT = (Vs - max(Vs)); 

    %% softmax transformation 
    pi = (exp(VsT) / sum(exp(VsT)));
    
end


