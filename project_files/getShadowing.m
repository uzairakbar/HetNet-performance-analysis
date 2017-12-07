function [shadow_db] = getShadowing(number_of_points, tier)
%This funciton returns lognormal shadowing points for the specified tier.
%The number of points is equal to the first argument.
%Values obtianed from "Self-adaptive Power Control Mechanism in
%Device-to-Device Enabled Multi-tier HetNets; An Optimization Approach" By
%Syed Ahsan Raza Naqvi
%mean  =  0
%standard deviation  =  4  (UHF)  or  5.2  (mmWave)


MU = 0;
if tier == 0
    SIGMA = 4;
elseif tier == 1
    SIGMA = 5.2;
elseif tier == 2
    SIGMA = 4;
end
shadow_db = MU + SIGMA.*randn( [1 number_of_points]);

end