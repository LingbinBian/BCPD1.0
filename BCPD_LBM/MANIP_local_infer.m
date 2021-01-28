% Local inference for discrete states of community architectures.
%
% Set up parameters:
% W: half of window size
% n_s: standard deviation of noise with respect to SNR
% local_t: a vector of time points corresponding to local minima or maxima
% K_min: a vector of model selection
%
%
% Version 1.0
% 12-Jun-2020
% Copyright (c) 2020, Lingbin Bian
% -------------------------------------------------------------------------
clear
clc

% load data
datatype=0;   % 1: real data, 0: synthetic data

if datatype==1
   
    session_n=2;
    
    subjects=load('subject.txt');
    if session_n==1
  %  local_t=[41,76,107,140,175,207,238,278,306,333,375];
        local_t=[41,76,107,140,175,206,239,278,306,334,375];
    end
    if session_n==2
        load('Local_inference_real_LR/label_real.mat')       
        grouplabel_LR=esti_grouplabel;
       
        local_t=[41,77,99,139,175,209,236,275,305,334,376];
    end
   % K_min=[7,7,7,7,7,7,7,7,7,7,7];  % model selection
    K_min=[6,6,6,6,6,6,6,6,6,6,6];  % model selection
    W=10;
    n_s=' ';
    
    
elseif datatype==0
    subjects=load('synthetic_id.txt');    
    n_s=0.3162;  % sigma of noise 
      local_t=[36,67,91,116,147]; % n_s: 0.3162 (SNR=10dB)
    %  local_t=[36,66,91,116,146]; % n_s: 0.5623 (SNR=5dB)
    %  local_t=[36,66,92,116,146]; % n_s: 1 (SNR=0dB)    
    K_min=[4,5,3,4,4];  % model selection
    W=10;    
    session_n=' ';
end

N_subj=100;
N=35;
S=200;
L_localmin=length(local_t);

group_adj=cell(N_subj,1); % group of adjacency matrix
grouplabel=cell(1,L_localmin);  % group of latent labels

esti_grouplabel=zeros(N,L_localmin);
ave_adj=cell(1,L_localmin);  % averaged adjacency matrix
label_compare=cell(1,L_localmin);
vector_compare=zeros(N,2);


% Local averaged adjacency matrix
for s=1:N_subj
    fprintf('Adjacency of subject: %d\n',s)
    subid=num2str(subjects(s));
    [group_adj{s,1},true_latent,K_seg]=local_adj(datatype,subid,session_n,n_s,local_t,K_min,W);
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

for j=1:L_localmin
    grouplabel{1,j}=locallabel_inference(ave_adj{j},K_min(j),S);
end

% Estimation: the most frequent latent label vector of the samples
for j=1:L_localmin
    [Au,ia,ic] = unique(grouplabel{1,j},'rows','stable');
    Counts = accumarray(ic, 1);
    Out = [Counts Au];
    output=sortrows(Out,1,'descend'); % sort in descend
    esti_grouplabel(:,j)=output(1,2:end)'; % the first row is the most frequent

end
if datatype==1
    if session_n==1
      esti_grouplabel=labelswitch(esti_grouplabel);
    end
    if session_n==2
        labelref=zeros(35,22);
        labelref(:,1:11)=grouplabel_LR;
        labelref(:,12:22)=esti_grouplabel;
        labelref=labelswitch(labelref);
        esti_grouplabel=labelref(:,12:22);
    end
end

if datatype==0
    for j=1:L_localmin
        vector_compare(:,2)=esti_grouplabel(:,j);
        vector_compare(:,1)=true_latent(:,j+1);
        vector_compare=labelswitch(vector_compare);
        label_compare{1,j}=vector_compare;        
    end

    for j=1:L_localmin
        esti_grouplabel(:,j)=label_compare{1,j}(:,2);
    end

end

% Estimate the model parameters, mean and variance

[esti_groupmean,esti_groupvariance]=local_para(esti_grouplabel,ave_adj,local_t,K_min,S);

