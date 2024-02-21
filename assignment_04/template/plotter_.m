close all;
clear all;
clf;
foghll=dlmread('slug_sod128_fog_mm_hll_10021.dat');
plmmmhll=dlmread('slug_sod128_plm_mm_hll_10021.dat');
ppmmmhll=dlmread('slug_sod128_ppm_mm_hll_10021.dat');
ppmmmhll2=dlmread('slug_sod_ppm_mm_hll_10021.dat');

figure(1);
hold on;
title('sod128 fog/plm/ppm mm hll')
plot(foghll(:,1),foghll(:,2),'r');
plot(plmmmhll(:,1),plmmmhll(:,2),'b');
plot(ppmmmhll(:,1),ppmmmhll(:,2),'p');
plot(ppmmmhll2(:,1),ppmmmhll2(:,2),'pb');
legend('FOG','PLM + minmod','PPM + minmod', 'PPM + minmod');


fogroe=dlmread('slug_sod128_fog_mm_roe_10021.dat');
plmmmroe=dlmread('slug_sod128_plm_mm_roe_10021.dat');
ppmmmroe=dlmread('slug_sod128_ppm_mm_roe_10021.dat');
ppmmmroe2=dlmread('slug_sod_ppm_mm_roe_10021.dat');


figure(2);
hold on;
title('sod128 fog/plm/ppm mm roe')
plot(fogroe(:,1),fogroe(:,2),'r');
plot(plmmmroe(:,1),plmmmroe(:,2),'b');
plot(ppmmmroe(:,1),ppmmmroe(:,2),'p');
plot(ppmmmroe2(:,1),ppmmmroe2(:,2),'pb');

legend('FOG','PLM + minmod','PPM + minmod', 'PPM + minmod');