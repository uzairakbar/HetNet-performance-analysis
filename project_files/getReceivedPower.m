function [ Pr_dB ] = getReceivedPower( tier, distance)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

Pt_dB = getTransmitPower(tier);
L_dB = getPathLoss(tier, distance);
Pr_dB = Pt_dB - L_dB;


end

