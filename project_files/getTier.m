function [ tier ] = getTier( BS_index, nBS_0, nBS_1, nBS_2 )
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here

tier = zeros(1, length(BS_index));

for i = 1 : length(BS_index)
    if BS_index(i) < 1
        error('BS index cannot be zero');
    end
    if BS_index(i) <= nBS_0
        tier(i) = 0;
    else if BS_index <= nBS_1 + nBS_0
            tier(i) = 1;
        else if BS_index <= nBS_2 + nBS_1 + nBS_0
                tier(i) = 2;
            end
        end
    end
end
    
end

