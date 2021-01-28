% This script creates the data files needed for circos.

% node.txt
% edge.txt

% Version 1.0
% 7-Jun-2020
% Copyright (c) 2020, Lingbin Bian

clear
clc

session_n=2;
if session_n==1
   cd 'Local_inference_real_LR'
end
if session_n==2
   cd 'Local_inference_real_RL'
end

load('localinference_real.mat');
spar_level=30;
% node table
circos_node=readtable(['sparsity_',num2str(spar_level),'/circos_node_temp.txt']);

for t=1:L_localmin
     node_txt(circos_node,esti_grouplabel,localmin_t,t,spar_level)
end

% connectivity table
for t=1:L_localmin
    connectivity_txt(ave_adj,esti_grouplabel,localmin_t,t,spar_level,session_n)
end
cd ..

% Nested functions --------------------------------------------------------
   % creat node.txt for circos
    function []=node_txt(circos_node,esti_grouplabel,localmin_t,t,spar_level)
        for i=1:35
            switch esti_grouplabel(i,t)
                case 1
                Var7={'dblue'};
                circos_node(i,7)=cell2table(Var7);
                circos_node(i,8)=cell2table({1});
                case 2
                Var7={'orange'};
                circos_node(i,7)=cell2table(Var7);
                circos_node(i,8)=cell2table({2});
                case 3                    
                Var7={'vlorange'};
                circos_node(i,7)=cell2table(Var7);
                circos_node(i,8)=cell2table({3});
                case 4
                Var7={'chr19'};
                circos_node(i,7)=cell2table(Var7);
                circos_node(i,8)=cell2table({4});
                case 5
                Var7={'green'};
                circos_node(i,7)=cell2table(Var7);
                circos_node(i,8)=cell2table({5});
                case 6
                Var7={'chr16'};
                circos_node(i,7)=cell2table(Var7);
                circos_node(i,8)=cell2table({6});
                otherwise 
                Var7={'chr4'};
                circos_node(i,7)=cell2table(Var7);
                circos_node(i,8)=cell2table({7});
            end
                      
         end
        circos_node=sortrows(circos_node,8,'descend');       
        writetable(circos_node(:,1:7),['sparsity_',num2str(spar_level),'/circos_node_v_t',num2str(localmin_t(t)),'.txt'],'Delimiter',' ')
    end

    % creat connectivity.txt for circos
    function []=connectivity_txt(adj,esti_grouplabel,localmin_t,t,spar_level,session_n)
        switch spar_level
            case 10
                if session_n==1  % LR
                    thre_vector=[0.181260,0.174190,0.214730,0.170310,0.182670,0.188720,0.197010,0.150050,0.182810,0.167680,0.160250];
                    % t=41,   0.181260     10%
                    % t=76,   0.174190     10%
                    % t=107,  0.214730     10%
                    % t=140,  0.170310     10%
                    % t=175,  0.182670     10%
                    % t=207,  0.188720     10%
                    % t=238,  0.197010     10%
                    % t=278,  0.150050     10%
                    % t=306,  0.182810     10%
                    % t=333,  0.167680     10%
                    % t=375,  0.160250     10%
                end
                if session_n==2 % RL
                    thre_vector=[0.171910,0.162100,0.163720,0.167120,0.159640,0.185030,0.162560,0.170530,0.161330,0.170590,0.189030];
                    % t=41,   0.171910     10%
                    % t=77,   0.162100     10%
                    % t=99,   0.163720     10%
                    % t=139,  0.167120     10%
                    % t=175,  0.159640     10%
                    % t=209,  0.185030     10%
                    % t=236,  0.162560     10%
                    % t=275,  0.170530     10%
                    % t=305,  0.161330     10%
                    % t=334,  0.170590     10%
                    % t=376,  0.189030     10%
                end
            case 20
                if session_n==1
                    thre_vector=[0.137180,0.127970,0.161280,0.123670,0.128740,0.144540,0.141750,0.110350,0.135000,0.129760,0.111320];
                    % t=41,   0.137180     20%
                    % t=76,   0.127970     20%
                    % t=107,  0.161280     20%
                    % t=140,  0.123670     20%
                    % t=175,  0.128740     20%
                    % t=207,  0.144540     20%
                    % t=238,  0.141750     20%
                    % t=278,  0.110350     20%
                    % t=306,  0.135000     20%
                    % t=333,  0.129760     20%
                    % t=375,  0.111320     20%
                end
                if session_n==2
                    thre_vector=[0.130970,0.122650,0.119390,0.124790,0.117330,0.148680,0.126300,0.120370,0.119530,0.125060,0.139250];
                    % t=41,   0.130970     20%
                    % t=77,   0.122650     20%
                    % t=99,   0.119390     20%
                    % t=139,  0.124790     20%
                    % t=175,  0.117330     20%
                    % t=209,  0.148680     20%
                    % t=236,  0.126300     20%
                    % t=275,  0.120370     20%
                    % t=305,  0.119530     20%
                    % t=334,  0.125060     20%
                    % t=376,  0.139250     20%                    
                end               
            otherwise
                if session_n==1
                    thre_vector=[0.110260,0.106340,0.135500,0.100210,0.093138,0.113810,0.113740,0.085303,0.104690,0.102840,0.088773];
                    % t=41,   0.110260     30%
                    % t=76,   0.106340     30%
                    % t=107,  0.135500     30%
                    % t=140,  0.100210     30%
                    % t=175,  0.093138     30%
                    % t=207,  0.113810     30%
                    % t=238,  0.113740     30%
                    % t=278,  0.085303     30%
                    % t=306,  0.104690     30%
                    % t=333,  0.102840     30%
                    % t=375,  0.088773     30%
                end
                if session_n==2
                    thre_vector=[0.106440,0.096199,0.091809,0.096152,0.093020,0.115890,0.102250,0.097758,0.091143,0.100220,0.112070];
                    % t=41,   0.106440     30%
                    % t=77,   0.096199     30%
                    % t=99,   0.091809     30%
                    % t=139,  0.096152     30%
                    % t=175,  0.093020     30%
                    % t=209,  0.115890     30%
                    % t=236,  0.102250     30%
                    % t=275,  0.097758     30%
                    % t=305,  0.091143     30%
                    % t=334,  0.100220     30%
                    % t=376,  0.112070     30%                    
                end
        end
        
        L_in=0;
        L_out=0;
        for i=1:35
            for j=1:35
                if adj{1,t}(i,j)>=thre_vector(t) && i~=j 

                    if esti_grouplabel(i,t)==esti_grouplabel(j,t)
                        L_in=L_in+1;
                    else
                        L_out=L_out+1;
                    end            
                end
            end
        end

        % Initilize table
        % in communities
        headers = {'Var1' 'Var2' 'Var3' 'Var4' 'Var5' 'Var6'};
        table_elements=cell(L_in,6);
        circos_connectivity_in=cell2table(table_elements);
        circos_connectivity_in.Properties.VariableNames = headers;

        % between communities
        headers = {'Var1' 'Var2' 'Var3' 'Var4' 'Var5' 'Var6'};
        table_elements=cell(L_out,6);
        circos_connectivity_out=cell2table(table_elements);
        circos_connectivity_out.Properties.VariableNames = headers;

        p_in=1;
        p_out=1;
        for i=1:35
            for j=1:35
                if abs(adj{1,t}(i,j))>=thre_vector(t) && i~=j      
                    Var1={['s',num2str(i)]};
                    Var2={4};
                    Var3={6};
                    Var4={['s',num2str(j)]};
                    Var5={4};
                    Var6={6};
                if esti_grouplabel(i,t)==esti_grouplabel(j,t)
                    circos_connectivity_in(p_in,1)=cell2table(Var1);
                    circos_connectivity_in(p_in,2)=array2table(Var2);
                    circos_connectivity_in(p_in,3)=array2table(Var3);
                    circos_connectivity_in(p_in,4)=cell2table(Var4);
                    circos_connectivity_in(p_in,5)=array2table(Var5);
                    circos_connectivity_in(p_in,6)=array2table(Var6);
                    p_in=p_in+1;
                else
                    circos_connectivity_out(p_out,1)=cell2table(Var1);
                    circos_connectivity_out(p_out,2)=array2table(Var2);
                    circos_connectivity_out(p_out,3)=array2table(Var3);
                    circos_connectivity_out(p_out,4)=cell2table(Var4);
                    circos_connectivity_out(p_out,5)=array2table(Var5);
                    circos_connectivity_out(p_out,6)=array2table(Var6);
                    p_out=p_out+1;
                end
                end       
            end   
        end
        writetable(circos_connectivity_in,['sparsity_',num2str(spar_level),'/circos_connectivity_in_v_t',num2str(localmin_t(t)),'.txt'],'Delimiter',' ')
        writetable(circos_connectivity_out,['sparsity_',num2str(spar_level),'/circos_connectivity_out_v_t',num2str(localmin_t(t)),'.txt'],'Delimiter',' ')
    end
 

    
    
    
    
    
    
    
    
    
    


