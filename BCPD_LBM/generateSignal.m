function [] = generateSignal(T,N,changepoint,K_seg,n_s)
% This function generates the Gaussian time series with true change points.           
%   Syntax:
%      default:
%      [Timeseries]=generateSignal()
%      standard:
%      [Timeseries]=generateSignal(T,N,changepoint,K_seg)
%   Input:
%      changepoint: a row vector containing the location of the true changepoints
%      N: number of nodes
%      K: number of communities
%      T: time course 
%   Output:
%      Timeseries: a struct containing the Gaussian data
%
% Version 1.0
% Copyright (c) 2019, Lingbin Bian
% 09-Aug-2019
%--------------------------------------------------------------------------

if nargin==0
    % Default settings   
    N=16; % the number of nodes
    K_seg=[3 3 3]; % the number of communities
    T=300; % Time course
    changepoint=[100,200];
end

checkinput()

Num_seg=length(changepoint)+1;   % number of segments

% setup segment latent labels
latent_seg=zeros(N,Num_seg);
for seg=1:Num_seg
    latent_seg(:,seg)=latent_generator(N,K_seg(seg));
end
% setup covariance parameters
ab=zeros(2,Num_seg);
for seg=1:Num_seg
     ab(1,seg)=0.8+0.2*rand();
     ab(2,seg)=0.2*rand();
end

s_id=load('synthetic_id.txt');

data_path = fileparts(mfilename('fullpath'));
if isempty(data_path), data_path = pwd; end

for n=1:100
    subdir=fullfile(data_path,['Data/synthetic','_n',num2str(n_s)],num2str(s_id(n)));
    cd(subdir);
    Timeseries=single_signal(changepoint,latent_seg,ab,Num_seg);
    filename='timeseries.mat';
    save(filename);
    cd ../../..
end



% Nested functions---------------------------------------------------------
    function [Timeseries]=single_signal(changepoint,latent_seg,ab,Num_seg)
        % setup the segment signal
        signal=zeros(N,T);
        t_ini=1;
        for s=1:Num_seg
            if t_ini>max(changepoint)
                t_end=T;
            else
                t_end=changepoint(s);
            end
            for t=t_ini:t_end
                     mean_e=zeros(N,1);  
                     sigma=diag(n_s^2*ones(N,1));% Noise N(0,1)
                     signal(:,t)=Sig_generator(latent_seg(:,s),ab(:,s))+mvnrnd(mean_e,sigma)';
        %   signal(:,t)=Sig_generator(latent_seg(:,seg),ab(:,seg));
            end
            t_ini=t_end+1;         
        end

        Timeseries=struct('name','Gaussian',...
                          'signal',signal,...
                          'changepoint_truth',changepoint,...
                          'LatentLabels',latent_seg,...
                          'T',T,...
                          'N',N,...
                          'K_seg',K_seg);
    end
                         
% check inputs-------------------------------------------------------------
    function checkinput()  
        % check changepoint
        if ~isnumeric(changepoint)
            error('Invalid change point locations %u, change point should be a row vector',changepoint);
        end
        % check N
        if ~isnumeric(N)
            error('Invalid number of nodes %u',N);
        end
         % check K_seg
        if ~isnumeric(K_seg)
            error('Invalid number of communities %u',K_seg);
        end
        % check T
        if ~isnumeric(T)
            error('Invalid time course length %u',T);
        end              
    end


% Gaussian data generator--------------------------------------------------
    function [ signal] = Sig_generator(z_latent,a_b)
        % generate Gaussian data at one time point
        
        Covar=zeros(N,N);    
        for i=1:N
            for j=1:N
                if i==j
                    Covar(i,j)=1;
                elseif z_latent(i)==z_latent(j)
                    Covar(i,j)=a_b(1);
                else
                    Covar(i,j)=a_b(2);
                end              
            end
        end
        mean=zeros(N,1);
        signal=mvnrnd(mean',Covar)';         
    end
% End of Gaussian data generator-------------------------------------------

end

