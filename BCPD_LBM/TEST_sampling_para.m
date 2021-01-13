% TEST 
% samping mean and variance from posterior distribution
% Version 1.0 | Lingbin Bian, 
% <lingbin.bian@monash.edu>
% School of Mathematics, Monash University
% 06-May-2019

clear
clc
close all
%------------------------------------------------------------------------
% data_path = fileparts(mfilename('fullpath'));
% if isempty(data_path), data_path = pwd; end
% data_path=fullfile(data_path,'Data');
% load(fullfile(data_path,'Data_T_300_CP_100_200_N_16_K_3.mat'));

% data_path = fileparts(mfilename('fullpath'));
% if isempty(data_path), data_path = pwd; end
% data_path=fullfile(data_path,'Data/real_tfMRI/101309/timeseries_WM_LR');
% load(fullfile(data_path,'timeseries.mat'));
% T=405;
% N=35;
% signal=ROI_timeseries;
% K_seg=3;
% Timeseries=struct('name','Real',...
%                   'signal',signal,...
%                   'changepoint_truth',[],...
%                   'LatentLabels',[],...
%                   'T',T,...
%                   'N',N,...
%                   'K_seg',K_seg);
% N=Timeseries.N;
% K=Timeseries.K_seg(1);
% T=Timeseries.T;
% 
% W=16; % Half of the window size
% M=16;    % Margin size
% [AdjaCell,netpara]=adjacencyCellArray(Timeseries,W,M);
% 
% x=AdjaCell{M+50};


%------------------------------------------------------------------------
% nu=5;
% rho=5;
% xi=0.2;
% kappa_sq=0.2;

nu=3;
rho=0.02;
xi=0;
kappa_sq=1; 
        
Itera=200;
priorpra=struct('nu',nu,...
                'rho',rho,...
                'xi',xi,...
                'kappa_sq',kappa_sq,...
                'Itera',Itera); 
%------------------------------------------------------------------------          
Z_chain=gibbs_sampling(x,K,priorpra);
z=Z_chain(:,50);
%------------------------------------------------------------------------
S=1000;
Vari=cell(S,1);
Mean=cell(S,1);
Precision=cell(S,1);
%[Precision,Vari,Mean]=sampling_para(z,x,Timeseries);
for s=1:S
    [Precision{s},Vari{s},Mean{s}]=sampling_para(z,x,Timeseries);
end

Vari_his=zeros(s,K^2);
for k=1:K
    for l=1:K
       for s=1:S
          Vari_his(s,(k-1)*K+l)=Vari{s}(k,l);
       end
    end
end

Mean_his=zeros(s,K^2);
for k=1:K
    for l=1:K
       for s=1:S
          Mean_his(s,(k-1)*K+l)=Mean{s}(k,l);
       end
    end
end

figure
for i=1:K^2
  subplot(K,K,i)
  nhist = 50;
  h = histp(Vari_his(:,i),nhist);
  set(h,'facecolor',[0.24 0.35 0.67],'edgecolor',[0.25 0.41 0.88]);
  set(get(h,'Children'),'Facealpha',0.7);
  title(i) 
  if i==7||i==8||i==9
     xlabel('\sigma^2','fontsize',14)
  end
  if i==1||i==4||i==7
     ylabel('Frequency','fontsize',14)
  end
  set(gca,'fontsize',14)
  hold on
  plot([])
end

figure
title('The block mean with three communities')
for i=1:K^2
  subplot(K,K,i)
  nhist = 50;
  h = histp(Mean_his(:,i),nhist);
  set(h,'facecolor',[0.69 0.19 0.38],'edgecolor',[0.53 0.15 0.34]);
  set(get(h,'Children'),'Facealpha',0.7);
  title(i) 
  if i==7||i==8||i==9
     xlabel('\mu','fontsize',14)
  end
  if i==1||i==4||i==7
     ylabel('Frequency','fontsize',14)
  end
  set(gca,'fontsize',14)
  hold on
end
% subplot(3,3,3)
% nhist = 50;
% h = histp(Vari_his(:,1),nhist);
% set(h,'facecolor',[1 0.5 0],'edgecolor',[1 0.3 0]);
% set(get(h,'Children'),'Facealpha',0.7);
% hold on
% 
% subplot(3,3,4)
% nhist = 50;
% h = histp(Vari_his(:,2),nhist);
% set(h,'facecolor',[1 0.5 0],'edgecolor',[1 0.3 0]);
% set(get(h,'Children'),'Facealpha',0.7);
% hold on





% subplot(4,1,3)
% nhist = 50;
% h = histp(Mean_his(:,1),nhist);
% set(h,'facecolor',[1 0.5 0],'edgecolor',[1 0.3 0]);
% set(get(h,'Children'),'Facealpha',0.7);
% hold on
% 
% 
% subplot(4,1,4)
% nhist = 50;
% h = histp(Mean_his(:,2),nhist);
% set(h,'facecolor',[1 0.5 0],'edgecolor',[1 0.3 0]);
% set(get(h,'Children'),'Facealpha',0.7);
% hold on

% 


% Tested function -----------------------------------------------------------------------------------
% Sampling mean and variance from the posterior p(mu,sigma^2|x,z)
    function [ precision,vari,mean ] = sampling_para(z,x,Timeseries)  %O(K*N,K^2,N^2)
        % The density of the blocks
        % K: the number of communities
     nu=3;
     rho=0.02;
     xi=0;
     kappa_sq=1; 
        
        N=Timeseries.N;
        K=Timeseries.K_seg(1);
        
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
       % vari(isnan(vari))=0;
        for k=1:K
            for l=1:K                
                mean(k,l)=normrnd((xi+w_sum(k,l)*kappa_sq)/(1+W(k,l)*kappa_sq),sqrt((kappa_sq/(1+W(k,l)*kappa_sq))*vari(k,l)));
            end
        end  
    end


