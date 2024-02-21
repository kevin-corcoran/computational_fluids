close all;
clear all;
clf;

% Sod's Shock Tube tests
% fog
foghll=dlmread('slug_sod128_fog_hll_10027.dat');
foghllc=dlmread('slug_sod128_fog_hllc_10027.dat');
fogroe=dlmread('slug_sod128_fog_roe_10027.dat');

% hll, hllc, roe with plm + mm,vl,mc limiters
plmmmhll=dlmread('slug_sod128_plm_mm_hll_10021.dat');
plmvlhll=dlmread('slug_sod128_plm_vl_hll_10027.dat');
plmmchll=dlmread('slug_sod128_plm_mc_hll_10027.dat');

plmmmhllc=dlmread('slug_sod128_plm_mm_hllc_10027.dat');
plmvlhllc=dlmread('slug_sod128_plm_vl_hllc_10027.dat');
plmmchllc=dlmread('slug_sod128_plm_mc_hllc_10027.dat');

plmmmroe=dlmread('slug_sod128_plm_mm_roe_10027.dat');
plmvlroe=dlmread('slug_sod128_plm_vl_roe_10027.dat');
plmmcroe=dlmread('slug_sod128_plm_mc_roe_10027.dat');

% ppm
ppmmmhll=dlmread('slug_sod128_ppm_mm_hll_10027.dat');
ppmvlhll=dlmread('slug_sod128_ppm_vl_hll_10027.dat');
ppmmchll=dlmread('slug_sod128_ppm_mc_hll_10027.dat');

ppmmmhllc=dlmread('slug_sod128_ppm_mm_hllc_10027.dat');
ppmvlhllc=dlmread('slug_sod128_ppm_vl_hllc_10027.dat');
ppmmchllc=dlmread('slug_sod128_ppm_mc_hllc_10027.dat');

ppmmmroe=dlmread('slug_sod128_ppm_mm_roe_10027.dat');
ppmvlroe=dlmread('slug_sod128_ppm_vl_roe_10027.dat');
ppmmcroe=dlmread('slug_sod128_ppm_mc_roe_10027.dat');


% figure(1);
% hold on;
% sgtitle('Sod''s shock tube: HLL, HLLC, Roe for FOG, PLM/PPM + minmod, vanLeer, mc');
% subplot(3,1,1);
% hold on;
% title('Density')
% plot(foghll(:,1),foghll(:,2),'r');
% plot(foghllc(:,1),foghllc(:,2),'b');
% plot(fogroe(:,1),fogroe(:,2),'y');
% 
% % plm
% plot(plmmmhll(:,1),plmmmhll(:,2),'b');
% plot(plmvlhll(:,1),plmvlhll(:,2),'r');
% plot(plmmchll(:,1),plmmchll(:,2),'r');
% 
% plot(plmmmhllc(:,1),plmmmhllc(:,2),'r');
% plot(plmvlhllc(:,1),plmvlhllc(:,2),'b');
% plot(plmmchllc(:,1),plmmchllc(:,2),'b');
% 
% plot(plmmmroe(:,1),plmmmroe(:,2),'g');
% plot(plmvlroe(:,1),plmvlroe(:,2),'r');
% plot(plmmcroe(:,1),plmmcroe(:,2),'b');
% 
% % ppm
% plot(ppmmmhll(:,1),plmmmhll(:,2),'p');
% plot(ppmvlhll(:,1),plmvlhll(:,2),'g');
% plot(ppmmchll(:,1),plmmchll(:,2),'g');
% 
% plot(ppmmmhllc(:,1),plmmmhllc(:,2),'g');
% plot(ppmvlhllc(:,1),plmvlhllc(:,2),'g');
% plot(ppmmchllc(:,1),plmmchllc(:,2),'g');
% 
% plot(ppmmmroe(:,1),plmmmroe(:,2),'p');
% plot(ppmvlroe(:,1),plmvlroe(:,2),'g');
% plot(ppmmcroe(:,1),plmmcroe(:,2),'g');
% 
% 
% % legend('FOG','PLM + minmod','PPM + minmod');
% subplot(3,1,2);
% hold on;
% title('Velocity')
% plot(foghll(:,1),foghll(:,3),'r');
% plot(foghllc(:,1),foghllc(:,3),'b');
% plot(fogroe(:,1),fogroe(:,3),'y');
% 
% plot(plmmmhll(:,1),plmmmhll(:,3),'r');
% plot(plmvlhll(:,1),plmvlhll(:,3),'r');
% plot(plmmchll(:,1),plmmchll(:,3),'r');
% 
% plot(plmmmhllc(:,1),plmmmhllc(:,3),'b');
% plot(plmvlhllc(:,1),plmvlhllc(:,3),'b');
% plot(plmmchllc(:,1),plmmchllc(:,3),'b');
% 
% 
% % legend('FOG','PLM + minmod','PPM + minmod');
% subplot(3,1,3);
% hold on;
% title('Pressure')
% plot(foghll(:,1),foghll(:,4),'r');
% plot(foghllc(:,1),foghllc(:,4),'b');
% plot(fogroe(:,1),fogroe(:,4),'y');
% 
% plot(plmmmhll(:,1),plmmmhll(:,4),'r');
% plot(plmvlhll(:,1),plmvlhll(:,4),'r');
% plot(plmmchll(:,1),plmmchll(:,4),'r');
% 
% plot(plmmmhllc(:,1),plmmmhllc(:,4),'b');
% plot(plmvlhllc(:,1),plmvlhllc(:,4),'b');
% plot(plmmchllc(:,1),plmmchllc(:,4),'b');

