function [vari_storage,vari_localmax_location,vari_localmax_cde] = vari_local_max(localmax_subj,localmax_ave,localmin_ave)
% This function calculates the inter-individual variations of the local
% maximun (locations and cde value)
%
% Input: 
%     localmax_subj: local maximum of 100 subjects
%     localmax_ave: averaged local maximum
%     localmin_ave: averaged local minimum
% Output:
%     vari_storage: a storage containing the samples for each segment
%     vari_loalmax_location: variation of locations
%     vari_localmax_cde: variation of CDE values
%
% Version 1.0 
% Copyright (c) 2021, Lingbin Bian
% 6-July-2021

N_subj=100;
M=500;
vari_storage=cell(M,6);
m=zeros(6,1);  % count samples
vari_localmax_location=zeros(1,6);
vari_localmax_cde=zeros(1,6);


for i=1:N_subj
    for l=1:length(localmax_subj{i,1}(1,:))  % for each local maxima of the individual
        registor=zeros(2,1);  % a register storing information of location and CDE value
        registor(1,1)=localmax_subj{i,1}(1,l);
        registor(2,1)=localmax_subj{i,1}(2,l);
        if localmax_subj{i,1}(1,l)<=localmin_ave(1,1)
            m(1,1)=m(1,1)+1;
            vari_storage{m(1,1),1}=registor;               
        elseif localmin_ave(1,1)<localmax_subj{i,1}(1,l)&&localmax_subj{i,1}(1,l)<=localmin_ave(1,2)
            m(2,1)=m(2,1)+1;
            vari_storage{m(2,1),2}=registor; 
        elseif localmin_ave(1,2)<localmax_subj{i,1}(1,l)&&localmax_subj{i,1}(1,l)<=localmin_ave(1,3)
            m(3,1)=m(3,1)+1;
            vari_storage{m(3,1),3}=registor; 
        elseif localmin_ave(1,3)<localmax_subj{i,1}(1,l)&&localmax_subj{i,1}(1,l)<=localmin_ave(1,4)
            m(4,1)=m(4,1)+1;
            vari_storage{m(4,1),4}=registor; 
        elseif localmin_ave(1,4)<localmax_subj{i,1}(1,l)&&localmax_subj{i,1}(1,l)<=localmin_ave(1,5)
            m(5,1)=m(5,1)+1;
            vari_storage{m(5,1),5}=registor; 
        elseif localmax_subj{i,1}(1,l)>localmin_ave(1,5)
            m(6,1)=m(6,1)+1;
            vari_storage{m(6,1),6}=registor;
        end                   
    end  
end


for j=1:6
    vari_registor=zeros(m(j,1),1);
    for i=1:m(j,1)
        vari_registor(i,1)=sqrt((vari_storage{i,j}(1,1)-localmax_ave(1,j))^2)/m(j,1);     
    end
    vari_localmax_location(1,j)=sum(vari_registor);
end


for j=1:6
    vari_registor=zeros(m(j,1),1);
    for i=1:m(j,1)
        vari_registor(i,1)=sqrt((vari_storage{i,j}(2,1)-localmax_ave(2,j))^2)/m(j,1);       
    end
    vari_localmax_cde(1,j)=sum(vari_registor);
end


end

