function [nBS_0, nBS_1, nBS_2, BSType, BSLocation] = deployBS(Area, intensity_of_macrocell, ratio_small_to_macro_cell, ratio_small_UHF_to_small_mm)
% Area - Area where BSs are to be deployed
% intensity_of_macrocell - intensity of PPP for UHF macrocells
% ratio_small_to_macro_cell - Ratio of small cell density to macro cell
% density
% ratio_small_UHF_to_small_mm - Ratio of UHF small cells to mmWave small
% cells
% BSType = aray returning tier of each BS
% BSLocation = 2D array returning X and Y values of BS
% BSLocation(:,1)  --> This returns all x values
% BSLocation(:,2)  --> This returns all y values
% nBS_0 - number of 0th tier BSs
% nBS_1 - number of 1st tier BSs
% nBS_2 - number of 2nd tier BSs


% Step 1 - Deploy UHF macrocells
nBS_2 = 0;
nBS_0 = poissrnd(Area*intensity_of_macrocell);   % This functions gets the number of tier 0 (UHF Macrocell) Base stations using PPP
BSLocation = sqrt(Area)*rand(nBS_0,2);              % distributes  BS over a square region


% Step 2 - Deploy mmWave small cells
nBS_1 = poissrnd(Area*intensity_of_macrocell*ratio_small_to_macro_cell*(1-ratio_small_UHF_to_small_mm));
BSLocation = [BSLocation ; sqrt(Area)*rand(nBS_1,2)];
BSType = [zeros(nBS_0, 1); ones(nBS_1, 1)];

% Step 3 - Deploy UHF small cells
nBS_2 = poissrnd(Area*intensity_of_macrocell*ratio_small_to_macro_cell*(ratio_small_UHF_to_small_mm));
BSLocation = [BSLocation ; sqrt(Area)*rand(nBS_2,2)];
BSType = [zeros(nBS_0, 1); ones(nBS_1, 1); 2*ones(nBS_2, 1)];




end