function [ Pt_dB, B, f, subcarriers ] = getBSProperties( tier )

%   Tier completely defines the type of a base station
%   This is how it is:

%   TIER                BS type
%   0                   UHF Macro cell
%   1                   mmWave Small cell
%   2                   UHF Small cell

% the properties of a base station are:
% Pt_dB                                  transmit power in dB
% B                                      bandwidth
% f                                      operating frequency
% subcarriers                            the number of subcarriers

Pt_dB = getTransmitPower(tier);
B = getBandwidth(tier);
f = getFrequency(tier);
subcarriers = getSubCarriers(tier);


% for i = 1 : 1 : length(tier)
%     if tier(i) == 0
%         % it means UHF Macro cell should be deployed.
%         Pt_dB(i) = 46-30;                          % 46 dBm
%         B(i) = 20e6;                               % 20 MHz
%         f(i) = 2.4e9;                              % 2.4 GHz
%         subcarriers(i) = 1;                        % the number of subcarriers
%         
%     else if tier(i) == 1
%             % it means mmWave Small cell should be deployed.
%             Pt_dB(i) = 46-30;                          % 30 dBm
%             B(i) = 2e9;                                % 2 GHz
%             f(i) = 73e9;                               % 73 GHz
%             subcarriers(i) = 1;                        % the number of subcarriers
%             
%         else if tier(i) == 2
%                 % it means UHF small cell should be deployed
%                 Pt_dB(i) = 34-30;
%                 B(i) = 20e6;
%                 f(i) = 2.4e9;
%                 subcarriers(i) = 1;
%             end
%         end
%     end
% end

end

