clc;
clear all
close all
% -------------------------------------------------------------------------

area = 20*20;                  % the total area in squared meters

user_intensity = 1;          % the intensity of users in m^2
UHFM_intensity = 0.1;              % the BS intensity in m^2
ratio = 4;
mm_intensity = ratio*UHFM_intensity;
%deploy users in the area
[U, nU] = deployUsers(user_intensity, area);
UHF_to_mm = 0:0.2:1;
Niterations = 1;
warning off;
threshold_dB = -30;
temp_cov_prob_uhf_small = 0;
temp_cov_prob_mm = 0;
temp_sum_rate = 0;
coverage_probability_uhf_small = zeros(1, length(ratio));
coverage_probability_mmWave = zeros(1, length(ratio));
sum_rate_val = zeros(1, length(ratio));

for p = 1 : length(UHF_to_mm)
    

    for j = 1:Niterations
        [nBS_0, nBS_1, nBS_2, BSType, BSLocation] = deployBS(area, UHFM_intensity, ratio, UHF_to_mm(p));
        [U, nU] = deployUsers(user_intensity, area);
        covered_users = 0;
        user_association;
        temp_cov_prob_uhf_small = temp_cov_prob_uhf_small + (nU_BS_2/covered_users);
        temp_cov_prob_mm = temp_cov_prob_mm + (nU_BS_1/covered_users);
        temp_sum_rate = temp_sum_rate + sum_rate;
        clc;
    display(strcat('Percent Completion:  ', strcat(num2str(ceil(100*p/length(UHF_to_mm)))),'%'));
     display(strcat('Percent Completion:  ', strcat(num2str(ceil(100*j/Niterations))),'%'));

    end
    coverage_probability_uhf_small(p) = (temp_cov_prob_uhf_small/Niterations);
    coverage_probability_mmWave(p) = (temp_cov_prob_mm/Niterations);
    sum_rate_val(p) = temp_sum_rate/Niterations;
    temp_cov_prob_uhf_small=0;
    temp_cov_prob_mm=0;
    temp_sum_rate=0;
    
    
end
figure;
plot(UHF_to_mm, sum_rate_val);
title('sum rate');
xlabel('All mm  ----->  All UHF');
ylabel('sum rate');
figure;
plot(UHF_to_mm, coverage_probability_mmWave);
hold on;
plot(UHF_to_mm, coverage_probability_uhf_small, 'g');
title('Fraction of users attended');
xlabel('Fraction of UHF cells');
ylabel('Fraction of users');
legend('mmWave small cell','UHF small cell');





display('Done');
