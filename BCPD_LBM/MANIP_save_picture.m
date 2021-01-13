% This script saves all the pictures in a single destination file

% Version 1.0
% 23-April-2020
% Copyright (c) 2020, Lingbin Bian

clear
clc
close all

% destination file

mkdir ../pictures
pic_path='../../pictures/';
  
% save test sampling parameters
cd 'Test';
open('Test_mean.fig')
saveas(gcf,[pic_path,'Test_mean.png'])

open('Test_variance.fig')
saveas(gcf,[pic_path,'Test_variance.png'])
cd ..

% save change point detection figures
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

cd 'Global_fitting_real';

open('tfMRI_1_K3_W22.fig')
saveas(gcf,[pic_path,'tfMRI_K3_W22.png'])
 
open('tfMRI_1_K3_W26.fig')
saveas(gcf,[pic_path,'tfMRI_K3_W26.png'])

open('tfMRI_1_K3_W30.fig')
saveas(gcf,[pic_path,'tfMRI_K3_W30.png'])

open('tfMRI_1_K3_W34.fig')
saveas(gcf,[pic_path,'tfMRI_K3_W34.png'])
 
open('tfMRI_1_K4_W30.fig')
saveas(gcf,[pic_path,'tfMRI_K4_W30.png'])
 
open('tfMRI_1_K5_W30.fig')
saveas(gcf,[pic_path,'tfMRI_K5_W30.png'])
cd ..

% save local fitting figures

cd 'Local_fitting_real_LR'
open('localfit_real.fig')
saveas(gcf,[pic_path,'localfit_real.png'])
cd ..


cd 'Local_fitting_synthetic/n0.5623';
open('localfit_synthetic.fig')
saveas(gcf,['../',pic_path,'localfit_synthetic_n0_5623.png'])
cd ../..

% save local inference synthetic figures
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

% save local inference real tfMRI figures
cd 'Local_inference_real_LR'
open('Labels_real.fig')
saveas(gcf,[pic_path,'Labels_real.svg'])

open('Mean_real.fig')
copyfile('Mean_real.svg',[pic_path,'Mean_real.svg'])

open('Variance_real.fig')
copyfile('Variance_real.svg',[pic_path,'Variance_real.svg'])
% save BrainNet Viewer figures 
cd ..
close all

cd 'Local_inference_real_LR/sparsity_10'

open('network_t41.fig')
saveas(gcf,['../',pic_path,'network_t41.jpeg'])

open('network_t76.fig')
saveas(gcf,['../',pic_path,'network_t76.jpeg'])

open('network_t107.fig')
saveas(gcf,['../',pic_path,'network_t107.jpeg'])

open('network_t140.fig')
saveas(gcf,['../',pic_path,'network_t140.jpeg'])

open('network_t175.fig')
saveas(gcf,['../',pic_path,'network_t175.jpeg'])

open('network_t206.fig')
saveas(gcf,['../',pic_path,'network_t206.jpeg'])

open('network_t239.fig')
saveas(gcf,['../',pic_path,'network_t239.jpeg'])

open('network_t278.fig')
saveas(gcf,['../',pic_path,'network_t278.jpeg'])

open('network_t306.fig')
saveas(gcf,['../',pic_path,'network_t306.jpeg'])

open('network_t334.fig')
saveas(gcf,['../',pic_path,'network_t334.jpeg'])

open('network_t375.fig')
saveas(gcf,['../',pic_path,'network_t375.jpeg'])

close all
% save cricos figures
cd 'circos_configuration/brain/circos_t41/'
copyfile('circos.png',['../../../../../../pictures/','circos_t41.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t76/'
copyfile('circos.png',['../../../../../../pictures/','circos_t76.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t107/'
copyfile('circos.png',['../../../../../../pictures/','circos_t107.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t140/'
copyfile('circos.png',['../../../../../../pictures/','circos_t140.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t175'
copyfile('circos.png',['../../../../../../pictures/','circos_t175.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t206/'
copyfile('circos.png',['../../../../../../pictures/','circos_t206.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t239'
copyfile('circos.png',['../../../../../../pictures/','circos_t239.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t278'
copyfile('circos.png',['../../../../../../pictures/','circos_t278.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t306/'
copyfile('circos.png',['../../../../../../pictures/','circos_t306.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t334'
copyfile('circos.png',['../../../../../../pictures/','circos_t334.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t375'
copyfile('circos.png',['../../../../../../pictures/','circos_t375.png'])
cd ../../../../..




