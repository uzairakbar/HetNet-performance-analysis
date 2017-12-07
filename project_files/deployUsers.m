function [ user_locations, nusers ] = deployUsers( user_intensity, area )
% user = PPP
% User deployment:
% This step can be done independent of the following steps. Users are 
% deployed on an area with a PPP

% intensity                     number of users that you want
% area                          the grid assuming a square grid.
length = sqrt(area);
center = [length/2 , length/2];         % center coordinates of the circle 
nusers = poissrnd(user_intensity*area);
user_locations = length*rand(nusers,2);

% uncomment the following lines if you want to visualize
% Ux = user_locations(:, 1);                      % x-coordinates of users
% Uy = user_locations(:, 2);                      % y-coordinates of users
% scatter(Ux, Uy,'o', 'filled');         % scatter plot of the users
% grid on
% hold on


end

