function [Timeseries,latent_seg,K_seg] =load_simults(simul_id,n_s,vari,hrf_ind)
% This function loads the simulated time series.
%
% Input: simul_id: simulated data id. eg.'1001'
% Output: Timeseries: A struct of time series with parameters

% Version 1.0 
% Copyright (c) 2020, Lingbin Bian
% 19-Feb-2020
% -------------------------------------------------------------------------
data_path = fileparts(mfilename('fullpath'));
if isempty(data_path), data_path = pwd; end
% -------------------------------------------------------

    if hrf_ind==1
        subdir_path=fullfile(data_path,['Data/synthetic_subvari_hrf','_n',num2str(n_s),'_v',num2str(vari)],simul_id);
    else
        subdir_path=fullfile(data_path,['Data/synthetic_subvari','_n',num2str(n_s),'_v',num2str(vari)],simul_id);
    end        

    
load(fullfile(subdir_path,'timeseries.mat'));    
% A struct 'Timeseries' is contained in the workspace
end