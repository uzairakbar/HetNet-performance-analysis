function [noise_dB] = getNoise(tier)
%funtion to return noise.
%values obtianed from "Self-adaptive Power Control Mechanism in
%Device-to-Device Enabled Multi-tier HetNets; An
%Optimization Approach"

N0 = -174; %noise in dBm/Hz
N0 = -174-30; %noise in dB/Hz
N0 = 10.^(N0./10); %noise converted to Watts/Hz
BW = getBandwidth(tier);
noise_dB = 10.*log10(BW*N0);


end