clc;
clear all
close all
% -------------------------------------------------------------------------

area = 20*20;                  % the total area in squared meters

user_intensity = 1;          % the intensity of users in m^2
UHFM_intensity = 0.1;              % the BS intensity in m^2
ratio = 0:1:4;
mm_intensity = ratio*UHFM_intensity;
%deploy users in the area
[U, nU] = deployUsers(user_intensity, area);
Niterations = 10;
warning off;
threshold_dB = -30;
temp_cov_prob = 0;
temp_cov_prob_mm = 0;
temp_sum_rate = 0;
coverage_probability = zeros(1, length(ratio));
coverage_probability_mmWave = zeros(1, length(ratio));
sum_rate_val = zeros(1, length(ratio));

for p = 1 : length(ratio)
    

    for j = 1:Niterations
        [nBS_0, nBS_1, nBS_2, BSType, BSLocation] = deployBS(area, UHFM_intensity, ratio(p), 1);
        [U, nU] = deployUsers(user_intensity, area);
        covered_users = 0;
        user_association;
        temp_cov_prob = temp_cov_prob + (covered_users/nU);
        temp_cov_prob_mm = temp_cov_prob_mm + (nU_BS_1/covered_users);
        temp_sum_rate = temp_sum_rate + sum_rate;
        clc;
    display(strcat('Percent Completion:  ', strcat(num2str(ceil(100*p/length(ratio)))),'%'));
     display(strcat('Percent Completion:  ', strcat(num2str(ceil(100*j/Niterations))),'%'));

    end
    coverage_probability(p) = (temp_cov_prob/Niterations);
    coverage_probability_mmWave(p) = (temp_cov_prob_mm/Niterations);
    sum_rate_val(p) = temp_sum_rate/Niterations;
    temp_cov_prob=0;
    temp_cov_prob_mm=0;
    temp_sum_rate=0;
    
    
end
figure;
plot(ratio, sum_rate_val);
title('sum rate');
xlabel('l_s / l_u_h_f');
ylabel('sum rate');
% plot(ratio, coverage_probability_mmWave);
% title('Fraction of users attended to small cells');
% xlabel('l_s / l_u_h_f');
% ylabel('Fraction of users of small cell');

% figure;
% plot(ratio, coverage_probability);
% title('Fraction of users attended');
% xlabel('l_s / l_u_h_f');
% ylabel('Fraction of users');





display('Done');
