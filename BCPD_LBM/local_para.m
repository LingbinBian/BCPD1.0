function [esti_blockmean,esti_blockvariance]=local_para(esti_grouplabel,adj,localmin_t,K_min,S)
% This function estimates block mean and variance.
% 
% Input: esti_grouplabel: group estimation of labels
%        datatype: 1 real, 2 synthetic 
%        subj: subject ID
%        session_n: 1: LR, 2 RL (only for real data)
%        localmin_t: a vector of time points with respect to local minima
%        K_min: a vector containing number of communities of states
%        W: half of window size
% Output: esti_blockmean: estimation of block mean, average of mean
%         esti_variance: estimation of block variance, average of variance
%
% Version 1.0
% 23-Feb-2020
% Copyright (c) 2020, Lingbin Bian
% -------------------------------------------------------------------------
% load data
% if datatype==1
%     Timeseries=load_realts(subj,session_n,K_min);
% elseif datatype==0
%     Timeseries=load_simults(subj);
% end

N=35;
  % replication number
L_localmin=length(localmin_t);   % number of states


local_parameter=cell(1,L_localmin);  % each cell is a struct containing model parameters
cell_blockmean=cell(S,L_localmin);  % a cell containing replications of block mean
cell_blockvariance=cell(S,L_localmin);  % a cell containing replications of block variance
esti_blockmean=cell(1,L_localmin);  % estimated block mean at each state
esti_blockvariance=cell(1,L_localmin);  % estimated block variance at each state


for j=1:L_localmin
    local_parameter{1,j}=localpara_inference(adj{j},esti_grouplabel(:,j),K_min(j),N,S);
end

for j=1:L_localmin
   for s=1:S
       para=local_parameter{1,j}(s);
       cell_blockmean{s,j}=para.Mean;
       cell_blockvariance{s,j}=para.Vari;
   end
end

Mean_kl=zeros(S,1); % store temporal single mean element of replications 
for t=1:L_localmin
    for i=1:K_min(t)
        for j=1:K_min(t)
            for s=1:S
                Mean_kl(s,1)=cell_blockmean{s,t}(i,j);
            end
            esti_blockmean{1,t}(i,j)=mean(Mean_kl);
        end
    end
end

Variance_kl=zeros(S,1); % store temporal single variance element of replications
for t=1:L_localmin
    for i=1:K_min(t)
        for j=1:K_min(t)
            for s=1:S
                Variance_kl(s,1)=cell_blockvariance{s,t}(i,j);
            end
            esti_blockvariance{1,t}(i,j)=mean(Variance_kl);
        end
    end
end


end