% legend('FOG','PLM + minmod','PPM + minmod');


% 1. Sod's Shock Tube
foghll=dlmread('slug_sod128_fog_mm_roe_10021.dat');
plmmmhll=dlmread('slug_sod128_plm_mm_hll_10021.dat');
ppmmmhll=dlmread('slug_sod128_ppm_mm_hll_10022.dat');

figure(1);
hold on;
sgtitle('Sod''s shock tube: HLL for FOG, PLM + minmod, PPM + minmod');
% subplot(3,1,1);
hold on;
title('Density')
plot(foghll(:,1),foghll(:,2),'r');
plot(plmmmhll(:,1),plmmmhll(:,2),'b');
plot(ppmmmhll(:,1),ppmmmhll(:,2),'p');
legend('FOG','PLM + minmod','PPM + minmod');
% subplot(3,1,2);
% hold on;
% title('Velocity')
% plot(foghll(:,1),foghll(:,3),'r'); 
% plot(plmmmhll(:,1),plmmmhll(:,3),'b');
% plot(ppmmmhll(:,1),ppmmmhll(:,3),'g');
% legend('FOG','PLM + minmod','PPM + minmod');
% subplot(3,1,3);
% hold on;
% title('Pressure')
% plot(foghll(:,1),foghll(:,4),'r');
% plot(plmmmhll(:,1),plmmmhll(:,4),'b');
% plot(ppmmmhll(:,1),ppmmmhll(:,4),'g');
% legend('FOG','PLM + minmod','PPM + minmod');

% PPM reduces to plm?
















