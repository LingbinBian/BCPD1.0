% This script saves the pictures of evaluating the inter-individual variation of CDE

% Version 1.0
% 10-July-2021
% Copyright (c) 2021, Lingbin Bian

clear
clc
close all

% destination file

mkdir ../pictures_CDE
pic_path='../../pictures_CDE/';
  
% save CDE and local extreme figures
cd 'Inter_ind_vari';
open('SNR0_DIIV0_cde.fig')
saveas(gcf,[pic_path,'SNR0_DIIV0_cde.png'])

open('SNR0_DIIV0_local_extreme.fig')
saveas(gcf,[pic_path,'SNR0_DIIV0_local_extreme.png'])

open('SNR5_DIIV0_cde.fig')
saveas(gcf,[pic_path,'SNR5_DIIV0_cde.png'])

open('SNR5_DIIV0_hrf_cde.fig')
saveas(gcf,[pic_path,'SNR5_DIIV0_hrf_cde.png'])

open('SNR5_DIIV0_hrf_local_extreme.fig')
saveas(gcf,[pic_path,'SNR5_DIIV0_hrf_local_extreme.png'])

open('SNR5_DIIV0_local_extreme.fig')
saveas(gcf,[pic_path,'SNR5_DIIV0_local_extreme.png'])

open('SNR5_DIIV5_cde.fig')
saveas(gcf,[pic_path,'SNR5_DIIV5_cde.png'])

open('SNR5_DIIV5_hrf_cde.fig')
saveas(gcf,[pic_path,'SNR5_DIIV5_hrf_cde.png'])

open('SNR5_DIIV5_hrf_local_extreme.fig')
saveas(gcf,[pic_path,'SNR5_DIIV5_hrf_local_extreme.png'])

open('SNR5_DIIV5_local_extreme.fig')
saveas(gcf,[pic_path,'SNR5_DIIV5_local_extreme.png'])

open('SNR5_DIIV10_cde.fig')
saveas(gcf,[pic_path,'SNR5_DIIV10_cde.png'])

open('SNR5_DIIV10_hrf_cde.fig')
saveas(gcf,[pic_path,'SNR5_DIIV10_hrf_cde.png'])

open('SNR5_DIIV10_hrf_local_extreme.fig')
saveas(gcf,[pic_path,'SNR5_DIIV10_hrf_local_extreme.png'])

open('SNR5_DIIV10_local_extreme.fig')
saveas(gcf,[pic_path,'SNR5_DIIV10_local_extreme.png'])

open('SNR5_DIIV15_cde.fig')
saveas(gcf,[pic_path,'SNR5_DIIV15_cde.png'])

open('SNR5_DIIV15_local_extreme.fig')
saveas(gcf,[pic_path,'SNR5_DIIV15_local_extreme.png'])


open('SNR5_DIIV_max.fig')
saveas(gcf,[pic_path,'SNR5_DIIV_max.png'])

open('SNR5_DIIV_min.fig')
saveas(gcf,[pic_path,'SNR5_DIIV_min.png'])

open('SNR_DIIV0_max.fig')
saveas(gcf,[pic_path,'SNR_DIIV0_max.png'])

open('SNR_DIIV0_min.fig')
saveas(gcf,[pic_path,'SNR_DIIV0_min.png'])

open('SNR10_DIIV0_cde.fig')
saveas(gcf,[pic_path,'SNR10_DIIV0_cde.png'])

open('SNR10_DIIV0_local_extreme.fig')
saveas(gcf,[pic_path,'SNR10_DIIV0_local_extreme.png'])

cd ..


% save local fitting synthetic figures
cd 'Local_fitting_synthetic/n0.5623_hrf';
open('localfit_synthetic.fig')
saveas(gcf,['../',pic_path,'localfit_synthetic_n0_5623_hrf.png'])
cd ../..

% save local inference synthetic figures
cd 'Local_inference_synthetic/n0.5623_hrf';
open('Labels_synthetic.fig')
saveas(gcf,['../',pic_path,'Labels_synthetic_n0_5623_hrf.svg'])

open('Labels_true.fig')
saveas(gcf,['../',pic_path,'Labels_true_n0_5623_hrf.svg'])

open('Mean_synthetic.fig')
saveas(gcf,['../',pic_path,'Mean_synthetic_n0_5623_hrf.svg'])

open('Variance_synthetic.fig')
saveas(gcf,['../',pic_path,'Variance_synthetic_n0_5623_hrf.svg'])
cd ../..









