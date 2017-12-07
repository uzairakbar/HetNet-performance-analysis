function [interference_noise_dB] = getInterferencePlusNoise(tier, power_db_array, max_power, nBS_0, nBS_1, nBS_2)



%N0 = -174; %noise in dBm/Hz
N0 = -174-30; %noise in dB/Hz
N0 = 10.^(N0./10); %noise converted to Watts/Hz
BW = getBandwidth(tier);



powers = [];
max_power_watts = 10.^(max_power/10); %convert max power to DBs
% Seperate all base stations of similar tiers
if tier == 0
    powers = power_db_array(1:nBS_0);
elseif tier == 1
    powers = power_db_array(nBS_0+1:nBS_1);
elseif tier == 2
    powers = power_db_array(nBS_1+1:nBS_2);
end

powers = powers + (2.*fading(length(powers), tier)); %fading added to each power (in dBs)

powers_watts = 10.^(powers./10); %get powers in Watts to add for intereference

interference_noise_dB = 10.*log10(BW*N0 + sum(powers_watts) - max_power_watts);

end