% % 2. Rarefaction problem
% plmmmhll2=dlmread('slug_sod128_plm_mm_hll2_10022.dat');
% plmmmhllc2=dlmread('slug_sod128_plm_mm_hllc2_10022.dat');
% plmmmroe2=dlmread('slug_sod128_plm_mm_roe2_10021.dat');
% 
% 
% figure(2);
% hold on;
% sgtitle('Rarefaction: HLL, HLLC, and Roe with PLM + minmod');
% subplot(3,1,1);
% hold on;
% title('Density')
% plot(plmmmhll2(:,1),plmmmhll2(:,2),'r');
% plot(plmmmhllc2(:,1),plmmmhllc2(:,2),'b');
% plot(plmmmroe2(:,1),plmmmroe2(:,2),'g');
% legend('HLL','HLLC','Roe');
% subplot(3,1,2);
% hold on;
% title('Velocity')
% plot(plmmmhll2(:,1),plmmmhll2(:,3),'r');
% plot(plmmmhllc2(:,1),plmmmhllc2(:,3),'b');
% plot(plmmmroe2(:,1),plmmmroe2(:,3),'g');
% legend('HLL','HLLC','Roe');
% subplot(3,1,3);
% hold on;
% title('Pressure')
% plot(plmmmhll2(:,1),plmmmhll2(:,4),'r');
% plot(plmmmhllc2(:,1),plmmmhllc2(:,4),'b');
% plot(plmmmroe2(:,1),plmmmroe2(:,4),'g');
% legend('HLL','HLLC','Roe');
% 
% % http://ossanworld.com/cfdnotes/cfdnotes_math671_report.pdf
% % In Roe’s method, all the waves are replaced by linear waves, and therefore no rarefaction waves(nonlinear
% % waves) are contained in the scheme. This results in the failure of detecting the sonic point, and it needs
% % to be modified in such a case.
% 
% % https://www.researchgate.net/publication/287103714_Finite-volume_solver_of_the_euler_equation_for_real_fluids
% % The Roe solver gives an entropy violating solution in case of transonic rarefaction wave. 
% % Thus,the Roe solver must be modiﬁed so as to avoid entropy violating solutions. This is usually referred toas "entropy ﬁx".
% 
% 
% % 3. Blast2 Problem
% fog3hllc=dlmread('slug_sod128_fog_3_hllc_10037.dat');
% ppm3mmhllc=dlmread('slug_sod128_ppm_mm_3_hllc_10037.dat');
% ppm3vlhllc=dlmread('slug_sod128_ppm_vl_3_hllc_10037.dat');
% ppm3mchllc=dlmread('slug_sod128_ppm_mc_3_hllc_10037.dat');
% 
% figure(3);
% hold on;
% sgtitle('Blast2: HLLC for FOG, PPM + minmod, vanLeer, mc');
% subplot(3,1,1);
% hold on;
% title('Density')
% plot(fog3hllc(:,1),fog3hllc(:,2),'p');
% plot(ppm3mmhllc(:,1),ppm3mmhllc(:,2),'b');
% plot(ppm3vlhllc(:,1),ppm3vlhllc(:,2),'g');
% plot(ppm3mchllc(:,1),ppm3mchllc(:,2),'r');
% legend('FOG','HLLC+minmod','HLLC+vanLeer', 'HLLC+mc');
% 
% subplot(3,1,2);
% hold on;
% title('Velocity')
% plot(fog3hllc(:,1),fog3hllc(:,3),'p');
% plot(ppm3mmhllc(:,1),ppm3mmhllc(:,3),'b');
% plot(ppm3vlhllc(:,1),ppm3vlhllc(:,3),'g');
% plot(ppm3mchllc(:,1),ppm3mchllc(:,3),'r');
% legend('FOG','HLLC+minmod','HLLC+vanLeer', 'HLLC+mc');
% 
% subplot(3,1,3);
% hold on;
% title('Pressure')
% plot(fog3hllc(:,1),fog3hllc(:,4),'p');
% plot(ppm3mmhllc(:,1),ppm3mmhllc(:,4),'b');
% plot(ppm3vlhllc(:,1),ppm3vlhllc(:,4),'g');
% plot(ppm3mchllc(:,1),ppm3mchllc(:,4),'r');
% legend('FOG','HLLC+minmod','HLLC+vanLeer', 'HLLC+mc');
% 
% 
% % 4. Shu-Osher Problem
% shu_fogroe=dlmread('slug_shu128_fog_roe_10007.dat');
% shu_plmmcroe=dlmread('slug_shu128_plm_mc_roe_10007.dat');
% shu_plmmchll=dlmread('slug_shu128_plm_mc_hll_10007.dat');
% 
% figure(4);
% hold on;
% sgtitle('Shu-Osher: Roe for FOG and PLM + mc');
% subplot(3,1,1);
% hold on;
% title('Density')
% plot(shu_fogroe(:,1),shu_fogroe(:,2),'p');
% plot(shu_plmmcroe(:,1),shu_plmmcroe(:,2),'b');
% plot(shu_plmmchll(:,1),shu_plmmchll(:,2),'g');
% legend('FOG+Roe','Roe+mc', 'HLL+mc');
% 
% subplot(3,1,2);
% hold on;
% title('Velocity')
% plot(shu_fogroe(:,1),shu_fogroe(:,3),'p');
% plot(shu_plmmcroe(:,1),shu_plmmcroe(:,3),'b');
% plot(shu_plmmchll(:,1),shu_plmmchll(:,3),'g');
% legend('FOG+Roe','Roe+mc', 'HLL+mc');
% 
% 
% subplot(3,1,3);
% hold on;
% title('Pressure')
% plot(shu_fogroe(:,1),shu_fogroe(:,4),'p');
% plot(shu_plmmcroe(:,1),shu_plmmcroe(:,4),'b');
% plot(shu_plmmchll(:,1),shu_plmmchll(:,4),'g');
% legend('FOG+Roe','Roe+mc', 'HLL+mc');
% 
% 
% 
% 
% % 5. Shu-Osher Problem
% shu_plmvlhllc=dlmread('slug_shu128_plm_vl_hllc_10028.dat');
% 
% figure(5);
% hold on;
% sgtitle('Shu-Osher: HLLC with PLM + vanLeer');
% subplot(3,1,1);
% hold on;
% title('Density')
% plot(shu_plmvlhllc(:,1),shu_plmvlhllc(:,2),'g');
% legend('HLLC+vanLeer')
% 
% subplot(3,1,2);
% hold on;
% title('Velocity')
% plot(shu_plmvlhllc(:,1),shu_plmvlhllc(:,3),'g');
% legend('HLLC+vanLeer')
% 
% 
% subplot(3,1,3);
% hold on;
% title('Pressure')
% plot(shu_plmvlhllc(:,1),shu_plmvlhllc(:,4),'g');
% legend('HLLC+vanLeer')
% 
% 
