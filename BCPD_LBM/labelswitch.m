function [label_v]=labelswitch(label_v)
% This function solves the label switching phenomenon.
% label_v: N*M matrix, each column is a latent label vector
%          N is the number of nodes, 
%          M is the number of latent lable vectors
%
% Version 1.0
% 7-Aug-2020
% Copyright (c) 2020, Lingbin Bian

% label_v=sort_vect(label_v);
[n_row,n_column]=size(label_v);
cost_mat=cell(1,n_column);
sigma=cell(1,n_column);
for j=2:n_column    
   cost_mat{1,j}=zeros(max(label_v(:,j)),max(label_v(:,j)));
   for k=1:max(label_v(:,j))
       for l=1:max(label_v(:,j))
           for t=1:j-1
               for i=1:n_row
                   if label_v(i,j-t)~=k && label_v(i,j)==l
                       cost_mat{1,j}(k,l)=cost_mat{1,j}(k,l)+1;
                   end
               end
           end
       end
   end

   sigma{1,j}=munkres(cost_mat{1,j});
   L_sig=length(sigma{1,j});
   for i=1:n_row
       inde=0;
       for k_sigma=1:L_sig
       if label_v(i,j)==sigma{1,j}(k_sigma)
           label_v(i,j)=k_sigma;
           inde=1;
       end
       if inde==1        
           break;           
       end
       end           
   end      
end
end

% Nested function----------------------------------------------------------
    function [label_v]=sort_vect(label_v)
    % sort with increasing number of communities
        [n_row,n_column]=size(label_v);
        Label_ind=zeros(n_row+1,n_column);
        for i=1:n_column
            Label_ind(1,i)=max(label_v(:,i));
            Label_ind(2:end,i)=label_v(:,i);
        end
        Label_update=sortrows(Label_ind', 1);

        Label_update=Label_update';

        label_v=Label_update(2:end,:);
    end
    
    
    
    
    