% MANIP This script changes the font size of the nodes in BrainNet Viewer
clear
clc
close all

session_n=1;
sparsity=10;

if session_n==1
    cd 'Local_inference_real_LR'
elseif session_n==2
    cd 'Local_inference_real_RL'
end

if sparsity==10
    cd 'sparsity_10'
elseif sparsity==20
    cd 'sparsity_20'
elseif sparsity==30
    cd 'sparsity_30'
end

load('Brainnet_setup_t41.mat')
EC.blb_font.FontSize=24;
save('Brainnet_setup_t41.mat','EC')
clear

load('Brainnet_setup_t76.mat')
EC.blb_font.FontSize=24;
save('Brainnet_setup_t76.mat','EC')
   


cd ../..


