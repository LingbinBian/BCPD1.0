% This script plots cumulative discrepancy energy (CDE) for extracted time series of 100 unrelated subjects.
%
% Set up parameters
% K: number of communities
% W: half of window for adjacency matrix
% W_s: half of window for cde
%
% Version 1.0
% 21-Feb-2020
% Copyright (c) 2020, Lingbin Bian

clear
clc 

% -------------------------------------------------------------------------
% load data

data_path = fileparts(mfilename('fullpath'));
if isempty(data_path), data_path = pwd; end
subjects=load('subject.txt');
session_n=1;
N_subj=100;
T=405;
K=5;
W=15;
W_s=5;

% -------------------------------------------------------------------------
% plot cumulative discrepancy energy
time_cum=zeros(1,T);
time_cum(W+W_s+1:T-W-W_s)=W+W_s+1:T-W-W_s;
if session_n==1
   changestimuli_time=[7.996,36.132,79.208,107.436,150.512,178.594,221.83,250.045];   % EV of '100307'
   changestimuli_all=[7.996,10.496,35.496,   36.132,38.632,63.632,   79.208,81.708,106.708,   107.436,109.936,134.936,   150.512,153.012,178.012,   178.594,181.094,206.094,   221.83,224.33,249.33,   250.045,252.545,277.545];
end
if session_n==2
   changestimuli_time=[7.997,36.159,79.368,107.463,150.539,178.728,221.95,250.032];
   changestimuli_all=[7.997,10.497,35.497,   36.159,38.659,63.659,   79.368,81.868,106.868,   107.463,109.963,134.963,   150.539,153.039,178.039,   178.728,181.228,206.228,   221.95,224.45,249.45,   250.032,252.532,277.532];
end

changestimuli=round(changestimuli_all./0.72);  % frames of experiment desgin, onset, duration (25s+2.5s)
changestimuli
cde_matrix=zeros(N_subj,T);

figure
for i=1:N_subj
    subid=num2str(subjects(i));
    if session_n==1
      %  subdir_path=fullfile(data_path,'Inference/infer_tfMRI',subid,'inference_WM_LR');
        subdir_path=fullfile(data_path,'Global_fitting_real',['infer_tfMRI','_','K',num2str(K),'_','W',num2str(2*W),],subid,'inference_WM_LR');
        load(fullfile(subdir_path,'infer_LR.mat')); 
    elseif session_n==2
       % subdir_path=fullfile(data_path,'Inference/infer_tfMRI',subid,'inference_WM_RL');
        subdir_path=fullfile(data_path,'Global_fitting_real',['infer_tfMRI','_','K',num2str(K),'_','W',num2str(2*W),],subid,'inference_WM_RL');
        load(fullfile(subdir_path,'infer_RL.mat'));   
    end
    
    cde_matrix(i,:)=cumenergy;
    fprintf('ploting cde, subject: %d\n',i)
    hold on
    scatter(time_cum(W+W_s+1:T-W-W_s),cumenergy(time_cum(W+W_s+1:T-W-W_s)),3,'filled')
    alpha(0.5)
end

for Num=1:length(changestimuli)
   plot([changestimuli(Num),changestimuli(Num)],[min(min(cde_matrix(:,W+W_s+1:T-W-W_s))), max(max(cde_matrix(:,W+W_s+1:T-W-W_s)))],':','Color',[0.25 0.25 0.25],'LineWidth',2.0); 
   hold on
end

ave_cu=mean(cde_matrix);
%ave_cu=trimmean(cde_matrix,10);

hold on
plot(time_cum(W+W_s+1:T-W-W_s),ave_cu(time_cum(W+W_s+1:T-W-W_s)),'Color',[0 0 0],'Linewidth',2.0)
title(['K=',num2str(K),', ','W=',num2str(2*W),', ','W_{s}=',num2str(2*W_s)],'fontsize',16)
xlim([0, T]); % range of x
ylim([min(min(cde_matrix(:,W+W_s+1:T-W-W_s))), max(max(cde_matrix(:,W+W_s+1:T-W-W_s)))]); % range of y
set(gca,'box','on')
% set(gca,'fontsize',14)
set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
xlabel('Time step','fontsize',16)
ylabel('CDE','fontsize',16)
% local maxima and minima of CDE
Lmax = islocalmax(ave_cu);
hold on
% scatter(time_cum(Lmax),ave_cu(Lmax),40,'MarkerEdgeColor',[0 0 0],...
%               'MarkerFaceColor',[1 0 0],...
%               'LineWidth',1.5)
scatter(time_cum(Lmax),ave_cu(Lmax),40,'MarkerEdgeColor',[0 0 0],...
              'MarkerFaceColor',[255, 70, 0]/255,...
              'LineWidth',1.5)
         
Lmin = islocalmin(ave_cu);
hold on
% scatter(time_cum(Lmin),ave_cu(Lmin),40,'MarkerEdgeColor',[0 0 0],...
%               'MarkerFaceColor',[0 0 1],...
%               'LineWidth',1.5)
scatter(time_cum(Lmin),ave_cu(Lmin),40,'MarkerEdgeColor',[0 0 0],...
              'MarkerFaceColor',[51, 161, 201]/255,...
              'LineWidth',1.5)
set(gcf,'unit','centimeters','position',[6 10 14 10])
set(gca,'Position',[.15 .15 .75 .75]);

saveas(gcf,['Global_fitting_real/','tfMRI_',num2str(session_n),'_','K',num2str(K),'_','W',num2str(2*W),'.fig'])
%--------------------------------------------------------------------------
% plot posterior predictive discrepancy
% figure
% ppd_matrix=zeros(N_subj,405);
% for i=1:N_subj
%     subid=num2str(subjects(i));
%     subdir_path=fullfile(data_path,'Inference/infer_tfMRI',subid,'inference_WM_LR');
%     load(fullfile(subdir_path,'infer_LR.mat'));   
%     ppd_matrix(i,:)=discindex;
%     time_ppd=16:390;
%     fprintf('ploting ppd, subject: %d\n',i)
%     hold on
%     scatter(time_ppd,discindex(time_ppd),5,'filled')
%     alpha(0.6)   
% end
% ave_ppd=mean(ppd_matrix);
% %median_ppd=median(ppd_matrix);
% 
% hold on
% plot(time_ppd,ave_ppd(time_ppd),'Color',[0.25 0.25 0.25],'Linewidth',3.0)
% %plot(time_ppd,median_ppd(time_ppd),'Color',[0 0 0],'Linewidth',3.0)
% title('Group Posterior predictive discrepancy index','fontsize',14)
% xlim([0, T]);% range of x
% ylim([min(min((ppd_matrix(:,16:390)))), max(max(ppd_matrix(:,16:390)))]); % range of y
% set(gca,'box','on')
% set(gca,'fontsize',14)
% xlabel('Time step','fontsize',14)
% ylabel('DI','fontsize',14)




