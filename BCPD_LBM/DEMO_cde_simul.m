% This script analyzes the cumulative discrepancy energy (CED) for synthetic time series.
%
%
% Version 1.0
% 21-Feb-2020
% Copyright (c) 2020, Lingbin Bian

clear
clc 

% -------------------------------------------------------------------------
% Set up parameters

N_subj=100;       % number of subjects
T=180;            % time course
K=6;              % number of communities
W=10;             % half of window size (time serise to PPDI)  
n_s=0.3162;       % variance of noise, 0.3162(10dB), 0.5623(SNR=5dB), 1(0dB), 1.7783(-5dB)
snr=10;
W_s=5;            % half of window size (PPDI to CDE)
vari=10;           % degree of inter-individual variation of community structure
hrf_ind=0;        % haemodynamic response function 1: active, 0: inactive


% -------------------------------------------------------------------------
% load data

data_path = fileparts(mfilename('fullpath'));
if isempty(data_path), data_path = pwd; end
subjects=load('synthetic_id.txt');


%--------------------------------------------------------------------------
% plot cumulative discrepancy energy
time_cum=zeros(1,T);
time_cum(W+W_s+1:T-W-W_s)=W+W_s+1:T-W-W_s;
changepoint=[20,50,80,100,130,160];
cde_matrix=zeros(N_subj,T);
localmax_subj=cell(N_subj,1);
localmin_subj=cell(N_subj,1);


figure
for i=1:N_subj
    subid=num2str(subjects(i));
   % subdir_path=fullfile(data_path,'Inference/infer_simulated',subid);

    if hrf_ind==1
        subdir_path=fullfile(data_path,'Global_fitting_synthetic',['infer_synthetic_subvari_hrf','_K',num2str(K),'_W',num2str(2*W),'_n',num2str(n_s),'_v',num2str(vari)],subid);
    else
        subdir_path=fullfile(data_path,'Global_fitting_synthetic',['infer_synthetic_subvari','_K',num2str(K),'_W',num2str(2*W),'_n',num2str(n_s),'_v',num2str(vari)],subid);
    end
   
       
    load(fullfile(subdir_path,'infer_simul.mat')); 
    cde_matrix(i,:)=cumenergy;
    fprintf('ploting cde, subject: %d\n',i)
    

    hold on
    scatter(time_cum(W+W_s+1:T-W-W_s),cumenergy(time_cum(W+W_s+1:T-W-W_s)),5,'filled');
    alpha(0.5)
    %plot(time_cum(W+W_s+1:T-W-W_s),cumenergy(time_cum(W+W_s+1:T-W-W_s)),'Linewidth',0.005)
    %alpha(0.5)
    
                      
    
end

for Num=1:length(changepoint)
   h=plot([changepoint(Num),changepoint(Num)],[min(min(cde_matrix(:,W+W_s+1:T-W-W_s))), max(max(cde_matrix(:,W+W_s+1:T-W-W_s)))],':','Color',[0.25 0.25 0.25],'LineWidth',2.0); 
   set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off'); 
   hold on
end
ave_cu=mean(cde_matrix);
hold on
plot(time_cum(W+W_s+1:T-W-W_s),ave_cu(time_cum(W+W_s+1:T-W-W_s)),'Color',[0 0 0],'Linewidth',2.0)

if hrf_ind==1
    title(['SNR=',num2str(snr),', DIIV=',num2str(vari),' with HRF'],'fontsize',16,'fontname', 'times');
else
    title(['SNR=',num2str(snr),', DIIV=',num2str(vari)],'fontsize',16,'fontname', 'times');
end

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

if hrf_ind==0
    saveas(gcf,['Inter_ind_vari/SNR',num2str(snr),'_DIIV',num2str(vari),'_cde.fig']);
elseif hrf_ind==1
    saveas(gcf,['Inter_ind_vari/SNR',num2str(snr),'_DIIV',num2str(vari),'_hrf_cde.fig']);
end           
          
% -------------------------------------------------------------------------

