function [ Pt_dB ] = getUplinkTransmitPower( tier )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
Pt_dB = zeros(1, length(tier));



%CHANGE POWER TO 20dBm
POWER = 20; %power in dBm
for i = 1:length(tier)
    if tier(i) == 0
        Pt_dB(1, i) = POWER-30;
    else if tier(i) == 1
            Pt_dB(1, i) = POWER-30;
        else if tier(1, i) == 2
                Pt_dB(1, i) = POWER-30;
            end
        end
    end
end

end
