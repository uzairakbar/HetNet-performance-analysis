function [LOS] = isLOS(link_distance)
% This funtion returns binary values, 1 indicating LOS and 0 indicating
% NLOS link for mmWave links. There is a 50% chance that the link will be a
% LOS link. Dependence on link distance may be added later, so an argument
% is included.
LOS = randi([0 1],1,1);

end