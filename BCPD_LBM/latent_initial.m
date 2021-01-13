function [z] = latent_initial(N,K)
% This function initializes the latent label vector by Uniform distribution.
leng=0;
while leng~=K
z=randi([1,K],N,1);
leng=length(unique(z));
end

