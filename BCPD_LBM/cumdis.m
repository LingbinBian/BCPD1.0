function [ cumenergy ] =cumdis(discrepindex,netpara)
% This function calculates the cumulative discrepancy energy.
% 
% Version 1.0 
% 06-May-2019
% Copyright (c) 2019, Lingbin Bian

W_cum=5;
T=netpara.T;
W=netpara.W;
cumenergy=zeros(1,T);
for t=(W_cum+W+1):(T-(W_cum+W))
    cumenergy(t)=sum(discrepindex(t-W_cum:t+W_cum-1));
end
end

