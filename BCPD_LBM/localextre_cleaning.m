function [storage_2] = localextre_cleaning(localmax_ave,localmin_ave,thre)
% This function remove the false positives of CDE

localextre=[localmax_ave,localmin_ave];
localextre_s=sortrows(localextre',1,'ascend');
le_s=localextre_s';
M=length(le_s);
storage=cell(M,M);

ind=zeros(1,M);


i=1;
j=1;

for m=1:M-1
     if abs(le_s(1,m)-le_s(1,m+1))<thre
         storage{i,j}=le_s(:,m);
         i=i+1;
     elseif abs(le_s(1,m)-le_s(1,m+1))>=thre
          storage{i,j}=le_s(:,m);
          ind(j)=i;
          j=j+1;
          i=1;
    end    
end
storage{i,j}=le_s(:,M);
ind(j)=ind(j)+1;

storage_2=cell(1,j);
for l=1:j
    if ind(l)>1
        regi=zeros(2,ind(l));
        for s=1:ind(l)
            regi(:,s)=storage{s,l};
        end
         regi=sortrows(regi',2,'ascend');
         regi=regi';
         storage_2{l}=[regi(:,1),regi(:,end)];
    else
         storage_2{l}=[storage{1,l},storage{1,l}];
    end
end


for l=1
    if ind(l)>1
       
        if storage_2{l}(2,2)<min(storage_2{l+1}(2,1))
            storage_2{l}=[storage_2{l}(:,1),storage_2{l}(:,1)];
            ind(l)=1;
        elseif storage_2{l}(2,1)>max(storage_2{l+1}(2,2))
            storage_2{l}=[storage_2{l}(:,2),storage_2{l}(:,2)];
            ind(l)=1;
        end
    end
end

for l=2:j-1
    if ind(l)>1   
    
        if storage_2{l}(2,2)<min(storage_2{l+1}(2,1),storage_2{l-1}(2,1))
            storage_2{l}=[storage_2{l}(:,1),storage_2{l}(:,1)];
            ind(l)=1;
       
        elseif storage_2{l}(2,1)>max(storage_2{l+1}(2,2),storage_2{l-1}(2,2))
           
            storage_2{l}=[storage_2{l}(:,2),storage_2{l}(:,2)];
            ind(l)=1;
        else
            storage_2{l}=[storage_2{l}(:,1),storage_2{l}(:,2)];
            ind(l)=0;
        end 
    end    
end

for l=j
    if ind(l)>1
        if storage_2{l}(2,2)<storage_2{l+1}(2,1)
            storage_2{l}=[storage_2{l}(:,1),storage_2{l}(:,1)];
            ind(l)=1;
        elseif storage_2{l}(2,1)>storage_2{l+1}(2,2)
            storage_2{l}=[storage_2{l}(:,2),storage_2{l}(:,2)];
            ind(l)=1;
        end
    end       
end

for l=1:j
    if ind(l)==0
        storage_2{l}=[];
    end
end
storage_2(cellfun(@isempty,storage_2))=[];

L=length(storage_2);
for l=1:L
    storage_2{1,l}=storage_2{1,l}(:,1);
end

end

