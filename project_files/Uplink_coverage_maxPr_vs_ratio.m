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

Niterations = 100;
warning off;
threshold_dB = -30;
uplink_threshold = -40;
temp_cov_prob = 0;
temp_cov_prob_mm = 0;
coverage_probability = zeros(1, length(ratio));
coverage_probability_mmWave = zeros(1, length(ratio));

for p = 1 : length(ratio)
   

    for j = 1:Niterations
        [nBS_0, nBS_1, nBS_2, BSType, BSLocation] = deployBS(area, UHFM_intensity, ratio(p), 0);
        [U, nU] = deployUsers(user_intensity, area);
        covered_users = 0;
        uplink_user_association;
        temp_cov_prob = temp_cov_prob + (covered_users/nU);
        temp_cov_prob_mm = temp_cov_prob_mm + (nU_BS_1/nU);
             clc;
    display(strcat('Percent Completion:  ', strcat(num2str(ceil(100*p/length(ratio)))),'%'));
     display(strcat('Percent Completion:  ', strcat(num2str(ceil(100*j/Niterations))),'%'));

    end
    coverage_probability(p) = (temp_cov_prob/Niterations);
    coverage_probability_mmWave(p) = (temp_cov_prob_mm/Niterations);
    temp_cov_prob=0;
    temp_cov_prob_mm=0;
   
end
hold on;
plot(ratio, coverage_probability_mmWave, 'r');
save(strcat('X:\FYP\Basic_Model_new\T_', strcat(num2str(abs(uplink_threshold)),'.mat')), 'coverage_probability_mmWave' );
title('Fraction of total users attended to small cells (Uplink)');
xlabel('l_s / l_u_h_f');
ylabel('Fraction of total users of small cell (Uplink)');


display('Done');
