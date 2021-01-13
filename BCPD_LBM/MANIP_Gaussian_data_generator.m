% Gaussian time series generator

% Version 1.0 
% Copyright (c) 2019, Lingbin Bian
% 09-Aug-2019
%--------------------------------------------------------------------------
clear
clc
close all
%--------------------------------------------------------------------------
% simulated time series
T=180; % time course
N=35; % the number of nodes
K_seg=[3 4 5 3 5 4 3]; % the number of communities of data segments
%n_s=0.3162;  % 10dB
%n_s=0.5623;  % 5dB
%n_s=1;  % 0dB
%n_s=1.7783;  % -5dB
n_s=3.1623;  % -5dB

changepoints=[20 50 80 100 130 160];
generateSignal(T,N,changepoints,K_seg,n_s);

%--------------------------------------------------------------------------
% Plot network time series 
% plotTimeSeries(Timeseries)
%--------------------------------------------------------------------------
% save data
% data_path = fileparts(mfilename('fullpath'));
% if isempty(data_path), data_path = pwd; end
% data_path=fullfile(data_path,'Data');
% cp=num2str(changepoints(1));
% L=length(changepoints);
% if L>=2
%     for l=2:L
%        cp=[cp,'_',num2str(changepoints(l))];
%     end
% end
% doc_name=['Data_','T_',num2str(T),'_CP_',cp,'_N_',num2str(N),'_K_',num2str(K_seg(1))];
% save(fullfile(data_path,doc_name),'Timeseries')