% Visualization: estimation of latent label vector
if datatype==1 
figure  
for t=1:L_localmin
    subplot(1,L_localmin,t)
    visual_labels(esti_grouplabel(:,t),K_seg)
    title('Estimation','fontsize',16)
end
set(gcf,'unit','normalized','position',[0.3,0.2,1.5,0.38]);
if session_n==1
    saveas(gcf,'Local_inference_real_LR/Labels_real.fig')
end
if session_n==2
    saveas(gcf,'Local_inference_real_RL/Labels_real.fig')
end
    
end

if datatype==0
figure  
for t=1:L_localmin
    subplot(1,L_localmin,t)
    visual_labels(label_compare{:,t}(:,2),K_seg)
    title('Estimation','fontsize',16)
end
set(gcf,'unit','normalized','position',[0.3,0.2,0.45,0.38]);

saveas(gcf,['Local_inference_synthetic/','n',num2str(n_s),'/Labels_synthetic.fig'])

figure
for t=1:L_localmin
    subplot(1,L_localmin,t)
    visual_labels(label_compare{:,t}(:,1),K_seg)
    title('True','fontsize',16)
end
set(gcf,'unit','normalized','position',[0.3,0.2,0.45,0.38]);
% saveas(gcf,'Local_inference_synthetic/Labels_true.fig')
saveas(gcf,['Local_inference_synthetic/','n',num2str(n_s),'/Labels_true.fig'])
end

% Visulization: estimation of the block mean
figure
for t=1:L_localmin
    if datatype==1
       subplot(3,(L_localmin+1)/3,t)
    elseif datatype==0
       subplot(2,(L_localmin+1)/2,t)
    end
    visual_matrix(esti_groupmean{1,t},1)
end
if datatype==1
   set(gcf,'unit','normalized','position',[0.3,0.2,3.6,0.8]);
   if session_n==1
      saveas(gcf,'Local_inference_real_LR/Mean_real.fig')
      saveas(gcf,'Local_inference_real_LR/Mean_real.svg')
   end
   if session_n==2
      saveas(gcf,'Local_inference_real_RL/Mean_real.fig')
      saveas(gcf,'Local_inference_real_RL/Mean_real.svg')
   end
   
elseif datatype==0
   set(gcf,'unit','normalized','position',[0.3,0.2,0.5,0.4]);
   saveas(gcf,['Local_inference_synthetic/','n',num2str(n_s),'/Mean_synthetic.fig'])
end

% Visulization: estimation of the block variance
figure
for t=1:L_localmin
    if datatype==1
       subplot(3,(L_localmin+1)/3,t)
    elseif datatype==0
       subplot(2,(L_localmin+1)/2,t)
    end
    visual_matrix(esti_groupvariance{1,t},2)
end
if datatype==1
   set(gcf,'unit','normalized','position',[0.3,0.2,3.6,0.8]);
   if session_n==1
      saveas(gcf,'Local_inference_real_LR/Variance_real.fig')
      saveas(gcf,'Local_inference_real_LR/Variance_real.svg')
   end
   if session_n==2
      saveas(gcf,'Local_inference_real_RL/Variance_real.fig')
      saveas(gcf,'Local_inference_real_RL/Variance_real.svg')
   end
elseif datatype==0
   set(gcf,'unit','normalized','position',[0.3,0.2,0.5,0.4]);
   saveas(gcf,['Local_inference_synthetic/','n',num2str(n_s),'/Variance_synthetic.fig'])
end

% Save inference results to the folder
data_path = fileparts(mfilename('fullpath'));
if isempty(data_path), data_path = pwd; end
if datatype==1
    if session_n==1
       Localinference_path=fullfile(data_path,'Local_inference_real_LR/localinference_real');
       save(Localinference_path);
       label_path=fullfile(data_path,'Local_inference_real_LR/label_real');
       save(label_path,'esti_grouplabel');
    end
    if session_n==2
       Localinference_path=fullfile(data_path,'Local_inference_real_RL/localinference_real');
       save(Localinference_path);
    end
        
elseif datatype==0
    Localinference_path=fullfile(data_path,['Local_inference_synthetic/','n',num2str(n_s),'/localinference_synthetic']);
    save(Localinference_path);
end










