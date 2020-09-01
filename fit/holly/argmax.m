function pi = argmax(Vs,mo,idx_hor)
        
    [~, ind] = max(Vs);
    
    pi = zeros(size(Vs));

    pi(ind) = 1; 
    
        
end