figure
for i=1:N_subj
    subid=num2str(subjects(i));
   % subdir_path=fullfile(data_path,'Inference/infer_simulated',subid);

    if hrf_ind==1
        subdir_path=fullfile(data_path,'Global_fitting_synthetic',['infer_synthetic_subvari_hrf','_K',num2str(K),'_W',num2str(2*W),'_n',num2str(n_s),'_v',num2str(vari)],subid);
    else
        subdir_path=fullfile(data_path,'Global_fitting_synthetic',['infer_synthetic_subvari','_K',num2str(K),'_W',num2str(2*W),'_n',num2str(n_s),'_v',num2str(vari)],subid);
    end
    
       
    load(fullfile(subdir_path,'infer_simul.mat')); 
    cde_matrix(i,:)=cumenergy;
    fprintf('ploting cde, subject: %d\n',i)
    
 
    c_Lmax = islocalmax(cumenergy);
    localmax_subj{i,1}=[time_cum(c_Lmax);cumenergy(c_Lmax)];
    hold on
    scatter(time_cum(c_Lmax),cumenergy(c_Lmax),10,'MarkerEdgeColor',[255, 70, 0]/255,...
                  'MarkerFaceColor',[255, 70, 0]/255)
    c_Lmin = islocalmin(cumenergy);
    localmin_subj{i,1}=[time_cum(c_Lmin);cumenergy(c_Lmin)];
    hold on
    scatter(time_cum(c_Lmin),cumenergy(c_Lmin),10,'MarkerEdgeColor',[51, 161, 201]/255,...
                  'MarkerFaceColor',[51, 161, 201]/255)
                      
    
end

for Num=1:length(changepoint)
   h=plot([changepoint(Num),changepoint(Num)],[min(min(cde_matrix(:,W+W_s+1:T-W-W_s))), max(max(cde_matrix(:,W+W_s+1:T-W-W_s)))],':','Color',[0.25 0.25 0.25],'LineWidth',2.0); 
   set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off'); 
   hold on
end
ave_cu=mean(cde_matrix);
hold on
plot(time_cum(W+W_s+1:T-W-W_s),ave_cu(time_cum(W+W_s+1:T-W-W_s)),'Color',[0 0 0],'Linewidth',2.0)

if hrf_ind==1
    title(['SNR=',num2str(snr),', DIIV=',num2str(vari),' with HRF'],'fontsize',16,'fontname', 'times');
else
    title(['SNR=',num2str(snr),', DIIV=',num2str(vari)],'fontsize',16,'fontname', 'times');
end

xlim([0,T]);% range of x
ylim([min(min(cde_matrix(:,W+W_s+1:T-W-W_s))), max(max(cde_matrix(:,W+W_s+1:T-W-W_s)))]); % range of y
set(gca,'box','on')
%set(gca,'fontsize',16)
set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
xlabel('Time step','fontsize',16)

ylabel('Extremum value','fontsize',16)

set(gcf,'unit','centimeters','position',[6 10 14 10])
set(gca,'Position',[.15 .15 .75 .75]);
set(gca,'xtick',0:20:T)
Lmax = islocalmax(ave_cu);
localmax_ave=[time_cum(Lmax);ave_cu(Lmax)];
hold on
scatter(time_cum(Lmax),ave_cu(Lmax),40,'MarkerEdgeColor',[0 0 0],...
              'MarkerFaceColor',[255, 70, 0]/255,...
              'LineWidth',1.5)
Lmin = islocalmin(ave_cu);
localmin_ave=[time_cum(Lmin);ave_cu(Lmin)];
hold on
scatter(time_cum(Lmin),ave_cu(Lmin),40,'MarkerEdgeColor',[0 0 0],...
              'MarkerFaceColor',[51, 161, 201]/255,...
              'LineWidth',1.5)
if hrf_ind==0
    saveas(gcf,['Inter_ind_vari/SNR',num2str(snr),'_DIIV',num2str(vari),'_local_extreme.fig']);
elseif hrf_ind==1
    saveas(gcf,['Inter_ind_vari/SNR',num2str(snr),'_DIIV',num2str(vari),'_hrf_local_extreme.fig']);
