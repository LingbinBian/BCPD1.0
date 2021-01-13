% This script plots cumulative discrepancy energy (CED) for synthetic time series.
%
% Set up parameters
% K: number of communites
% W: half of window for adjacency matrix
% W_s: half of window for cde
%
% Version 1.0
% 21-Feb-2020
% Copyright (c) 2020, Lingbin Bian

clear
clc 
close all
% -------------------------------------------------------------------------
% load data

data_path = fileparts(mfilename('fullpath'));
if isempty(data_path), data_path = pwd; end
subjects=load('synthetic_id.txt');
N_subj=100;
T=180;
K=3;
W=10;
n_s=1;
W_s=5;
%--------------------------------------------------------------------------
% plot cumulative discrepancy energy
time_cum=zeros(1,T);
time_cum(W+W_s+1:T-W-W_s)=W+W_s+1:T-W-W_s;
changepoint=[20,50,80,100,130,160];
cde_matrix=zeros(N_subj,T);

figure
for i=1:N_subj
    subid=num2str(subjects(i));
   % subdir_path=fullfile(data_path,'Inference/infer_simulated',subid);
    subdir_path=fullfile(data_path,'Global_fitting_synthetic',['infer_synthetic','_K',num2str(K),'_W',num2str(2*W),'_n',num2str(n_s)],subid);
    load(fullfile(subdir_path,'infer_simul.mat')); 
    cde_matrix(i,:)=cumenergy;
    fprintf('ploting cde, subject: %d\n',i)
    hold on
    scatter(time_cum(W+W_s+1:T-W-W_s),cumenergy(time_cum(W+W_s+1:T-W-W_s)),3,'filled')
    alpha(0.5)
end
for Num=1:length(changepoint)
   plot([changepoint(Num),changepoint(Num)],[min(min(cde_matrix(:,W+W_s+1:T-W-W_s))), max(max(cde_matrix(:,W+W_s+1:T-W-W_s)))],':','Color',[0.25 0.25 0.25],'LineWidth',2.0); 
   hold on
end
ave_cu=mean(cde_matrix);
hold on
plot(time_cum(W+W_s+1:T-W-W_s),ave_cu(time_cum(W+W_s+1:T-W-W_s)),'Color',[0 0 0],'Linewidth',2.0)
title(['K=',num2str(K),', ','W=',num2str(2*W),', ','W_{s}=',num2str(2*W_s)],'fontsize',16,'fontname', 'times')
xlim([0,T]);% range of x
ylim([min(min(cde_matrix(:,W+W_s+1:T-W-W_s))), max(max(cde_matrix(:,W+W_s+1:T-W-W_s)))]); % range of y
set(gca,'box','on')
%set(gca,'fontsize',16)
set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
xlabel('Time step','fontsize',16)
ylabel('CDE','fontsize',16)
set(gcf,'unit','centimeters','position',[6 10 14 10])
set(gca,'Position',[.15 .15 .75 .75]);
set(gca,'xtick',0:20:T)
Lmax = islocalmax(ave_cu);
hold on
scatter(time_cum(Lmax),ave_cu(Lmax),40,'MarkerEdgeColor',[0 0 0],...
              'MarkerFaceColor',[255, 70, 0]/255,...
              'LineWidth',1.5)
Lmin = islocalmin(ave_cu);
hold on
scatter(time_cum(Lmin),ave_cu(Lmin),40,'MarkerEdgeColor',[0 0 0],...
              'MarkerFaceColor',[51, 161, 201]/255,...
              'LineWidth',1.5)
                    
%--------------------------------------------------------------------------
% plot posterior predictive discrepancy
% figure
% ppd_matrix=zeros(N_subj,180);
% for i=1:N_subj
%     subid=num2str(subjects(i));
%     subdir_path=fullfile(data_path,'Inference/infer_simulated',subid);
%     load(fullfile(subdir_path,'infer_simul.mat'));   
%     ppd_matrix(i,:)=discindex;
%     time_ppd=11:170;
%     fprintf('ploting ppd, subject: %d\n',i)
%     hold on
%     scatter(time_ppd,discindex(time_ppd),5,'filled')
%     alpha(0.6)   
% end
% ave_ppd=mean(ppd_matrix);
% %median_ppd=median(ppd_matrix);
% 
% hold on
% plot(time_ppd,ave_ppd(time_ppd),'Color',[0 0 0],'Linewidth',3.0)
% %plot(time_ppd,median_ppd(time_ppd),'Color',[0 0 0],'Linewidth',3.0)
% title('Group Posterior predictive discrepancy index','fontsize',14)
% xlim([0, T]);% range of x
% ylim([min(min((ppd_matrix(:,11:170)))), max(max(ppd_matrix(:,11:170)))]); % range of y
% set(gca,'box','on')
% set(gca,'fontsize',14)
% xlabel('Time step','fontsize',14)
% ylabel('DI','fontsize',14)




