function [fade_dB] = fading(number_points, tier)
% Code to generate samples from a rician distribution. K = 0 corresponds to
% Rayleigh fading. This function takes as inputs the number of points to be
% generated and the K parameter for the rician distribution. The output is
% an array of size "number_points" and contains samples from a rician
% distribution

if tier == 0
    K_param = 0;   %Rayleigh fading for tier 0 (UHF)
elseif tier == 1
    K_param = 3;   % K parameter 
elseif tier == 2
    K_param = 0;   %Rayleigh fading for tier 2 (UHF)
end
K_param = 10.^(K_param/10);
mean_value = 0;             %mean is zero, but variable included for easy change
std = sqrt(1/2);                    %Standard deviation


A = sqrt(K_param.*2.*(std.^2)); %Main LOS signal power. Calculated using formula 

if number_points == 1
    x = mean_value + std.*randn([ 1, 2]); %Gaussian RV 1
    y = mean_value + std.*randn([ 1, 2]); %Gaussian RV 2
    fade_dB = abs((x + 1i.*y + A));
    normalize_val = sqrt(mean(fade_dB.*fade_dB));
    fade_dB = fade_dB./normalize_val;
    fade_dB =fade_dB(1);
else
x = mean_value + std.*randn([ 1, number_points]); %Gaussian RV 1
y = mean_value + std.*randn([ 1, number_points]); %Gaussian RV 2
fade_dB = abs((x + 1i.*y + A));
normalize_val = sqrt(mean(fade_dB.*fade_dB));
fade_dB = fade_dB./normalize_val;

end
%fade_dB = 10*log10(fade_dB); % The absolute value of a complex gaussian plus signal power is Rician distribution
end