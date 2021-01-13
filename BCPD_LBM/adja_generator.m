function [x]=adja_generator(z,Mean,Vari)
% This function generates the adjacency matrix for testing model parameters sampling.

% Version 1.0 
% 20-Aug-2019
% Copyright (c) 2019, Lingbin Bian

N=length(z);
x=zeros(N,N);
for i=1:N
    for j=1:N
        x(i,j)=normrnd(Mean(z(i),z(j)),sqrt(Vari(z(i),z(j))));  % observation with expectation pi_kl
    end
end
 
end
