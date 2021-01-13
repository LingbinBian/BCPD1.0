% This script saves all the pictures in supplementary information

% Version 1.0
% 27-September-2020
% Copyright (c) 2020, Lingbin Bian

clear
clc
close all


% destination file

mkdir ../supplementary
mkdir ../supplementary/sparsity_20
mkdir ../supplementary/sparsity_30
pic_path='../../supplementary/';
  
% save change point detection figures
cd 'Global_fitting_synthetic';  

open('simul_K3_W20_n0_3162.fig')
saveas(gcf,[pic_path,'simul_K3_W20_n0_3162.png'])

open('simul_K4_W20_n0_3162.fig')
saveas(gcf,[pic_path,'simul_K4_W20_n0_3162.png'])

open('simul_K5_W20_n0_3162.fig')
saveas(gcf,[pic_path,'simul_K5_W20_n0_3162.png'])

open('simul_K6_W20_n0_3162.fig')
saveas(gcf,[pic_path,'simul_K6_W20_n0_3162.png'])

cd ..

cd 'Global_fitting_synthetic';  

open('simul_K3_W20_n0_5623.fig')
saveas(gcf,[pic_path,'simul_K3_W20_n0_5623.png'])

open('simul_K4_W20_n0_5623.fig')
saveas(gcf,[pic_path,'simul_K4_W20_n0_5623.png'])

open('simul_K5_W20_n0_5623.fig')
saveas(gcf,[pic_path,'simul_K5_W20_n0_5623.png'])

open('simul_K6_W20_n0_5623.fig')
saveas(gcf,[pic_path,'simul_K6_W20_n0_5623.png'])

cd ..

% save change point detection figures
cd 'Global_fitting_synthetic';  

open('simul_K3_W20_n1.fig')
saveas(gcf,[pic_path,'simul_K3_W20_n1.png'])

open('simul_K4_W20_n1.fig')
saveas(gcf,[pic_path,'simul_K4_W20_n1.png'])

open('simul_K5_W20_n1.fig')
saveas(gcf,[pic_path,'simul_K5_W20_n1.png'])

open('simul_K6_W20_n1.fig')
saveas(gcf,[pic_path,'simul_K6_W20_n1.png'])

cd ..


cd 'Global_fitting_synthetic';  
 
% 
open('simul_K3_W20_n1_7783.fig')
saveas(gcf,[pic_path,'simul_K3_W20_n1_7783.png'])

open('simul_K4_W20_n1_7783.fig')
saveas(gcf,[pic_path,'simul_K4_W20_n1_7783.png'])
% 
open('simul_K5_W20_n1_7783.fig')
saveas(gcf,[pic_path,'simul_K5_W20_n1_7783.png'])
% 
open('simul_K6_W20_n1_7783.fig')
saveas(gcf,[pic_path,'simul_K6_W20_n1_7783.png'])
% 
cd ..
% 
% cd 'Global_fitting_synthetic';  
% % 
% open('simul_K3_W20_n3_1623.fig')
% saveas(gcf,[pic_path,'simul_K3_W20_n3_1623.png'])
% 
% open('simul_K4_W20_n3_1623.fig')
% saveas(gcf,[pic_path,'simul_K4_W20_n3_1623.png'])
% % 
% open('simul_K5_W20_n3_1623.fig')
% saveas(gcf,[pic_path,'simul_K5_W20_n3_1623.png'])
% 
% open('simul_K6_W20_n3_1623.fig')
% saveas(gcf,[pic_path,'simul_K6_W20_n3_1623.png'])
% % 
% cd ..

% save local fitting figures

cd 'Local_fitting_synthetic/n0.3162';
open('localfit_synthetic.fig')
saveas(gcf,['../',pic_path,'localfit_synthetic_n0_3162.png'])
cd ../..

cd 'Local_fitting_synthetic/n0.5623';
open('localfit_synthetic.fig')
saveas(gcf,['../',pic_path,'localfit_synthetic_n0_5623.png'])
cd ../..