end          
                    
% -------------------------------------------------------------------------          
% if local_max_min==0           
%     legend('Subject 1','Subject 2','Subject 3','Subject 4','Subject 5')    
% else
%     legend('Local maxima','Local minima')   
% end
%--------------------------------------------------------------------------



% if hrf_ind==1
%     if vari==0
% 
%     end
%     if vari==5
%         localmax_ave=[32,62,85,109,141,165;2.46887,2.57714,2.53803,2.51707,2.55298,2.50688];
%         localmin_ave=[45,72,99,126,154;2.34947,2.51095,2.43178,2.4059,2.46996];
%     end
%     if vari==10
%         localmax_ave=[35,59,89,117,139,165;2.5203,2.51752,2.51177,1.51765,2.63632,2.51257];
%         localmin_ave=[45,75,99,126,154;2.44497,2.43738,2.41218,2.4874,2.42178];
%     end
%     
% end
thre=7;
storage=localextre_cleaning(localmax_ave,localmin_ave,thre);

L_removed=length(storage);
t_removed=zeros(1,L_removed);
localextre_removed=zeros(1,L_removed);
for i=1:L_removed
    t_removed(i)=storage{1,i}(1,1);
    localextre_removed(i)=storage{1,i}(2,1);
end
Lmin = islocalmin(localextre_removed);
Lmax = islocalmax(localextre_removed);
Lmax(1)=true;
Lmax(end)=true;
localmax_ave=[t_removed(Lmax);localextre_removed(Lmax)];
localmin_ave=[t_removed(Lmin);localextre_removed(Lmin)];

[vari_storage_max,vari_localmax_location,vari_localmax_cde]=vari_local_max(localmax_subj,localmax_ave,localmin_ave);

data_path = fileparts(mfilename('fullpath'));
if isempty(data_path), data_path = pwd; end

if hrf_ind==0
    vari_location_path=fullfile(data_path,['Inter_ind_vari/','max_location_n',num2str(n_s),'_vari',num2str(vari),'/vari_location']);
    save(vari_location_path,'vari_localmax_location','localmax_ave');

    vari_cde_path=fullfile(data_path,['Inter_ind_vari/','max_cde_n',num2str(n_s),'_vari',num2str(vari),'/vari_cde']);
    save(vari_cde_path,'vari_localmax_cde');
elseif hrf_ind==1
    vari_location_path=fullfile(data_path,['Inter_ind_vari/','max_location_n',num2str(n_s),'_vari',num2str(vari),'_hrf/vari_location']);
    save(vari_location_path,'vari_localmax_location','localmax_ave');

    vari_cde_path=fullfile(data_path,['Inter_ind_vari/','max_cde_n',num2str(n_s),'_vari',num2str(vari),'_hrf/vari_cde']);
    save(vari_cde_path,'vari_localmax_cde');
    
end

[vari_storage_min,vari_localmin_location,vari_localmin_cde]=vari_local_min(localmin_subj,localmax_ave,localmin_ave);

data_path = fileparts(mfilename('fullpath'));
if isempty(data_path), data_path = pwd; end

if hrf_ind==0
    vari_location_path=fullfile(data_path,['Inter_ind_vari/','min_location_n',num2str(n_s),'_vari',num2str(vari),'/vari_location']);
    save(vari_location_path,'vari_localmin_location','localmin_ave');

    vari_cde_path=fullfile(data_path,['Inter_ind_vari/','min_cde_n',num2str(n_s),'_vari',num2str(vari),'/vari_cde']);
    save(vari_cde_path,'vari_localmin_cde');
elseif hrf_ind==1
    vari_location_path=fullfile(data_path,['Inter_ind_vari/','min_location_n',num2str(n_s),'_vari',num2str(vari),'_hrf/vari_location']);
    save(vari_location_path,'vari_localmin_location','localmin_ave');

    vari_cde_path=fullfile(data_path,['Inter_ind_vari/','min_cde_n',num2str(n_s),'_vari',num2str(vari),'_hrf/vari_cde']);
    save(vari_cde_path,'vari_localmin_cde');
end
    









