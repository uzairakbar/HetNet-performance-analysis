clc;
clear all
close all
% -------------------------------------------------------------------------

area = 20*20;                  % the total area in squared meters

user_intensity = 1;          % the intensity of users in m^2
UHFM_intensity = 0.1;              % the BS intensity in m^2
ratio = 1;
mm_intensity = ratio*UHFM_intensity;
%deploy users in the area
[U, nU] = deployUsers(user_intensity, area);
[nBS_0, nBS_1, nBS_2, BSType, BSLocation] = deployBS(area, UHFM_intensity, ratio, 0);
Niterations = 50;
warning off;
t = -40:10:10;
temp_cov_prob=0;
temp_cov_prob_mm=0;
temp_rate = 0;
coverage_probability = zeros(1, length(t));
coverage_probability_mmWave = zeros(1, length(t));

for p = 1 : length(t)
    
    threshold_dB = t(p);
    
    for j = 1:Niterations
        covered_users = 0;
        user_association_max_biased_Pr;
        temp_cov_prob = temp_cov_prob + (covered_users/nU);
        temp_cov_prob_mm = temp_cov_prob_mm + (nU_BS_1/covered_users);
        temp_rate = temp_rate + sum_rate;
    end
    coverage_probability(p) = (temp_cov_prob/Niterations);
    coverage_probability_mmWave(p) = (temp_cov_prob_mm/Niterations);
    R(p) = temp_rate/Niterations;
    temp_cov_prob=0;
    temp_cov_prob_mm=0;
    temp_rate=0;
    clc;
    display(strcat('Percent Completion:  ', strcat(num2str(ceil(100*p/length(t)))),'%'));
end

figure;
plot(t, coverage_probability);
title('Coverage Probability based on maximum biased received power');
xlabel('Threshold power in dB -->');
ylabel('Coverage Probability -->');

figure;
plot(t, R);
title('Sum rates ');
xlabel('Threshold power in dB -->');
ylabel('Rate -->');

display('Done');
