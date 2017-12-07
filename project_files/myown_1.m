% -------------------------------------------------------
clc;
clear all
close all
% --------------------------------------------------------
% STEPS TOWARDS CREATING YOUR OWN ENVIRONMENT

% user = PPP
% BS = PPP (UHF)
% Lognormal fading with mean 1
% associations based on power received.

% **********************************************************************
% Step 1) User deployment:
% This step can be done independent of the following steps. Users are 
% deployed on an area (20x20 km^2 here) with a uniform distribution


area = 20*20;

user_intensity = 0.25;                  % number of users that you want
center = [10 ,10];                  % center coordinates of the circle 
radius = 10;                        % radius of the circle
nusers = poissrnd(user_intensity*area);        % random angle
r = 2*radius*rand(nusers,2);
Ux = r(:, 1);                      % x-coordinates of users
Uy = r(:, 2);                      % y-coordinates of users
scatter(Ux, Uy,'o', 'filled');         % scatter plot of the users
grid on
hold on

% running the code till here, you'll find N users deployed randomly

% *************************************************************************

% Step 2) Base stations deployment:
% Base stations are deployed in the same area through a Poisson point
% process with rate lamda.
intensity_of_BS = 0.04;                   % lambda of the PPP
npoints = poissrnd(area*intensity_of_BS);    % create a PPP
pproc = 2*radius*rand(npoints,2);
BSx = pproc(:, 1);                      % x-coordinates of base stations
BSy = pproc(:, 2);                      % y-coordinates of base stations
scatter(BSx, BSy, 'o');                 % scatter plot of the distribution

legend(strcat('Users', num2str(nusers)), strcat('UHF Base stations', num2str(npoints)));
voronoi(BSx, BSy);

% running the code till here, you'll see users as well as BS deployed on
% the given area with the key too.

% *************************************************************************

% Step 3) Specifications of the Base Stations(omnidirectional):
% We spcify the BSs in terms of their transmit power, path loss exponent,
% path loss model used, and the wavelength(which is UHF in this case)

Pt = 3.9811e+04;                            % transmitted power is in watts
Pt_dB = 10 * log10(Pt);                     % transmitted power in dBs
threshold_dB = -30;                         % threshold in dBs
f = 2.4e9;                                  % frequency of UHF = 2.4 GHz
c = 3e8;                                    % speed of the wave
l = c/f;                                    % wavelength of the wave
n = 3;                                      % path loss exponent 
R = 5;                                      % the radius of the cell
%buildcircles(pproc(:, 1), pproc(:, 2), R);  % build circles around the BSs
Gt = 1;                                     % gain of antenna


% noise power is assumed to be one(in watts) for simplicity.
bandwidth = 20e6;
noise_power = 1.38e-23 * 290 *  bandwidth;
noise_power_dB = 10*log10(noise_power);

% covered users (out of N)
covered_users = 0;

% shadowing introduced....
mu = 1;                                     % mean of shadowing
sigma_dB = 4;                               % standard deviation
sigma = 10^(sigma_dB/10);

% *************************************************************************

% STEP 4) User Assignment to each Base Station & Calculations
%  i)   For every user placed, the nearest base station is found from that 
%       user and a visual line can be made between them.
% ii)   Path loss is computed for the associated Base Station.
%iii)   Received power is computed for each user from its BS.
% iv)   SNR for the each user is computed.
%  v)   SNR is checked if it's above the threshold and a count is kept.
% vi)   The fraction of users that get the SNR above the threshold is found
%       thereby finding the coverage probability.


for i = 1 : nusers
    d(i, :) = sqrt(( (Ux(i) - BSx).^2 ) + ( (Uy(i) - BSy).^2) );
   % X_dB(i, :) = fading();
    X_dB(i, :) = lognrnd(mu, sigma_dB);
    L_dB(i, :) = 20*log10((4*pi/l)) + 10.*n.*log10(d(i, :)) + X_dB(i, :);
    L(i, :) = 10.^(L_dB(i, :) ./ 10);
    Pr(i, :) = Gt .* Pt ./ L(i, :);
    
    [power(i), BS_associated(i)] = max(Pr(i, :));
    
    interference(i) = sum(Pr(i, :)) - power(i); 
    SINR(i) = power(i) /( interference(i) + noise_power );
    SINR_dB(i) = 10*log10(SINR(i));
   
     if SINR_dB(i) > threshold_dB
         covered_users = covered_users+1;
         plot([Ux(i), BSx(BS_associated(i))], [Uy(i), BSy(BS_associated(i))]);
     end
     

end 
coverage_probability = covered_users / nusers;
display(strcat('coverage probability = ', num2str(coverage_probability)));


