function [latent_pos]=locallabel_inference(adj,K,S)
% This function infers the latent labels of communities.
% Input: 
%    adj: adjacency matrix
%    K: number of communities
%    S: replication number
% Output:
%    latent_pos: a S*N matrix containing seeds of latent labels
%                (each row is a latent label vector, with S replications)
%
% Version 1.0
% Copyright (c) 2020, Lingbin Bian
% 27-April-2020
% -------------------------------------------------------------------------
nu=3;
rho=0.02;
xi=0;
kappa_sq=1;        
Itera=1150;
priorpra=struct('nu',nu,...
                'rho',rho,...
                'xi',xi,...
                'kappa_sq',kappa_sq,...
                'Itera',Itera);       
N=length(adj);
latent_pos=zeros(N,S);
latent_chain=MCMC_allocation(adj,K,priorpra); % sampling latent label vector from posterior
burnin_ite=500;
autocorre_time=3; 
for s=1:S
   latent_pos(:,s)=latent_chain(:,burnin_ite+autocorre_time*s);
end
   latent_vector=labelswitch(latent_pos);
   latent_pos=latent_vector';
end

