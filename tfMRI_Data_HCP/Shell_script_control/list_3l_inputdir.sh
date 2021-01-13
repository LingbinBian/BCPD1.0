#!/bin/bash
# Select cope images list 
# 
# Version 1.0
# 13-Jan-2020
# Copyright (c) 2020, Lingbin Bian

cd ../subjects
for subj in `cat subject.txt` ; do

    echo "$subj/MNINonLinear/Results/tfMRI_WM/2nd_level.gfeat/cope14.feat/stats/cope1.nii.gz";
    
done
cd ../Shell_script_control



