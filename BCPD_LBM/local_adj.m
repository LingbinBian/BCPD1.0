function [adj,true_latent,K_seg]=local_adj(datatype,subj,session_n,n_s,localmin_t,K_min,W,vari,hrf_ind)
% This function calculates the local adjacency matrice of single subject.
% 
% Input: datatype: 1 real, 2 synthetic 
%        subj: subject ID
%        session_n: 1: LR, 2 RL (only for real data)
%        localmin_t: a vector of time points with respect to local minima
%        K_min: a vector containing number of communities of states
%        W: half of window size
% Output: adj: local adjacency matrix
%
% Version 1.0
% 11-Jun-2020
% Copyright (c) 2020, Lingbin Bian
% -------------------------------------------------------------------------
% load data


if datatype==1
    Timeseries=load_realts(subj,session_n,K_min);
    true_latent='none';
    K_seg=K_min;
elseif datatype==0
    [Timeseries,latent_seg,K_seg]=load_simults(subj,n_s,vari,hrf_ind);
    true_latent=latent_seg;
end

L_localmin=length(localmin_t);   % number of states

adj=cell(1,L_localmin);  % each cell is an adjacency matrix

for j=1:L_localmin
    adj{j}=adjac_generator(localmin_t(j));
end


% Nested functions---------------------------------------------------------
% This function generates the Adjacency matrix within the window at time t
    function [ Adj] = adjac_generator(t)
        signal_inW=Timeseries.signal(:,t-W:t+W-1)';
        covari=cov(signal_inW);
        Adj=corrcov(covari);
%        Adj=corrcoef(signal_inW);
%        Adj=threshold_absolute(corre,0.2);
%         for i=1:N
%             for j=1:N
%                 if Adj(i,j)>=0.2
%                     Adj(i,j)=1;
%                 else
%                     Adj(i,j)=0;
%                 end
%             end
%         end        
    end
end

