function [ Pt_dB ] = getTransmitPower( tier )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
Pt_dB = zeros(1, length(tier));

for i = 1:length(tier)
    if tier(i) == 0
        Pt_dB(1, i) = 46-30;
    else if tier(i) == 1
            Pt_dB(1, i) = 30-30;
        else if tier(i) == 2
                Pt_dB(1, i) = 34-30;
            end
        end
    end
end

end

