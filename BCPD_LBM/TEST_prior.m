% TEST 
% test the prior parameters of the block
% Version 1.0 | Lingbin Bian, 
% <lingbin.bian@monash.edu>
% School of Mathematics, Monash University
% 06-May-2019
clear
clc
close all
%----------------------------------------------------------------------
% prior parameters tested
% nu=3;
% rho=0.02;
% xi=0;
% kappa_sq=10; 
nu=3;
rho=0.02;
xi=0;
kappa_sq=1; 

% nu=3;
% rho=1;
% xi=0.2;
% kappa_sq=0.1;
%----------------------------------------------------------------------
N=1000;
vari=zeros(N,1);
mean=zeros(N,1);

for i=1:N
    vari(i)=gamrnd(nu/2,1/(rho/2));    % gamma random variable
    vari(i)=1/vari(i);      % variance (inverse gamma random variable)
    mean(i)=normrnd(xi,sqrt(kappa_sq*vari(i)));    % mean (normal)
end
%----------------------------------------------------------------------
subplot(2,1,1)
nhist = 50;
h = histp(vari(:),nhist);
set(h,'facecolor',[1 0.5 0],'edgecolor',[1 0.3 0]);
set(get(h,'Children'),'Facealpha',0.7);
hold on

%[theta(2,:),marg_pdf_b1(:)]=sort_incr(theta(2,:),marg_pdf_b1(:));
% theta_1 marginal
subplot(2,1,2)
nhist = 50;
h = histp(mean(:),nhist);
set(h,'facecolor',[1 0.5 0],'edgecolor',[1 0.3 0]);
set(get(h,'Children'),'Facealpha',0.7);
hold on





