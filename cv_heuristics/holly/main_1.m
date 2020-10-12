
for ID = 502:560

    data_fol = ('../../../data');
    
    HOLLY_cv_mod13(ID, data_fol)
    
end

%           mod 25: UCB                      -> argmax
%           mod 26: UCB                      -> argmax + epsilon
%           mod 27: UCB                      -> argmax + eta
%           mod 28: UCB                      -> argmax + epsilon + eta

% OKKK      mod 17: V=0 for all              -> softmax
% OKKK      mod 18:   "        "          "  -> softmax + epsilon
% OKKK      mod 19: V=0 for ABD; V=eta for C -> softmax
% OKKK      mod 20:   "        "          "  -> softmax + epsilon

% OKKK      mod 21: thompson                 -> softmax
% OKKK      mod 22: thompson                 -> softmax + epsilon
% OKKK      mod 23: thompson                 -> softmax + eta
% OKKK      mod 24: thompson                 -> softmax + epsilon + eta