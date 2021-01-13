% Manipulation: Infer the simulated data
%
% Version 1.0 
% Copyright (c) 2020, Lingbin Bian
% 20-Feb-2020
% ------------------------------------------------------------------------
% load data
data_path = fileparts(mfilename('fullpath'));
if isempty(data_path), data_path = pwd; end
subjects=load('synthetic_id.txt');
% ------------------------------------------------------------------------

global_K=3;
W=10;   % half window size
S=50;   % replication number

%n_s=0.3162;  % 10dB
%n_s=0.5623;  % 5dB
%n_s=1;  % 0dB
%n_s=1.7783;  % -5dB
n_s=3.1623;  % -5dB


for i=1:100
    subid=num2str(subjects(i));
    fprintf('subject ID = %s\n',subid);
    infer_simul(subid,W,S,global_K,n_s);
end