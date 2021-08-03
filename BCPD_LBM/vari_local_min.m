function [vari_storage,vari_localmin_location,vari_localmin_cde] = vari_local_min(localmin_subj,localmax_ave,localmin_ave)
% This function calculates the inter-individual variations of the local
% minimun (locations and cde value)
%
% Input: 
%     localmin_subj: local minimum of 100 subjects
%     localmax_ave: averaged local maximum
%     localmin_ave: averaged local minimum
% Output:
%     vari_storage: a storage containing the samples for each segment
%     vari_loalmin_location: variation of locations
%     vari_localmin_cde: variation of CDE values
%
% Version 1.0 
% Copyright (c) 2021, Lingbin Bian
% 8-July-2021

N_subj=100;
M=500;
vari_storage=cell(M,5);
m=zeros(5,1);  % count samples
vari_localmin_location=zeros(1,5);
vari_localmin_cde=zeros(1,5);


for i=1:N_subj
    for l=1:length(localmin_subj{i,1}(1,:))  % for each local maxima of the individual
        registor=zeros(2,1);  % a register storing information of location and CDE value
        registor(1,1)=localmin_subj{i,1}(1,l);
        registor(2,1)=localmin_subj{i,1}(2,l);
        if localmax_ave(1,1)<localmin_subj{i,1}(1,l)&&localmin_subj{i,1}(1,l)<=localmax_ave(1,2)
            m(1,1)=m(1,1)+1;
            vari_storage{m(1,1),1}=registor;               
        elseif localmax_ave(1,2)<localmin_subj{i,1}(1,l)&&localmin_subj{i,1}(1,l)<=localmax_ave(1,3)
            m(2,1)=m(2,1)+1;
            vari_storage{m(2,1),2}=registor; 
        elseif localmax_ave(1,3)<localmin_subj{i,1}(1,l)&&localmin_subj{i,1}(1,l)<=localmax_ave(1,4)
            m(3,1)=m(3,1)+1;
            vari_storage{m(3,1),3}=registor; 
        elseif localmax_ave(1,4)<localmin_subj{i,1}(1,l)&&localmin_subj{i,1}(1,l)<=localmax_ave(1,5)
            m(4,1)=m(4,1)+1;
            vari_storage{m(4,1),4}=registor; 
        elseif localmax_ave(1,5)<localmin_subj{i,1}(1,l)&&localmin_subj{i,1}(1,l)<=localmax_ave(1,6)
            m(5,1)=m(5,1)+1;
            vari_storage{m(5,1),5}=registor; 
        end                   
    end  
end


for j=1:5
    vari_registor=zeros(m(j,1),1);
    for i=1:m(j,1)
        vari_registor(i,1)=sqrt((vari_storage{i,j}(1,1)-localmin_ave(1,j))^2)/m(j,1);     
    end
    vari_localmin_location(1,j)=sum(vari_registor);
end


for j=1:5
    vari_registor=zeros(m(j,1),1);
    for i=1:m(j,1)
        vari_registor(i,1)=sqrt((vari_storage{i,j}(2,1)-localmin_ave(2,j))^2)/m(j,1);       
    end
    vari_localmin_cde(1,j)=sum(vari_registor);
end


end

