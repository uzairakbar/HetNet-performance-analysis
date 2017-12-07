function [ B ] = getBandwidth( tier )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
B = zeros(1, length(tier));
for i = 1:length(tier)
    if tier(i) == 0
        B(1, i) = 20e6;
    else if tier(i) == 1
            B(1, i) = 2e9;
        else if tier(i) == 2
                B(1, i) = 20e6;
            end
        end
    end
end

end
