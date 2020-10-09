

for ID = 502:560

    data_fol = ('../../../data');
    
    HOLLY_cv_mod13(ID, data_fol)
    
    HOLLY_cv_mod15(ID, data_fol)
    
end

% mod 17: V=0 for all              -> softmax
% mod 18:   "        "          "  -> softmax + epsilon
% mod 19: V=0 for ABD; V=eta for C -> softmax
% mod 20:   "        "          "  -> softmax + epsilon

% mod 21: thompson                 -> softmax
% mod 22: thompson                 -> softmax + epsilon
% mod 23: thompson                 -> softmax + eta
% mod 24: thompson                 -> softmax + epsilon + eta

% mod 25: UCB                      -> argmax
% mod 26: UCB                      -> argmax + epsilon
% mod 27: UCB                      -> argmax + eta
% mod 28: UCB                      -> argmax + epsilon + eta
