% This script saves the pictures of evaluating the inter-individual
% variation of CDE for SNR-10dB

% Version 1.0
% 10-July-2021
% Copyright (c) 2021, Lingbin Bian

clear
clc
close all

% destination file

mkdir ../pictures_CDE_SNR10
pic_path='../../pictures_CDE_SNR10/';
  
% save CDE and local extreme figures

%--------------------------------------------------------------------------
% Various SNR
cd 'Inter_ind_vari';

%--------------------------------------------------------------------------
open('SNR10_DIIV0_cde.fig')
saveas(gcf,[pic_path,'SNR10_DIIV0_cde.png'])

open('SNR10_DIIV5_cde.fig')
saveas(gcf,[pic_path,'SNR10_DIIV5_cde.png'])

open('SNR10_DIIV10_cde.fig')
saveas(gcf,[pic_path,'SNR10_DIIV10_cde.png'])

% -------------------------------------------------------------------------
open('SNR10_DIIV0_local_extreme.fig')
saveas(gcf,[pic_path,'SNR10_DIIV0_local_extreme.png'])

open('SNR10_DIIV5_local_extreme.fig')
saveas(gcf,[pic_path,'SNR10_DIIV5_local_extreme.png'])

open('SNR10_DIIV10_local_extreme.fig')
saveas(gcf,[pic_path,'SNR10_DIIV10_local_extreme.png'])

%--------------------------------------------------------------------------
open('SNR10_DIIV0_hrf_cde.fig')
saveas(gcf,[pic_path,'SNR10_DIIV0_hrf_cde.png'])

open('SNR10_DIIV5_hrf_cde.fig')
saveas(gcf,[pic_path,'SNR10_DIIV5_hrf_cde.png'])

open('SNR10_DIIV10_hrf_cde.fig')
saveas(gcf,[pic_path,'SNR10_DIIV10_hrf_cde.png'])

%--------------------------------------------------------------------------

open('SNR10_DIIV0_hrf_local_extreme.fig')
saveas(gcf,[pic_path,'SNR10_DIIV0_hrf_local_extreme.png'])

open('SNR10_DIIV5_hrf_local_extreme.fig')
saveas(gcf,[pic_path,'SNR10_DIIV5_hrf_local_extreme.png'])

open('SNR10_DIIV10_hrf_local_extreme.fig')
saveas(gcf,[pic_path,'SNR10_DIIV10_hrf_local_extreme.png'])


% -------------------------------------------------------------------------
% Visualize time deviation
open('SNR10_DIIV_max.fig')
saveas(gcf,[pic_path,'SNR10_DIIV_max.png'])

open('SNR10_DIIV_min.fig')
saveas(gcf,[pic_path,'SNR10_DIIV_min.png'])


cd ..











