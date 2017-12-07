function [ L_dB ] = getPathLoss( tier, distance)

c = 3e8;
PLE = assignPLE(tier);
do = 1;

L_dB = 20.*log10(4*pi*getFrequency(tier)./c) + (10.*PLE).*log10((distance)./do);    


end

