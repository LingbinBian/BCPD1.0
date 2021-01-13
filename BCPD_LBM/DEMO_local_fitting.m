% This script plots the local fitting for discrete brain states.
%
% Version 1.0
% 2-May-2020
% Copyright (c) 2020, Lingbin Bian
% -------------------------------------------------------------------------
clear
clc
%close all
datatype=1;  % 1: real data, 0: synthetic data
if datatype==1
    session_n=2;
    if session_n==1
      % localmin_t=[41,76,107,140,175,207,238,278,306,333,375];
        localmin_t=[41,76,140,175,239,278,334,375];
    end
    if session_n==2
        localmin_t=[41,77,139,175,236,275,334,376];
    end    
end
if datatype==0
    n_s=0.3162;
    localmin_t=[36,67,91,116,147]; % n_s: 0.3162
     % localmin_t=[36,66,91,116,146]; % n_s: 0.5623
      % localmin_t=[36,66,92,116,146]; % n_s: 1       
end

colorvector=[1,1,0;0.78,0.38,0.08;0,0,1;1,0,0;0,1,0;0,0.5,0;0.5,0.5,0;1,0.5,0.5];
K_trial=3:18;

if datatype==0
    load(['Local_fitting_synthetic/n',num2str(n_s),'/localfit_aveadj.mat'])
end
if datatype==1
    if session_n==1
       load('Local_fitting_real_LR/localfit_aveadj.mat')
    end
    if session_n==2
       load('Local_fitting_real_RL/localfit_aveadj.mat')
    end
end

figure    
for t=1:length(localmin_t) 
     plot(K_trial(:),local_fit_aveadj(t,:),'--ks',...
     'LineWidth',1.2,...
     'MarkerSize',7,...
     'MarkerEdgeColor','k',...
     'MarkerFaceColor',colorvector(t,:));
     hold on    
end

if datatype==0
    legend('State 1: K^{true}=4', ...
        'State 2: K^{true}=5', ...
        'State 3: K^{true}=3', ...
        'State 4: K^{true}=5', ...
        'State 5: K^{true}=4')
end

if datatype==1
    legend('2-back tool', ...
       '0-back body', ...
       '2-back face', ... 
       '0-back tool', ... 
       '2-back body', ...
       '2-back place', ...
       '0-back face', ...
       '0-back place')   
end
% if datatype==1
%     legend(['t=',num2str(localmin_t(1))], ...
%        ['t=',num2str(localmin_t(2))], ...
%        ['t=',num2str(localmin_t(3))], ... 
%        ['t=',num2str(localmin_t(4))], ... 
%        ['t=',num2str(localmin_t(5))], ...
%        ['t=',num2str(localmin_t(6))], ...
%        ['t=',num2str(localmin_t(7))], ...
%        ['t=',num2str(localmin_t(8))])   
% end

title('Local fitting','fontsize',16)
set(gca,'box','on')
set(gca,'fontsize',16)
xlabel('K','fontsize',16)
ylabel('PPDI','fontsize',16)
set(gcf,'unit','centimeters','position',[6 10 14 10])
set(gca,'Position',[.15 .15 .75 .75]);
set(gca,'xtick',0:2:20)
set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')

if datatype==1
    if session_n==1
       saveas(gcf,'Local_fitting_real_LR/localfit_real.fig')
    end
    if session_n==2
       saveas(gcf,'Local_fitting_real_RL/localfit_real.fig')
    end
end
    
if datatype==0
    saveas(gcf,['Local_fitting_synthetic/n',num2str(n_s),'/localfit_synthetic.fig'])
end


