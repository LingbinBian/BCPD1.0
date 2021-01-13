% This script converts .txt timeseries of real data to a matrix format for all subjects.
%
% Version 1.0 
% Copyright (c) 2020, Lingbin Bian
% 10-Feb-2020

subjects=load('subject.txt');

data_path = fileparts(mfilename('fullpath'));
if isempty(data_path), data_path = pwd; end

for i=1:100
    subdir=fullfile(data_path,'Data/real_tfMRI',num2str(subject(i)),'timeseries_WM_LR');
    cd(subdir);
    list=dir('*.txt');%
    L=length(list);%
    T=405;
    ROI_timeseries=zeros(L,T);
    for l=1:L
       node_timeseries=load(list(l).name);%
       ROI_timeseries(l,:)=node_timeseries;
    end
    filename='timeseries.mat';
    save(filename);
    
    cd ../'timeseries_WM_RL' 
    list=dir('*.txt');%
    L=length(list);%
    T=405;
    ROI_timeseries=zeros(L,T);
    for l=1:L
       node_timeseries=load(list(l).name);%
       ROI_timeseries(l,:)=node_timeseries;
    end
    filename='timeseries.mat';
    save(filename);
       
    cd ../../../..   
       
end



