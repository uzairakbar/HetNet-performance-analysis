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
uplink_threshold = -40;
temp_uplink_sinr = 0;

val_uplink_sinr = zeros(1, length(ratio));


for p = 1 : length(ratio)
   

    for j = 1:Niterations
        [nBS_0, nBS_1, nBS_2, BSType, BSLocation] = deployBS(area, UHFM_intensity, ratio(p), 0);
        [U, nU] = deployUsers(user_intensity, area);
        covered_users = 0;
        Uplink_SINR;
        temp_uplink_sinr = temp_uplink_sinr + mean(uplink_sinr);
      
             clc;
    display(strcat('Percent Completion:  ', strcat(num2str(ceil(100*p/length(ratio)))),'%'));
     display(strcat('Percent Completion:  ', strcat(num2str(ceil(100*j/Niterations))),'%'));

    end
    val_uplink_sinr(p) = (temp_uplink_sinr/Niterations);
    
   temp_uplink_sinr=0;
   
end
hold on;
plot(ratio, val_uplink_sinr, 'r');

title('mean uplink SINR');
xlabel('l_s / l_u_h_f');
ylabel('mean uplink SINR');


display('Done');
