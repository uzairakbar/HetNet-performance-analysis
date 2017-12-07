function [ f ] = getFrequency( tier )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
f = zeros(1, length(tier));
for i = 1:length(tier)
    if tier(i) == 0
        f(1, i) = 2.4e9;
    else if tier(i) == 1
            f(1, i) = 73e9;
        else if tier(i) == 2
                f(1, i) = 2.4e9;
            end
        end
    end
end

end

