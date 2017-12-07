function [] = buildcircles( x, y , r)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
for i = 1 : length(x)
    center = [x(i), y(i)];
    angle = [0:0.1:2*pi];
    X = r.*cos(angle)+ center(1);
    Y = r.*sin(angle)+ center(2);
    plot(X, Y); hold on
end
end

