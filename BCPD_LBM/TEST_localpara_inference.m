clear
clc
close all

data_path = fileparts(mfilename('fullpath'));
if isempty(data_path), data_path = pwd; end

Test_path=fullfile(data_path,'Test');
load(fullfile(Test_path,'test.mat'));

N=length(z);
K=length(Mean);
S=20000;
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

Vari_his=zeros(s,K^2);
Vari_orig=zeros(1,K^2);
Vari_estimate=zeros(1,K^2);
for k=1:K
    for l=1:K
       for s=1:S
          Vari_his(s,(k-1)*K+l)=cell_blockvariance{s}(k,l);
       end
         Vari_orig(1,(k-1)*K+l)=Vari(k,l);
         Vari_estimate(1,(k-1)*K+l)=esti_blockvariance(k,l);
    end
end

Mean_his=zeros(s,K^2);
Mean_orig=zeros(1,K^2);
Mean_estimate=zeros(1,K^2);
for k=1:K
    for l=1:K
       for s=1:S
          Mean_his(s,(k-1)*K+l)=cell_blockmean{s}(k,l);
       end
       Mean_orig(1,(k-1)*K+l)=Mean(k,l);
       Mean_estimate(1,(k-1)*K+l)=esti_blockmean(k,l);
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
     xlabel('\sigma^2','fontsize',16)
  end
  if i==1||i==4||i==7
     ylabel('Frequency','fontsize',16)
  end
  
  set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
  hold on
  plot([Vari_orig(1,i) Vari_orig(1,i)],ylim,':','Color',[0 0.79 0.34],'LineWidth',4.0)
  plot([Vari_estimate(1,i) Vari_estimate(1,i)],ylim,':','Color',[0 0 0],'LineWidth',3.0)
  hold on
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
     xlabel('\mu','fontsize',16)
  end
  if i==1||i==4||i==7
     ylabel('Frequency','fontsize',16)
  end
  set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
  hold on
  plot([Mean_orig(1,i) Mean_orig(1,i)],ylim,':','Color',[0 0.79 0.34],'LineWidth',4.0)
  plot([Mean_estimate(1,i) Mean_estimate(1,i)],ylim,':','Color',[0 0 0],'LineWidth',3.0)
  hold on
end




