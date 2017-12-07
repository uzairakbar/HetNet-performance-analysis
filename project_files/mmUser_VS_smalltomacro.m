clc;
clear all
close all
% -------------------------------------------------------------------------

area = 20*20;                  % the total area in squared meters

user_intensity = 1;          % the intensity of users in m^2
UHFM_intensity = 0.1;              % the BS intensity in m^2
ratio = 0:0.5:4;
mm_intensity = ratio*UHFM_intensity;
%deploy users in the area
[U, nU] = deployUsers(user_intensity, area);
Niterations = 1;
warning off;
threshold_dB = -20;
temp_cov_prob = 0;
temp_cov_prob_mm = 0;
coverage_probability = zeros(1, length(ratio));
coverage_probability_mmWave = zeros(1, length(ratio));

for p = 1 : length(ratio)
    [nBS_0, nBS_1, nBS_2, BSType, BSLocation] = deployBS(area, UHFM_intensity, ratio(p), 0);

    for j = 1:Niterations
        covered_users = 0;
        user_association;
        temp_cov_prob = temp_cov_prob + (covered_users/nU);
        temp_cov_prob_mm = temp_cov_prob_mm + (nU_BS_1/covered_users);
        
        %temp_rate = temp_rate + sum_rate;
    end
    
    coverage_probability(p) = (temp_cov_prob/Niterations);
    coverage_probability_mmWave(p) = (temp_cov_prob_mm/Niterations);
    
    temp_cov_prob=0;
    temp_cov_prob_mm=0;
    clc;
    display(strcat('Percent Completion:  ', strcat(num2str(ceil(100*p/length(ratio)))),'%'));
end
figure;
plot(ratio, coverage_probability_mmWave);
title('Fraction of users attended to small cells');
xlabel('l_s / l_u_h_f');
ylabel('Fraction of users of small cell');

figure;
plot(ratio, coverage_probability);
title('Fraction of users attended');
xlabel('l_s / l_u_h_f');
ylabel('Fraction of users');


display('Done');
