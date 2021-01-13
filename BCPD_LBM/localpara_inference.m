function [localpara_infer]=localpara_inference(adj,esti_label,K,N,S)
% This function infer the block mean and variance of communities for single subject.
%
% Input:
%    adj: adjacency matrix
%    esti_label: estimation of labels
%    K: number of communities
%    N: number of nodes
%    S: replication number
% Output:
%    localpara_infer: a struct containing infered parameters of the network
%
% Version 1.0
% 03-April-2019
% Copyright (c) 2019, Lingbin Bian
% -------------------------------------------------------------------------

% hyper-parameters of prior
nu=3;
rho=0.02;
xi=0;
kappa_sq=1;

Preci=cell(S,1); % block precision matrix
Vari=cell(S,1); % block variance
Mean=cell(S,1); % block mean

for s=1:S
   % sampling model parameters from the posterior conditional on z 
   [Preci{s},Vari{s},Mean{s}]=sampling_para(esti_label,adj); 
end

localpara_infer=struct('Preci', Preci,...
                 'Vari',Vari,...
                 'Mean',Mean,...
                 'S',S);
                          
% Nested functions---------------------------------------------------------
%--------------------------------------------------------------------------

% Sampling mean and variance from the posterior p(u,sigma^2|x,z)
    function [precision,vari,mean] = sampling_para(z,x)  %O(K*N,K^2,N^2)
  
        W=zeros(K,K);     % number of elements in the block
        w_sum=zeros(K,K);    % sum of weights in the block
        w_sumsq=zeros(K,K);  % sum of square in the block
        m_k=zeros(K,1);   % number of nodes in the cluster
        for i=1:N
            m_k(z(i))=m_k(z(i))+1;
        end 
        for k=1:K
            for l=1:K
                if k==l
                    W(k,l)=m_k(k)*(m_k(l)-1);
                else
                    W(k,l)=m_k(k)*m_k(l); % w_kl=m_k*m_l
                end
            end
        end
        for i=1:N
            for j=1:N
                if i~=j
                    w_sum(z(i),z(j))=w_sum(z(i),z(j))+x(i,j);
                    w_sumsq(z(i),z(j))=w_sumsq(z(i),z(j))+x(i,j).^2;
                end
            end
        end   
        vari=zeros(K,K);
        mean=zeros(K,K);
        precision=zeros(K,K);
        for k=1:K
            for l=1:K
                nu_n=nu+W(k,l);
                rho_n=(xi^2)/(kappa_sq)+w_sumsq(k,l)+rho-((xi+w_sum(k,l)*kappa_sq)^2)/(1/kappa_sq+W(k,l));
                precision(k,l)=gamrnd(0.5*nu_n,1/(0.5*(rho_n)));
                vari(k,l)=1/precision(k,l);    % inverse gamma
            end
        end
        vari(isnan(vari))=0;
        for k=1:K
            for l=1:K              
                mean(k,l)=normrnd((xi+w_sum(k,l)*kappa_sq)/(1+W(k,l)*kappa_sq),sqrt((kappa_sq/(1+W(k,l)*kappa_sq))*vari(k,l)));
            end
        end  
    end
%--------------------------------------------------------------------------
end

