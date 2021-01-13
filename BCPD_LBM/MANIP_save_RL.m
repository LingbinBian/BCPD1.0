% This script saves all the pictures in supplementary information

% Version 1.0
% 5-November-2020
% Copyright (c) 2020, Lingbin Bian

clear
clc
close all


% destination file

mkdir ../pictures_RL
mkdir ../pictures_RL/sparsity_10
mkdir ../pictures_RL/sparsity_20
mkdir ../pictures_RL/sparsity_30
pic_path='../../pictures_RL/';

cd 'Global_fitting_real';

open('tfMRI_2_K3_W22.fig')
saveas(gcf,[pic_path,'tfMRI_K3_W22.png'])
 
open('tfMRI_2_K3_W26.fig')
saveas(gcf,[pic_path,'tfMRI_K3_W26.png'])

open('tfMRI_2_K3_W30.fig')
saveas(gcf,[pic_path,'tfMRI_K3_W30.png'])

open('tfMRI_2_K3_W34.fig')
saveas(gcf,[pic_path,'tfMRI_K3_W34.png'])
 
% open('tfMRI_K4_W30.fig')
% saveas(gcf,[pic_path,'tfMRI_K4_W30.png'])
% 
% open('tfMRI_K5_W30.fig')
% saveas(gcf,[pic_path,'tfMRI_K5_W30.png'])
cd ..

cd 'Local_fitting_real_RL'
open('localfit_real.fig')
saveas(gcf,[pic_path,'localfit_real.png'])
cd ..

% save local inference real tfMRI figures
cd 'Local_inference_real_RL'
open('Labels_real.fig')
saveas(gcf,[pic_path,'Labels_real.svg'])

open('Mean_real.fig')
copyfile('Mean_real.svg',[pic_path,'Mean_real.svg'])

open('Variance_real.fig')
copyfile('Variance_real.svg',[pic_path,'Variance_real.svg'])
% save BrainNet Viewer figures 
cd ..

close all

sp_level='sparsity_10';
cd 'Local_inference_real_RL/sparsity_10'

open('network_t41.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t41.jpeg'])

open('network_t77.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t77.jpeg'])

open('network_t99.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t99.jpeg'])

open('network_t139.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t139.jpeg'])

open('network_t175.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t175.jpeg'])

open('network_t209.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t209.jpeg'])

open('network_t236.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t236.jpeg'])

open('network_t275.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t275.jpeg'])

open('network_t305.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t305.jpeg'])

open('network_t334.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t334.jpeg'])

open('network_t376.fig')
saveas(gcf,['../',pic_path,sp_level,'/','network_t376.jpeg'])

close all
% save cricos figures
cd 'circos_configuration/brain/circos_t41/'
copyfile('circos.png',['../../../../',pic_path,sp_level,'/circos_t41.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t77/'
copyfile('circos.png',['../../../../',pic_path,sp_level,'/circos_t77.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t99/'
copyfile('circos.png',['../../../../',pic_path,sp_level,'/circos_t99.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t139/'
copyfile('circos.png',['../../../../',pic_path,sp_level,'/circos_t139.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t175'
copyfile('circos.png',['../../../../',pic_path,sp_level,'/circos_t175.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t209/'
copyfile('circos.png',['../../../../',pic_path,sp_level,'/circos_t209.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t236'
copyfile('circos.png',['../../../../',pic_path,sp_level,'/circos_t236.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t275'
copyfile('circos.png',['../../../../',pic_path,sp_level,'/circos_t275.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t305/'
copyfile('circos.png',['../../../../',pic_path,sp_level,'/circos_t305.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t334'
copyfile('circos.png',['../../../../',pic_path,sp_level,'/circos_t334.png'])
cd ../../..

cd 'circos_configuration/brain/circos_t376'
copyfile('circos.png',['../../../../',pic_path,sp_level,'/circos_t376.png'])
cd ../../../../..



