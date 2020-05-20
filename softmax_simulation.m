
figure()

for tau=0.1:0.1:2%:1:7
    

    V_1 = 5;

    for V_2 = 1:10

    V_3 = 5;
    V_4 = 2; %[1:10];

        %% data hygiene

        VsT1 = exp(V_1 ./ tau); % remove max to avoid numerical overflow (cf Friston spm_softmax)
        VsT2 = exp(V_2 ./ tau);
        VsT3 = exp(V_3 ./ tau);
        VsT4 = exp(V_4 ./ tau);

        diff_V1_V2(V_2) = V_1 - V_2;

        %% softmax transformation 
        pi(V_2) = (VsT1 / (VsT1+VsT2+VsT3+VsT4));

    end

plot(diff_V1_V2, pi); hold on;
end
title('tau = [0.1,7] - V(apple A) = 5, V(appleB) = 1:10, V(appleC) = 5, V(appleD) = 2')
