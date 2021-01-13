function [dis_index,para_infer]=posterior_predictive(AdjaCell,netpara,t,S)
% This function calculates the discrepancy index at time step t.
% Input: 
%    AdjaCell: Adjacency matrix cell array
%    netpara: a struct containing network parameters T,N,K,M,W
%    t: candidate change point
%    S: replicated number
% Output:
%    dis_index: discrepancy index
%    para_infer: struct containing infered parameters of the network
%
% Version 1.0 
% Copyright (c) 2019, Lingbin Bian
% 03-April-2019
% -------------------------------------------------------------------------

% nu=5;
% rho=0.2;
% xi=0.2;
% kappa_sq=0.5;

nu=3;
rho=0.02;
xi=0;
kappa_sq=1;        
Itera=1200;

priorpra=struct('nu',nu,...
                'rho',rho,...
                'xi',xi,...
                'kappa_sq',kappa_sq,...
                'Itera',Itera);       
x=AdjaCell{t};
K=netpara.K;
N=netpara.N;
dis_index=zeros(1,S);   % discrepancy index

x_rep=cell(S,1);

Preci=cell(S,1);
Vari=cell(S,1);
Mean=cell(S,1);
latent_pos=cell(S,1);

latent_chain=MCMC_allocation(x,K,priorpra); % sampling latent label vector from posterior
burnin_ite=300;
autocorre_time=3; % autocorrelation time

for s=1:S
  %  latent_chain=gibbs_sampling(x,K,priorpra);
  % latent_pos{s}=latent_chain(:,5);
   latent_pos{s}=latent_chain(:,burnin_ite+autocorre_time*s);
   [Preci{s},Vari{s},Mean{s}]=sampling_para(latent_pos{s},x);  % sampling Pi from the posterior conditional on z 
   x_rep{s}=RepAdj_generator(latent_pos{s},Vari{s},Mean{s}); % generate replicated data
   x_discrepancy=abs(x-x_rep{s});   % discrepancy matrix
   dis_index(s)=sum(sum(x_discrepancy));
   dis_index(s)=dis_index(s)/(N^2);    % disagreement index
end

dis_index=sum(dis_index)/S;    % discrepancy index

para_infer=struct('latent_pos',latent_pos,...
                 'Preci', Preci,...
                 'Vari',Vari,...
                 'Mean',Mean,...
                 'data_rep',x_rep,...
                 'S',S);

% Nested functions------------------------------------------------
%----------------------------------------------------------------

% Sampling mean and variance from the posterior p(u,sigma^2|x,z)
    function [ precision,vari,mean ] = sampling_para(z,x)  %O(K^2+N^2)
        % The density of the blocks
        % K: the number of communities
        W=zeros(K,K);     % number of elements in the block
        w_sum=zeros(K,K);    % number of connections in the block
        w_sumsq=zeros(K,K);
        m_k=zeros(K,1);   % number of nodes in the cluster     
        for i=1:N
            m_k(z(i))=m_k(z(i))+1;
        end 
        for k=1:K
            for l=1:K
                W(k,l)=m_k(k)*m_k(l);    % w_kl=m_k*m_l
            end
        end
        for i=1:N
            for j=1:N
                w_sum(z(i),z(j))=w_sum(z(i),z(j))+x(i,j);
                w_sumsq(z(i),z(j))=w_sumsq(z(i),z(j))+x(i,j).^2;
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
%-----------------------------------------------------------------------

% Generate the replicated adjacency
    function [ x ] = RepAdj_generator( z_latent,Vari,Mean)
        % x ~ P(x|z,K)
        % input:  z_letent: latent labels
        %         Pi: K*K block density
        % output: x: adjacency matrix
        x=zeros(N,N);
        for i=1:N
            for j=1:N
                x(i,j)=normrnd(Mean(z_latent(i),z_latent(j)),sqrt(Vari(z_latent(i),z_latent(j))));  % observation with expectation pi_kl
            end
        end     
    end
%------------------------------------------------------------------------

end

