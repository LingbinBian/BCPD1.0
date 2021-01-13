function [ AdjaCell,netpara ] = adjacencyCellArray(Timeseries,W,K)
% This function transfers the timeseries to the Adjacency matrix array.
% Input:
%    timeseries: Timeseries=struct('name','Gaussian'or'real',...
%                  'signal',signal,...
%                  'changepoint_truth',changepoint,...
%                  'LatentLabels',latent_seg,...
%                  'T',T,...
%                  'N',N,...
%                  'K_seg',K_seg);
%    W: window size
%    M: Margin size
% Output:
%    AdjaCell: Adjacency matrix cell array
%    netpara: The struct containing network time series parameters
%
% Version 1.0 
% 11-Aug-2019
% Copyright (c) 2019, Lingbin Bian



T=Timeseries.T;
N=Timeseries.N;

AdjaCell=cell(1,T); 

for t=(W+1):(T-W)  
    AdjaCell{t}=adjac_generator(t);
end

netpara=struct('T',T,...
               'N',N,...
               'K',K,...
               'W',W);

% Nested functions-----------------------------------------
% This function generates the Adjacency matrix within the window at time t
    function [ Adj] = adjac_generator(t)
        signal_inW=Timeseries.signal(:,t-W:t+W-1)';
        covari=cov(signal_inW);
        Adj=corrcov(covari);
%        Adj=corrcoef(signal_inW);
%        Adj=threshold_absolute(corre,0.2);
%         for i=1:N
%             for j=1:N
%                 if Adj(i,j)>=0.2
%                     Adj(i,j)=1;
%                 else
%                     Adj(i,j)=0;
%                 end
%             end
%         end        
    end
% End of nested functions

end


