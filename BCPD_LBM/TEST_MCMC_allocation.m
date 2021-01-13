% This script tests the MCMC sampler (Gibbs & M3 move)
%
% Version 1.0
% 15-March-2020
% Copyright (c) 2020, Lingbin Bian
% -------------------------------------------------------------------------
clear
clc
% -------------------------------------------------------------------------
% Load data 
% Data type
datatype=0;
if datatype==0
    localmin_t=[36,66,92,116,146];
    subjects=load('synthetic_id.txt');
    W=10;  % half of window size
    K_min=[4,5,3,5,4];
elseif datatype==1
    localmin_t=[41,76,140,175,238,278,333,373];
    subjects=load('subject.txt');
    W=15;  % half of window size
    K_min=[3,3,3,3,3,3,3,3,3,3,3];  % make an assumption of K
end



S=200;  % replication number
N_subj=100;   % number of subjects
N=35;

L_localmin=length(localmin_t);
group_adj=cell(N_subj,1); % group of adjacency matrix
ave_adj=cell(1,L_localmin);  % averaged adjacency matrix

% Local averaged adjacency matrix
for s=1:N_subj
    fprintf('Adjacency of subject: %d\n',s)
    subid=num2str(subjects(s));
    [group_adj{s,1},true_latent]=local_adj(datatype,subid,1,localmin_t,K_min,W);
end

adj_mean=zeros(N_subj,1);
for t=1:L_localmin
    for i=1:N
        for j=1:N
            for s=1:N_subj
                adj_mean(s,1)=group_adj{s,1}{1,t}(i,j);
            end
            ave_adj{1,t}(i,j)=mean(adj_mean);
        end
    end
end

% -------------------------------------------------------------------------
% Adjacency matrix
K=4;

x=ave_adj{1};   % single adjacency matrix

% -------------------------------------------------------------------------
% Prior hyper parameters 
Itera=5000;
nu=3;
rho=0.02;
xi=0;
kappa_sq=1;

priorpra=struct('nu',nu,...
                'rho',rho,...
                'xi',xi,...
                'kappa_sq',kappa_sq,...
                'Itera',Itera); 
            
% -------------------------------------------------------------------------
% Allocation sampler with M3 move

% Multiple simulations
N_sim=2;   % number of simulations
chain_simul=zeros(Itera,1,N_sim);
tic
for i=1:N_sim
 [Z_chain,prob_chain,accep_r_array]=MCMC_allocation(x,K,priorpra);
 chain_simul(:,:,i)=prob_chain';
end
% toc
% figure 
% scatter(1:Itera,accep_r_array(1:Itera),10,'filled')
% title('Acceptance ratio','fontsize',16) 
% xlabel('Iteration','fontsize',14)
% ylabel('r','fontsize',14)
% 
% % -----------------------------------------------------------------------
% % Convergence diagnostic
% PSRF=zeros(1,Itera);  % Potential scale reduction factor
% for k=2:Itera   
%     [PSRF(1,k),NEFF(1,k),V(1,k),W(1,k),B(1,k)]=psrf(chain_simul(1:k,:,:)); 
% end
% figure
% plot(20:Itera,PSRF(20:Itera),'Linewidth',2.0)
% title('Potential Scale Reduction Factor of p(z)','fontsize',16) 
% xlabel('Iteration','fontsize',14)
% ylabel('PSRF','fontsize',14)


% -------------------------------------------------------------------------
% plot adjacency matrix
figure
imagesc(x)
title('Adjacency matrix','fontsize',16) 
xlabel('Node number','fontsize',14)
ylabel('Node number','fontsize',14)
colormap(hot);
colorbar;
set(gca,'position',[0.1,0.2,0.7,0.6] );
set(gca,'fontsize',14)
set(gcf,'unit','normalized','position',[0.1,0.2,0.16,0.27]);
%--------------------------------------------------------------------------
% plot Markov chain
figure
imagesc(Z_chain)
title('MCMC allocation sampler','fontsize',16) 
xlabel('Iteration','fontsize',14)
ylabel('Latent labels','fontsize',14)
colormap(parula(K));
colorbar_community(K);

set(gca,'position',[0.07,0.2,0.8,0.65] );
set(gca,'fontsize',14)
set(gcf,'unit','normalized','position',[0.3,0.2,0.4,0.27]);

% cmap = jet(3)
% %cmap = flipud(cmap(1:4,:));
% %cmap(1,:) = [1,1,1];
% colormap(cmap);
% colorbar
%--------------------------------------------------------------------------

