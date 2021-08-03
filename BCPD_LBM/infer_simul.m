function [] = infer_simul(subid,W,S,K,n_s,vari,hrf_ind)
% Inference of synthetic data.
% Input: simul_id: the simulated data id, eg. '1001'
%        W: window size
%        S: replication number
% 
% Version 1.0
% Copyright (c) 2020, Lingbin Bian
% 20-Feb-2020
% -------------------------------------------------------------------------

% Load dataset
Timeseries=load_simults(subid,n_s,vari,hrf_ind);

% Adjacency matrix cell array (observations) with respect to time course
[AdjaCell,netpara]=adjacencyCellArray(Timeseries,W,K);

% Discrepancy index
[discindex,para_infer]=discrepindex(AdjaCell,netpara,S);

% Cumulative discrepancy energy
cumenergy=cumdis(discindex,netpara);

% save the inference results of simulated data
Inference_path = fileparts(mfilename('fullpath'));
if isempty(Inference_path), Inference_path = pwd; end


    if hrf_ind==1
        Inference_LR=fullfile(Inference_path,'Global_fitting_synthetic',['infer_synthetic_subvari_hrf','_K',num2str(K),'_W',num2str(2*W),'_n',num2str(n_s),'_v',num2str(vari)],subid,'infer_simul');
    else
        Inference_LR=fullfile(Inference_path,'Global_fitting_synthetic',['infer_synthetic_subvari','_K',num2str(K),'_W',num2str(2*W),'_n',num2str(n_s),'_v',num2str(vari)],subid,'infer_simul');
    end

save(Inference_LR,'cumenergy','K','W');
           
end
