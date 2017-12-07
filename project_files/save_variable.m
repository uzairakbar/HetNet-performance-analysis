%  filename = 'K_100_db';
%  pre = 'X:\FYP\Basic_Model_new\';
%  location = strcat(pre,strcat(filename, '.mat'));
%  save(location, filename);

x = 1;
if x == 1
   filename = 'K_0_db';
   location = strcat(pre,strcat(filename, '.mat'));
   load(location);
   filename = 'K_3_db';
   location = strcat(pre,strcat(filename, '.mat'));
   load(location);
   filename = 'K_6_db';
   location = strcat(pre,strcat(filename, '.mat'));
   load(location);
   filename = 'K_12_db';
   location = strcat(pre,strcat(filename, '.mat'));
   load(location);
   filename = 'K_100_db';
   location = strcat(pre,strcat(filename, '.mat'));
   load(location);
   plot(ratio, K_0_db, 'r');
   hold on;
   plot(ratio, K_3_db, 'g');
   hold on;
   plot(ratio, K_6_db, 'y');
   hold on;
   plot(ratio, K_12_db, 'k');
   hold on;
    plot(ratio, K_100_db);
   hold on;
   legend('K = 0db', 'K = 3db', 'K = 6db' , ' K = 12db', 'K = 100db');
   xlabel('Ratio (microcells/macrocells) -->');
   ylabel('System Sum rate -->');
   title('Rate vs BS ratio for different K');
   
   
    
    
end