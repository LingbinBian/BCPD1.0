#!bin/bash
# Extract the time series using the masks

# Version 1.0
# 15-Feb-2020
# Copyright (c) 2020, Lingbin Bian

mkdir ../data_timeseries
cd ../subjects
for subj in `cat subject.txt` ; do
   mkdir ../data_timeseries/$subj
   mkdir ../data_timeseries/$subj/timeseries_WM_LR
   mkdir ../data_timeseries/$subj/timeseries_WM_RL
done
cd ../Shell_script_control

cd ../subjects
for subj in `cat subject.txt` ; do
   cd CreatMask
   for mask in `cat masks.txt`;do
      timeseries_LR=$(fslmeants -i ../$subj/MNINonLinear/Results/tfMRI_WM_LR/1st_LR.feat/filtered_func_data.nii.gz --eig -m $mask)
      echo $timeseries_LR >> ../../data_timeseries/$subj/timeseries_WM_LR/$mask.txt
      
      timeseries_RL=$(fslmeants -i ../$subj/MNINonLinear/Results/tfMRI_WM_RL/1st_RL.feat/filtered_func_data.nii.gz --eig -m $mask)
      echo $timeseries_RL >> ../../data_timeseries/$subj/timeseries_WM_RL/$mask.txt
     #  echo $timeseries >> /Users/lingbinbian/Downloads/tfMRI_Data_HCP/subjects/100307/MNINonLinear/Results/tfMRI_WM_LR/$mask.txt
   done  
   cd ..
done 
cd ../Shell_script_control