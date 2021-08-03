function [] = generateSignal_subjvari_hrf(T,N,changepoint,K_seg,n_s,vari,hrf_ind)
% This function generates the Gaussian time series with inter-individual variations 
% and the time series is convloved with the haemodynamic response function (hrf).           
%   Syntax:
%      default:
%      [Timeseries]=generateSignal()
%      standard:
%      [Timeseries]=generateSignal(T,N,changepoint,K_seg)
%   Input:
%      T: time course
%      N: number of nodes
%      changepoint: a row vector containing the location of the true changepoints
%      K_seg: number of communities 
%      n_s: SNR
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

N_sub=100;
sig_hrf=spm_hrf(0.72,[6 16 1 1 6 0 32],16);

Num_seg=length(changepoint)+1;   % number of segments

% setup segment latent labels
latent_seg=zeros(N,Num_seg);
for seg=1:Num_seg
    latent_seg(:,seg)=latent_generator(N,K_seg(seg));
end
ab_seg=ab_generator(Num_seg);


latent_seg_sub=cell(N_sub,1);
ab_sub=cell(N_sub,1);
if vari==0   % if there is no inter-subject variation about labels
    for n=1:N_sub
        latent_seg_sub{n,1}=latent_seg;
        ab_sub{n,1}=ab_seg;
    end
    
else   % if there is inter-subject variation about labels

    for n=1:N_sub
        latent_seg_sub{n,1}=latent_subjvari(N,Num_seg,latent_seg,K_seg,vari);
        ab_sub{n,1}=ab_generator(Num_seg);
    end
end


s_id=load('synthetic_id.txt');

data_path = fileparts(mfilename('fullpath'));
if isempty(data_path), data_path = pwd; end

for n=1:N_sub
    if hrf_ind==1
        subdir=fullfile(data_path,['Data/synthetic_subvari_hrf','_n',num2str(n_s),'_v',num2str(vari)],num2str(s_id(n)));
    else
        subdir=fullfile(data_path,['Data/synthetic_subvari','_n',num2str(n_s),'_v',num2str(vari)],num2str(s_id(n)));
    end    
    cd(subdir);
    Timeseries=single_signal(changepoint,latent_seg_sub{n,1},ab_sub{n,1},Num_seg,sig_hrf,hrf_ind);    
    filename='timeseries.mat';
    save(filename);
    cd ../../..
end



% Nested functions---------------------------------------------------------
% Inter-individual variation for latent label vector

    function [z_subj]=latent_subjvari(N,N_seg,latent_seg,K_seg,d_vari)
        % N: number of nodes
        % N_seg: number of segments
        % latent_seg: segments of latent labels
        % K_seg: segments of number of communities
        % d_vari: number of nodes that are different between subjects
        
        z_subj=zeros(N,N_seg);
        for seg_n=1:N_seg
            z_seg=latent_seg(:,seg_n);
            N_varid=randsample(1:N,d_vari);
            for i=1:d_vari
                z_seg(N_varid(i))=randsample(1:K_seg(seg_n),1);
            end
            z_subj(:,seg_n)=z_seg;               
        end
        
    end
% Inter-individual variation for connectivity

    function [ab]=ab_generator(Num_seg)
        % setup covariance parameters
        ab=zeros(2,Num_seg);
        for seg_n=1:Num_seg
             ab(1,seg_n)=0.8+0.2*rand();
             ab(2,seg_n)=0.2*rand();
        end
    end

% Generating time series
    function [Timeseries]=single_signal(changepoint,latent_seg,ab,Num_seg,sig_hrf,hrf_ind)
        % setup the segment signal
        
        signal=zeros(N,T);
        signal_delay=zeros(N,T+length(sig_hrf)-1);
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
        
        if hrf_ind==1
            for i=1:N
                signal_delay(i,:)=conv(signal(i,:),sig_hrf);
            end
        else
            signal_delay=signal;
        end
        

        Timeseries=struct('name','Gaussian',...
                          'signal',signal_delay,...
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

