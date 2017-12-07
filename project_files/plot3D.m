clc;
clear all
close all
% -------------------------------------------------------------------------
tic
area = 20*20;                  % the total area in squared meters

user_intensity = 1;          % the intensity of users in m^2
UHFM_intensity = 0.1;              % the BS intensity in m^2

%deploy users in the area
[U, nU] = deployUsers(user_intensity, area);
Niterations = 1;
warning off;
t = -40:5:10;
temp_cov_prob=0;
temp_cov_prob_mm=0;
coverage_probability = zeros(1, length(t));
coverage_probability_mmWave = zeros(1, length(t));

for p = 1 : length(t)
    threshold_dB = t(p);
    ratio = 0:0.5:4;
    for l = 1 : length(ratio)
        mm_intensity = ratio(l)*UHFM_intensity;
        [nBS_0, nBS_1, nBS_2, BSType, BSLocation] = deployBS(area, UHFM_intensity, ratio(l), 0);      
        
        for j = 1:Niterations
            covered_users = 0;
            user_association;
            temp_cov_prob = temp_cov_prob + (covered_users/nU);
            temp_cov_prob_mm = temp_cov_prob_mm + (nU_BS_1/covered_users);
        end
        coverage_probability(p, l) = (temp_cov_prob/Niterations);
        coverage_probability_mmWave(p, l) = (temp_cov_prob_mm/Niterations);
        temp_cov_prob=0;
        temp_cov_prob_mm=0;
        clc;
        display(strcat('Percent Completion:  ', strcat(num2str(ceil(100*p/length(t)))),'%'));
    end
    
%    figure;
%    plot(t, coverage_probability);
%    title('Coverage Probability based on maximum biased received power');
%    xlabel('Threshold power in dB -->');
%    ylabel('Coverage Probability -->');
%    display('Done');
end
toc

coverage_probability = coverage_probability(1:length(t), 1:length(ratio));
coverage_probability_mmWave = coverage_probability_mmWave(1:length(t), 1:length(ratio));
coverage_probability_mmWave(find(isnan(coverage_probability_mmWave))) = 0;
figure; 
mesh(ratio, t, coverage_probability_mmWave);
xlabel('ratio of small cells to macro cells');
ylabel('threshold in dB');
zlabel('fraction of users attended by mmWave');
title('Fraction of users loaded by mmWave Small Cells at different ratio and thresholds');


figure; 
mesh(ratio, t, coverage_probability);
xlabel('ratio of small cells to macro cells');
ylabel('threshold in dB');
zlabel('fraction of users attended by the whole system');
title('Fraction of users loaded by the system at different ratio and thresholds');
