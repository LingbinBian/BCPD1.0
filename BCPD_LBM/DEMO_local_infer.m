% Local inference for discrete states of community architectures.
%
% Set up parameters:
% W: half of window size
% n_s: standard deviation of noise with respect to SNR
% localmin_t: a vector of time points corresponding to local minima
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
datatype=1;   % 1: real data, 0: synthetic data

if datatype==1
    session_n=2;
    if session_n==1
        load('Local_inference_real_LR/localinference_real.mat');
    end
    if session_n==2
        load('Local_inference_real_RL/localinference_real.mat');
    end    
    
elseif datatype==0
    n_s=1;
    load(['Local_inference_synthetic/','n',num2str(n_s),'/','localinference_synthetic.mat']);
end

% Visualization: estimation of latent label vector
if datatype==1 
    figure  
    for t=1:L_localmin
        subplot(1,L_localmin,t)
        visual_labels(esti_grouplabel(:,t),K_min)
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