cd 'Local_fitting_synthetic/n1'
open('localfit_synthetic.fig')
saveas(gcf,['../',pic_path,'localfit_synthetic_n1.png'])
cd ../..


% save local inference synthetic figures
cd 'Local_inference_synthetic/n0.3162';
open('Labels_synthetic.fig')
saveas(gcf,['../',pic_path,'Labels_synthetic_n0_3162.svg'])

open('Labels_true.fig')
saveas(gcf,['../',pic_path,'Labels_true_n0_3162.svg'])

open('Mean_synthetic.fig')
saveas(gcf,['../',pic_path,'Mean_synthetic_n0_3162.svg'])

open('Variance_synthetic.fig')
saveas(gcf,['../',pic_path,'Variance_synthetic_n0_3162.svg'])
cd ../..

cd 'Local_inference_synthetic/n0.5623';
open('Labels_synthetic.fig')
saveas(gcf,['../',pic_path,'Labels_synthetic_n0_5623.svg'])

open('Labels_true.fig')
saveas(gcf,['../',pic_path,'Labels_true_n0_5623.svg'])

open('Mean_synthetic.fig')
saveas(gcf,['../',pic_path,'Mean_synthetic_n0_5623.svg'])

open('Variance_synthetic.fig')
saveas(gcf,['../',pic_path,'Variance_synthetic_n0_5623.svg'])
cd ../..

% save local inference synthetic figures
cd 'Local_inference_synthetic/n1'
open('Labels_synthetic.fig')
saveas(gcf,['../',pic_path,'Labels_synthetic_n1.svg'])

open('Labels_true.fig')
saveas(gcf,['../',pic_path,'Labels_true_n1.svg'])

open('Mean_synthetic.fig')
saveas(gcf,['../',pic_path,'Mean_synthetic_n1.svg'])

open('Variance_synthetic.fig')
saveas(gcf,['../',pic_path,'Variance_synthetic_n1.svg'])
cd ../..

close all

sp_level='sparsity_30';

cd 'Local_inference_real_LR/sparsity_30'

open('network_t41.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t41.jpeg'])

open('network_t76.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t76.jpeg'])

open('network_t107.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t107.jpeg'])

open('network_t140.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t140.jpeg'])

open('network_t175.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t175.jpeg'])

open('network_t206.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t206.jpeg'])

open('network_t239.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t239.jpeg'])

open('network_t278.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t278.jpeg'])

open('network_t306.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t306.jpeg'])

open('network_t334.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t334.jpeg'])

open('network_t375.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t375.jpeg'])

close all
% save cricos figures
cd 'circos_configuration/brain/circos_t41/'
copyfile('circos.png',['../../../../../../supplementary/',sp_level,'/circos_t41.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t76/'
copyfile('circos.png',['../../../../../../supplementary/',sp_level,'/circos_t76.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t107/'
copyfile('circos.png',['../../../../../../supplementary/',sp_level,'/circos_t107.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t140/'
copyfile('circos.png',['../../../../../../supplementary/',sp_level,'/circos_t140.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t175'
copyfile('circos.png',['../../../../../../supplementary/',sp_level,'/circos_t175.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t206/'
copyfile('circos.png',['../../../../../../supplementary/',sp_level,'/circos_t206.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t239'
copyfile('circos.png',['../../../../../../supplementary/',sp_level,'/circos_t239.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t278'
copyfile('circos.png',['../../../../../../supplementary/',sp_level,'/circos_t278.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t306/'
copyfile('circos.png',['../../../../../../supplementary/',sp_level,'/circos_t306.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t334'
copyfile('circos.png',['../../../../../../supplementary/',sp_level,'/circos_t334.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t375'
copyfile('circos.png',['../../../../../../supplementary/',sp_level,'/circos_t375.png'])
cd ../../../../..






