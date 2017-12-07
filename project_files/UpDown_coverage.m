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

Niterations = 10;
warning off;
threshold_dB = -30;
uplink_threshold = -30;
temp_cov_prob_down = 0;
temp_cov_prob_mm_down = 0;
coverage_probability_down = zeros(1, length(ratio));
coverage_probability_mmWave_down = zeros(1, length(ratio));

temp_cov_prob_up = 0;
temp_cov_prob_mm_up = 0;
coverage_probability_up = zeros(1, length(ratio));
coverage_probability_mmWave_up = zeros(1, length(ratio));

for p = 1 : length(ratio)
   

    for j = 1:Niterations
        [nBS_0, nBS_1, nBS_2, BSType, BSLocation] = deployBS(area, UHFM_intensity, ratio(p), 0);
        [U, nU] = deployUsers(user_intensity, area);
        covered_users = 0;
        % DOWNLINK
        user_association;
        temp_cov_prob_down = temp_cov_prob_down + (covered_users/nU);
        temp_cov_prob_mm_down = temp_cov_prob_mm_down + (nU_BS_1/covered_users);
        % DOWNLINK
        covered_users = 0;
        % UPLINK
        uplink_user_association;
        temp_cov_prob_up = temp_cov_prob_up + (covered_users/nU);
        temp_cov_prob_mm_up = temp_cov_prob_mm_up + (nU_BS_1/covered_users);
        % UPLINK
        clc;
        display(strcat('Percent Completion:  ', strcat(num2str(ceil(100*p/length(ratio)))),'%'));
        display(strcat('Percent Completion:  ', strcat(num2str(ceil(100*j/Niterations))),'%'));

    end
    % DOWNLINK
    coverage_probability_down(p) = (temp_cov_prob_down/Niterations);
    coverage_probability_mmWave_down(p) = (temp_cov_prob_mm_down/Niterations);
    temp_cov_prob_down=0;
    temp_cov_prob_mm_down=0;
    % DOWNLINK
    % UPLINK
    coverage_probability_up(p) = (temp_cov_prob_up/Niterations);
    coverage_probability_mmWave_up(p) = (temp_cov_prob_mm_up/Niterations);
    temp_cov_prob_up=0;
    temp_cov_prob_mm_up=0;
    % UPLINK
   
end
figure;
plot(ratio, coverage_probability_mmWave_down, 'r');
title('Fraction of users attended to small cells ');
xlabel('l_s / l_u_h_f');
ylabel('Fraction of users of small cell ');
hold on
plot(ratio, coverage_probability_mmWave_up, 'g');
legend('DOWNLINK', 'UPLINK');

% figure;
% plot(ratio, coverage_probability);
% title('Fraction of users attended');
% xlabel('l_s / l_u_h_f');
% ylabel('Fraction of users');





display('Done');
