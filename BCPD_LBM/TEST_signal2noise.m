% Test signal to noise ratio

% Version 1.0 
% Copyright (c) 2020, Lingbin Bian
% 28-Sep-2020
%--------------------------------------------------------------------------
clear
clc

%--------------------------------------------------------------------------
% simulated time series
T=180; % time course
N=35; % the number of nodes
K_seg=[3 4 5 3 5 4 3]; % the number of communities of data segments
changepoints=[20 50 80 100 130 160];
n_s=1.3;
M=1;  % number of simulations 
S=1;
signal_noise_ratio=zeros(S,1);
sn_ratio = signal2noise(T,N,changepoints,K_seg,n_s,M);

for s=1:S
   signal_noise_ratio(s,1)=mean(mean(sn_ratio))
end

10*log10(1/n_s^2)

% 
% nhist = 50;
% h = histp(signal_noise_ratio(:),nhist);
% set(h,'facecolor',[1 0.5 0],'edgecolor',[1 0.3 0]);
% set(get(h,'Children'),'Facealpha',0.7);