function [ s ] = getSubCarriers(tier)
%UNTITLED17 Summary of this function goes here
%   Detailed explanation goes here
s = zeros(length(tier));

for i = 1:length(tier)
    if tier(i) == 0
        s(i) = 1;
    else if tier(i) == 1
            s(i) = 1;
        else if tier(i) == 2
                s(i) = 1;
            end
        end
    end
end


end

