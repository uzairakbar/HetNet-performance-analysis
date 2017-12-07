clc;
clear all
close all
% -------------------------------------------------------------------------
filenameR = 'R';
filenameI = 'itera_num';
pre = 'X:\FYP\Basic_Model_new\';
locationR = strcat(pre,strcat(filenameR, '.mat'));
locationI = strcat(pre,strcat(filenameI, '.mat'));

load(locationR);
load(locationI);
prev_tot = R.*itera_num;


area = 20*20;                  % the total area in squared meters

user_intensity = 1;          % the intensity of users in m^2
UHFM_intensity = 0.1;              % the BS intensity in m^2
ratio = 0:10;
mm_intensity = ratio*UHFM_intensity;
%deploy users in the area
[U, nU] = deployUsers(user_intensity, area);
Niterations = 5;
warning off;
threshold_dB = -40;
temp_cov_prob = 0;
temp_cov_prob_mm = 0;
temp_rate = 0;
coverage_probability = zeros(1, length(ratio));
coverage_probability_mmWave = zeros(1, length(ratio));

for p = 1 : length(ratio)
    [nBS_0, nBS_1, nBS_2, BSType, BSLocation] = deployBS(area, UHFM_intensity, ratio(p), 0);

    for j = 1:Niterations
        covered_users = 0;
        user_association;
        temp_rate = temp_rate + sum_rate;

    end
    coverage_probability(p) = (temp_cov_prob/Niterations);
    coverage_probability_mmWave(p) = (temp_cov_prob_mm/Niterations);
    R(p) = temp_rate/Niterations;
    temp_cov_prob=0;
    temp_cov_prob_mm=0;
    temp_rate = 0;
    clc;
    display(strcat('Percent Completion:  ', strcat(num2str(ceil(100*p/length(ratio)))),'%'));
end
R = (R.*Niterations)+prev_tot;
itera_num = itera_num+Niterations;
R = R./itera_num;
save(locationR, filenameR);
save(locationI, filenameI);
R
itera_num
% figure;
% plot(ratio, R);
% title('Sum rates ');
% xlabel('l_s / l_u_h_f');
% ylabel('Rate -->');







display('Done');
