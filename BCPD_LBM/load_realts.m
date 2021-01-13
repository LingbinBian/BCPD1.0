function [Timeseries] =load_realts(subid,session_n,K_seg)
% This function loads the real time series from the subdirectories in DATA folder.
% 
% Input: subid: the subject id, eg. '100307'
%        session_n: 1 (session LR), 2 (session RL)
%        K_seg: number of communities
% Output: Timeseries: A struct of time series with parameters
%
% Version 1.0
% 19-Feb-2020
% Copyright (c) 2020, Lingbin Bian
% -------------------------------------------------------------------------
data_path = fileparts(mfilename('fullpath'));
if isempty(data_path), data_path = pwd; end
   if session_n==1
      subdir_path=fullfile(data_path,'Data/real_tfMRI',subid,'timeseries_WM_LR');
   elseif session_n==2
      subdir_path=fullfile(data_path,'Data/real_tfMRI',subid,'timeseries_WM_RL');
   end
   load(fullfile(subdir_path,'timeseries.mat'));
   signal=ROI_timeseries;
   [N,T]=size(ROI_timeseries);  % data matrix size
   Timeseries=struct('name','Real',...
                     'signal',signal,...
                     'changepoint_truth',[],...
                     'LatentLabels',[],...
                     'T',T,...
                     'N',N,...
                     'K_seg',K_seg);

end