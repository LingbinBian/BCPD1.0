#!/bin/bash
# Creat masks corresponding to the coordinates
#
# Version 1.0
# 13-Jan-2020
# Copyright (c) 2020, Lingbin Bian

mkdir ../subjects/CreatMask
cp lmax_zstat1_std_coordinates.txt ../subjects/CreatMask
cd ../subjects/CreatMask
for N in `seq 3 37` ; do
   Line=$(echo $N'p')
   echo $Line
   X_voxel=$(cat lmax_zstat1_std_coordinates.txt | awk '{print $6}' | sed -n $Line)
   Y_voxel=$(cat lmax_zstat1_std_coordinates.txt | awk '{print $7}' | sed -n $Line)
   Z_voxel=$(cat lmax_zstat1_std_coordinates.txt | awk '{print $8}' | sed -n $Line)
   Regionname=$(cat lmax_zstat1_std_coordinates.txt | awk '{print $9 $10}' | sed -n $Line)
   echo $Regionname
   echo $X_voxel
   echo $Y_voxel
   echo $Z_voxel
   fslmaths $FSLDIR/data/standard/MNI152_T1_2mm.nii.gz -mul 0 -add 1 -roi $X_voxel 1 $Y_voxel 1 $Z_voxel 1 0 1 ROI_$Regionname-$X_voxel$Y_voxel$Z_voxel.nii.gz -odt float
   fslmaths ROI_$Regionname-$X_voxel$Y_voxel$Z_voxel.nii.gz -kernel sphere 6 -fmean Sphere_$Regionname-$X_voxel$Y_voxel$Z_voxel.nii.gz -odt float
   fslmaths Sphere_$Regionname-$X_voxel$Y_voxel$Z_voxel.nii.gz -bin Sphere_bin_$Regionname-$X_voxel$Y_voxel$Z_voxel.nii.gz
   # fslmeants -i tfMRI_WM_LR.nii.gz -m Sphere_bin_$Regionname$X_voxel$Y_voxel$Z_voxel.nii.gz
done

ls Sphere_bin_* >> masks.txt
cd ../../Shell_script_control
