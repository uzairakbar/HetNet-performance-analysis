function [interference_dB] = getInterference(tier, power_db_array, max_power, nBS_0, nBS_1, nBS_2)
%This function returns the total interference seen by a base station that
%is associated with a user. max_power is the maximum power being received
%by the user, and hence is the power from tagged base station reaching the
%user.
%power_db_array is the sum all powers from all tiers reaching the user
%nBS_0 --> number of UHF macrocells
%nBS_1 --> number of mmWave small cells
%nBS_2 --> number of UHF macrocells


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

interference_dB = 10.*log10(sum(powers_watts) - max_power_watts);

end