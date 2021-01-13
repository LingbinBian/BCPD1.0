function [z_latent] = latent_generator(N,K)
% This function generates the latent label vector.
% Input: 
%    N: the number of nodes
%    K: the number of communities
% Output:
%    z_latent: the N-dimensional latent label vector
%
% Version 1.0
% 03-April-2019
% Copyright (c) 2019, Lingbin Bian
%------------------------------------------------------

r=MembProb_generator(K);
z_latent=zeros(N,1);
leng=0;
while leng~=K
    z=mnrnd(1,r,N);   % latent label of vector form
    for i=1:N
        z_latent(i)=find(z(i,:)==1); % transfer from vector form to scaler eg: [0 0 1 0] to 3
    end
    leng=length(unique(z_latent));
end

% Nested functions--------------------------------------
% Membership probability generator
    function [ r ] = MembProb_generator(K)
        % This function generates the membership probability 
        % Output: membership probability  
        m=0;
        thre=0.5*(1/K);
        while m<thre     % set each r not less than 0.18
            alpha=ones(1,K);   % hyper parameters of Dirichlet prior
            n=1;    % one trial of multinomial
            r=drchrnd(alpha,n);   % Dirichrit prior      
            m=min(r);
        end
    end
% End of membership probability generator----------------
% Dirichlet random variable
    function [ r ] = drchrnd( a,n )
        % Dirichlet random variable
        p=length(a);
        r=gamrnd(repmat(a,n,1),1,n,p);
        r=r./repmat(sum(r,2),1,p);
    end

end
