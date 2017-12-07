function [bias_factor_db] = getBiasFactorUplink(tier)
%This function returns the biasing factor for the concerned tier

if tier == 0
    bias_factor_db = 0;  %No biasing for UHF macrocell
elseif tier == 1
    bias_factor_db = 10; %mmWave small cell biased by 20dB
elseif tier == 2
    bias_factor_db=0;    %uhf small cell bias factor
end
end