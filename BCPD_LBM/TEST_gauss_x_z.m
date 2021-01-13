clear
clc
close all
load('/Users/lingbinbian/Documents/MATLAB_Code/Weighted_Stochastic_Block_Model_Gibbs/WStochasticBM_Gibbs_19_8_22/Data/T_300_CP_120_200_N_16_K_3.mat');
Timeseries=T_300_CP_120_200_N_16_K_3;
W=24; % Half of the window size
M=24;    % Margin size
[AdjaCell,netpara]=adjacencyCellArray(Timeseries,W,M);

x=AdjaCell{M+1};
z_1=Timeseries.LatentLabels
K=Timeseries.K;
N=Timeseries.N;
%z_2=latent_generator(N,K);
z_1(2,1)=3
gauss_x_z(z_1(:,1),x,K,N)

%------------------------------------------------------------------------
% log(p(x|z))
    function [ P_x_z] = gauss_x_z(z,x,K,N)   % O(K*N+K^2+N^2)
        W=zeros(K,K);     % number of elements in the block
        w_sum=zeros(K,K);    % weights in the block
        w_sumsq=zeros(K,K);   % weight^2 in the block
        m_k=zeros(K,1);   % number of nodes in the cluster     
    
        nu=3;
        rho=0.2;
        xi=0.2;
        kappa_sq=1;
        
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
        
        P_x_z=zeros(K,K);
        for k=1:K
            for l=1:K   
                A=(0.5*nu)*log(rho);          
                B=gammaln(0.5*(W(k,l)+nu));

                C=(0.5*W(k,l))*log(pi);
                D=gammaln(0.5*nu);
                E=log((W(k,l)*kappa_sq+1)^0.5);
                F=(-0.5*(W(k,l)+nu))*log((w_sumsq(k,l)-(kappa_sq*((w_sum(k,l)+xi/kappa_sq)^2))/(W(k,l)*kappa_sq+1)+xi^2/kappa_sq+rho));
                P_x_z(k,l)=A+B-C-D-E+F;

%                     P_x_z(k,l)=log(rho^(0.5*nu))+gammaln(0.5*(W(k,l)+nu))...
%                         -log(pi^(0.5*W(k,l)))-gammaln(0.5*nu)-log((W(k,l)*kappa_sq+1)^0.5)...
%                         +log((w_sumsq(k,l)-(kappa_sq*((w_sum(k,l)+xi/kappa_sq)^2))/(W(k,l)*kappa_sq+1)+xi^2/kappa_sq+rho)^(-0.5*(W(k,l)+nu)));  % p(x|z)
            end
        end
     
        P_x_z=sum(sum(P_x_z)); % log(p(x|z))
    end
