# This is a pipeline for tfMRI GLM analysis (FSL, shell), Bayesian change-point detection, and brain state estimation (MATLAB Code).
# If the time seires have been extracted, skip Section 1 and go to Section 2 & 3.
#
# Version 1.0 
# 12-December-2020
# Copyright (c) 2020, Lingbin Bian


# Section 1: Dataset download and GLM analysis

1. Create an empty folder named 'tfMRI_Data_HCP' under a local directory. 
   Under the directory 'tfMRI_Data_HCP': (1) Download the preprocessed working memory tfMRI data from: https://www.humanconnectome.org/.
   (2)create a folder 'Shell_script_control' storing shell scripts for GLM analysis.

2. Under 'Shell_script_control', launch unzip_file.sh (This script unzips the data into a folder named 'subjects'), listing subid in subject.txt under 'subjects'.
   
3. Copy all of the design files under 'Shell_script_control/Design_fsf' to the directory 'subjects'. 
   
   Under 'Shell_script_control', launch tfMRI_registration.sh; after finishing running the Feat of registration only, launch tfMRI_copy_reg.sh   
   (The 1st-level glm analysis results without registration will lack the 'reg' folder under .feat directory, 
    we generate the 'reg' folder by applying registration seperately and copy 'reg' to the .feat directory in the 1st-level analysis).

4. Under 'Shell_script_control', launch tfMRI_1stlevel_analysis.sh (running 1-level analysis).

5. Under 'Shell_script_control', launch tfMRI_2ndlevel_analysis.sh 
   (running 2nd-level analysis, NOTE that in the Design folder, COPE12 and 13 are analysed separately,
    you can add any COPEs of interest in 2nd-level design settings).

6. The 3rd-level (group-level) analysis is run manually. For a specific contrast, open Feat by 'Feat &' or 'Feat_gui &' on MAC, load Design_3rd_level.fsf.
   Click the button Select cope images and click paste in the opend window. 
   Then launch list_3l_inputdir.sh to create a list of directories and copy them to the opened window 
   (you should modify the COPEs of interest in list_3l_inputdir.sh).

7. Create a table via modifying the z-MAX table shown as in 'Shell_script_control/Imax_zstat1_std_coordinates.txt' 
   (the voxel coordinates are obtained from fsleyes).

8. Under 'Shell_script_control', launch readtable.sh to create the 6mm masks correponding to the coordinates of the regions.

9. Under 'Shell_script_control', launch extract_regions.sh to extract the time seires and store them under the directory 'tfMRI_Data_HCP/data_timeseries'.
   (The time series of the regions of individual subjects are stored in the directory of subject id, one .txt file with region name for one brain region,
    NOTE that different from the node numbers in 'Imax_zstat1_std_coordinates.txt', here the node numbers are reordered according to the region names in alphabetical order).
10. Copy the contents in 'tfMRI_Data_HCP/data_timeseries' to 'BCPD_LBM/Data/real_tfMRI'.


# Section 2: Bayesian change-point detection

1. Go to the directory 'BCPD_LBM' (MATLAB Pakage) and launch the script MANIP_real_txt2matrix.m (Convert time series of .txt format to .mat format).

2. Launch MANIP_infer_real.m to do Bayesian chage-point detection, the resulting CDEs are stored under 'Global_fitting_real'.

3. Launch DEMO_cde_real.m to visulize the CDE results.

# Section 3: Brain state estimation

1. Analyse the Group CDE and collect the time steps at local minima.

2. Launch MANIP_local_infer.m to do the local inference.

3. Launch DEMO_local_infer.m to visulize the results.

The next step is to visualise the community architectures by BrainNet and Circos
4. Launch DEMO_brainnet_viewer.m in the package to visualise the brain states by BrainNet Viewer. 

5. Empty the files in '\Local_inference_real\circos_brain_network'.

6. Launch MANIP_circos_brain.m to generate the data file needed for circos visualization.

7. Launch the shell script by: bash delete_firstline.sh to delete the first line of the table in .txt

8. Launch bash circos_config_t.sh to draw the circos figure. 


