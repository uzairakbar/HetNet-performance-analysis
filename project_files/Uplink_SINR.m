% algorithm to associate each user to a base station defined by its tier.

% METHOD FOLLOWED:
% For each user i
%   For each base station j
%       check what type of base station it is and what are its properties
%       find distance from user i to BS j
%       determine path loss from user i to BS j
%       determine revceived power from user i to BS j
%   find maximum power received to the user i from all BS
%   if maximum power received > threshold_dB
%       associate user i to BS j

% after association, we find SINR of every user i
% this all happens in dBs
%   SINR(i) = power_received(i, j) + fading_dB - shadowing - interference(i)

Ux = (U(:, 1));
Uy = (U(:, 2));
BSx = BSLocation(:, 1);
BSy = BSLocation(:, 2);
do = 1;
covered_users = 0;
nU_BS_0 = 0;
nU_BS_1 = 0;
nU_BS_2 = 0;
%uplink_threshold = -45; % -45db Uplink threshold
d = [];
Pt_dB = [];
Pr_dB = [];
L_dB = [];

for i = 1:length(BSx)
    %This loop runs for each BS
    d(i, :) = sqrt( (Ux - BSx(i)).^2 + (Uy - BSy(i)).^2 ); %distance of users from each BS
   
    Pt_dB = getUplinkTransmitPower(BSType(i)); %get transmit power depending of user
    L_dB(i, :) = getPathLoss(BSType(i), d(i, :)); %get loss depending on the type of BS connected
    Pr_dB(i, :) = Pt_dB(1,:) - L_dB(i, :);  
  
end

max_power_db = [];
BS_associated = [];
user_per_tier = [0 0 0]; %index of array -> tier.    value of index -> users associated with that tier
bias_array = [getBiasFactorUplink(0).*ones([1 nBS_0])  getBiasFactorUplink(1).*ones([1 nBS_1])   getBiasFactorUplink(2).*ones([1 nBS_2])];
uplink_sinr = [];
tt = 0;
for i = 1:length(Ux)
    [max_power_db(i), BS_associated(i)] = max(transpose(Pr_dB(:, i)) + bias_array);
    tt = getTier( BS_associated(i), nBS_0, nBS_1, nBS_2 );
     interference(i) = real(getInterference(tt, transpose(Pr_dB(:, i)), max_power_db(i) - bias_array(BS_associated(i)), nBS_0, nBS_1, nBS_2));
        fade(i) = fading(1, tt );
        s(i) = getShadowing(1, tt);
        noise(i) = getNoise(tt);
        uplink_sinr(i) = ( max_power_db(i) + 2 * fade(i) - s(i) ) - ( interference(i) + noise(i) );
%          rate(i) = getBandwidth(tier(i))*log2(1 + SINR(i));
    if max_power_db(i)>uplink_threshold
        user_per_tier(1+getTier( BS_associated(i), nBS_0, nBS_1, nBS_2 )) = user_per_tier(1+getTier( BS_associated(i), nBS_0, nBS_1, nBS_2 ))+1; 
       
    end
    
end
covered_users = sum(user_per_tier);
nU_BS_0 = user_per_tier(1);
nU_BS_1 = user_per_tier(2);
nU_BS_2 = user_per_tier(3);

% for i = 1 : nU
%     d(i, :) = sqrt( (Ux(i) - BSx).^2 + (Uy(i) - BSy).^2 );
%     [Pt_dB, B, f, subcarriers] = getBSProperties(BSType);
%     Pt_dB = getUplinkTransmitPower(BSType);
%     L_dB(i, :) = getPathLoss(BSType, d(i, :));
%     Pr_dB(i, :) = Pt_dB(1,:) - L_dB(i, :);       %getReceivedPower(BSType(:), d(i, :));
%     bias_array = [getBiasFactorUplink(0).*ones([1 nBS_0])  getBiasFactorUplink(1).*ones([1 nBS_1])   getBiasFactorUplink(2).*ones([1 nBS_2])];  %add biasing factor
%     checking = Pr_dB(i, :)+bias_array;
%     [power_dB(i), BS_associated(i)] = max(Pr_dB(i, :)+bias_array);
%     
%     if power_dB(i) > threshold_dB
%         power_dB(i) = power_dB(i) - getBiasFactor(getTier(BS_associated(i),nBS_0, nBS_1, nBS_2));
%         association_matrix(i, BS_associated(i)) = 1;
%         covered_users = covered_users+1;
%         tier(i) = getTier(BS_associated(i), nBS_0, nBS_1, nBS_2);
%          %interference
%          interference(i) = real(getInterference(tier(i), Pr_dB(i, :), power_dB(i), nBS_0, nBS_1, nBS_2));
%          fade(i) = fading(1, tier(i));
%          s(i) = getShadowing(1, tier(i));
%          noise(i) = getNoise(tier(i));
%          SINR(i) = ( power_dB(i) + 2 * fade(i) - s(i) ) - ( interference(i) + noise(i) );
%          rate(i) = getBandwidth(tier(i))*log2(1 + SINR(i));
%          %interference
%         if tier(i) == 0
%             nU_BS_0 = nU_BS_0 + 1;
%         else if tier(i) == 1
%                 nU_BS_1 = nU_BS_1 + 1;
%             else
%                 nU_BS_2 = nU_BS_2 + 1;
%             end
%         end
%     end
% end

