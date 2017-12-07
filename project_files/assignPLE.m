function [ PLE ] = assignPLE( tier )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

for i = 1 : length(tier)
    if tier(i) == 0
        PLE(i) = 3.3;
    else if tier(i) == 1;
            if isLOS()
                PLE(i) = 2;
            else 
                PLE(i) = 3.3;
            end
        else if tier(i) == 2;
                PLE(i) = 2;
            end
        end
    end

end

