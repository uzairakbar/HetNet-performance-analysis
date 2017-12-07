% -------------------------------------------------------------------------
clc;
clear all
close all
% -------------------------------------------------------------------------

area = 20*20;                  % the total area in squared meters

user_intensity = 0.2;          % the intensity of users in m^2
UHFM_intensity = 0.1;              % the BS intensity in m^2 
ratio = 4;
mm_intensity = ratio*UHFM_intensity;
%deploy users in the area
[U, nU] = deployUsers(user_intensity, area);
[nBS_0, nBS_1, nBS_2, BSType, BSLocation] = deployBS(area, UHFM_intensity, ratio, 0);
covered_users = 0;
user_association;
coverage_probability = covered_users/nU

