function [] = infer_real(subid,session_n,K_seg,W,S)
% Inference of real data.
% Input: subid: the subject id, eg. '100307'
%        session_n: 1 (session LR), 2 (session RL)
%        K_seg: number of communities
%        W: window size
%        S: reptition time
% 
% Version 1.0 | Lingbin Bian, 
% School of Mathematics, Monash University
% <lingbin.bian@monash.edu>
% 20-Feb-2020
% -------------------------------------------------------------------------

% Load dataset-------------------------------------------------------------
Timeseries=load_realts(subid,session_n,K_seg);

% Adjacency matrix cell array (observations) with respect to time course
[AdjaCell,netpara]=adjacencyCellArray(Timeseries,W,K_seg);

% Discrepancy index
[discindex,para_infer]=discrepindex(AdjaCell,netpara,S);

% Cumulative discrepancy energy
cumenergy=cumdis(discindex,netpara);


% save the inference results of real data
Inference_path = fileparts(mfilename('fullpath'));
if isempty(Inference_path), Inference_path = pwd; end

if session_n==1
    Inference_LR=fullfile(Inference_path,'Global_fitting_real',['infer_tfMRI','_','K',num2str(K_seg),'_','W',num2str(2*W),],subid,'inference_WM_LR/infer_LR');
    save(Inference_LR,'cumenergy','K_seg','W');
    
elseif session_n==2
    Inference_RL=fullfile(Inference_path,'Global_fitting_real',['infer_tfMRI','_','K',num2str(K_seg),'_','W',num2str(2*W),],subid,'inference_WM_RL/infer_RL');
    save(Inference_RL,'cumenergy','K_seg','W');
end
           
end









