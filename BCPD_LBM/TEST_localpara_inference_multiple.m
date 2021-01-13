clear
clc
z=[3 2 1 1 2 3 3 3 2 2 1 3 1 2 2 2 1 3 3 3 3]';
Mean=[0.22 0.05 -0.06;...
      0.05 0.30 0.02;...
      -0.06 0.02 0.18];
Vari=[0.1 0.02 0.01;...
      0.02 0.15 0.03;...
      0.01 0.03 0.09];
% Mean=[0.05 0.05 0.05;...
%       0.05 0.05 0.05;...
%       0.05 0.05 0.05];
% Vari=[0.01 0.01 0.01;...
%       0.01 0.01 0.01;...
%       0.01 0.01 0.01];

N=length(z);
K=length(Mean);
S=2000;

M=20;
mean_multi=cell(M);
vari_multi=cell(M);


for m=1:M  
   x=adja_generator(z,Mean,Vari);
   localpara_infer=localpara_inference(x,z,K,N,S);
   
   cell_blockmean=cell(S,1);
   cell_blockvariance=cell(S,1);
   
   for s=1:S
       para=localpara_infer(s);
       cell_blockmean{s}=para.Mean;
       cell_blockvariance{s}=para.Vari;
   end
   
   esti_blockmean=zeros(K,K);
   Mean_kl=zeros(S,1);
   
   for k=1:K
       for l=1:K
           for s=1:S
               Mean_kl(s,1)=cell_blockmean{s}(k,l);
           end
           esti_blockmean(k,l)=mean(Mean_kl);
       end
   end
   mean_multi{m}=esti_blockmean;
   
   
   esti_blockvariance=zeros(K,K);
   Variance_kl=zeros(S,1);
   
   for k=1:K
       for l=1:K
           for s=1:S
               Variance_kl(s,1)=cell_blockvariance{s}(k,l);
           end
           esti_blockvariance(k,l)=mean(Variance_kl);
       end
   end
   vari_multi{m}=esti_blockvariance;
end

mean_esti_multi=zeros(K,K);
vari_esti_multi=zeros(K,K);

mean_candi=zeros(1,M);
vari_candi=zeros(1,M);

for k=1:K
    for l=1:K
        for m=1:M
            mean_candi(m)=mean_multi{m}(k,l);
            vari_candi(m)=vari_multi{m}(k,l);
        end
            mean_esti_multi(k,l)=mean(mean_candi);
            vari_esti_multi(k,l)=mean(vari_candi);
    end
end

Mean_orig=zeros(1,K^2);
Mean_estimate=zeros(1,K^2);
for k=1:K
    for l=1:K
       Mean_orig(1,(k-1)*K+l)=Mean(k,l);
       Mean_estimate(1,(k-1)*K+l)=mean_esti_multi(k,l);
    end
end

Vari_orig=zeros(1,K^2);
Vari_estimate=zeros(1,K^2);
for k=1:K
    for l=1:K
         Vari_orig(1,(k-1)*K+l)=Vari(k,l);
         Vari_estimate(1,(k-1)*K+l)=vari_esti_multi(k,l);
    end
end

figure
for i=1:K^2
  subplot(K,K,i)

  title(i) 
  if i==7||i==8||i==9
     xlabel('\sigma^2','fontsize',14)
  end
  if i==1||i==4||i==7
     ylabel('Frequency','fontsize',14)
  end
  set(gca,'fontsize',14)
  hold on
  plot([Vari_orig(1,i) Vari_orig(1,i)],ylim,':','Color',[0 0.79 0.34],'LineWidth',4.0)
  plot([Vari_estimate(1,i) Vari_estimate(1,i)],ylim,':','Color',[0 0 0],'LineWidth',3.0)
  %xlim([-0.2 0.2]) 
 
  hold on
end

figure
title('The block mean with three communities')
for i=1:K^2
  subplot(K,K,i)

  title(i) 
  if i==7||i==8||i==9
     xlabel('\mu','fontsize',14)
  end
  if i==1||i==4||i==7
     ylabel('Frequency','fontsize',14)
  end
  set(gca,'fontsize',14)
  hold on
  plot([Mean_orig(1,i) Mean_orig(1,i)],ylim,':','Color',[0 0.79 0.34],'LineWidth',4.0)
  plot([Mean_estimate(1,i) Mean_estimate(1,i)],ylim,':','Color',[0 0 0],'LineWidth',3.0)
  %xlim([-1 1]) 
  hold on
end






