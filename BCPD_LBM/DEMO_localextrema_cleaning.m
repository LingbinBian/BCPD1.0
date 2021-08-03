% DEMO local extrema cleaning

% clear
% clc
% 
% load('Global_fitting_real/tfMRI_1_K3_W30/localextrema.mat');
% [storage]=localextre_cleaning(localmax_ave,localmin_ave);
% 
% data_path = fileparts(mfilename('fullpath'));
% if isempty(data_path), data_path = pwd; end
% 
% localextre_path=fullfile(data_path,'Global_fitting_real/tfMRI_1_K3_W30/localextrema_removed');
% save(localextre_path,'storage');


%--------------------------------------------------------------------------
clear
clc
load('Global_fitting_real/tfMRI_2_K3_W30/localextrema.mat');
[storage]=localextre_cleaning(localmax_ave,localmin_ave,8);

data_path = fileparts(mfilename('fullpath'));
if isempty(data_path), data_path = pwd; end

localextre_path=fullfile(data_path,'Global_fitting_real/tfMRI_2_K3_W30/localextrema_removed');
save(localextre_path,'storage');