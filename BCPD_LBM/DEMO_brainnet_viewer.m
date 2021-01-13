% Write memberships (labels) of nodes, and edges (adjacency matrix) to .node and .edge files for BrainNet Viewer.

% Version 1.0
% 7-Jun-2020
% Copyright (c) 2020, Lingbin Bian

session_n=1;
if session_n==1
   cd 'Local_inference_real_LR'
end
if session_n==2
   cd 'Local_inference_real_RL'
end
load('localinference_real.mat');
spar_level=10;

for t=1:L_localmin   
    Node_ROI=dlmread(['sparsity_',num2str(spar_level),'/Node_ROI_t',num2str(localmin_t(t)),'.node']);
    Node_ROI(:,4)=esti_grouplabel(:,t);
    dlmwrite(['sparsity_',num2str(spar_level),'/Node_ROI_t',num2str(localmin_t(t)),'.node'],Node_ROI,'delimiter','\t')
    dlmwrite(['sparsity_',num2str(spar_level),'/Weighted_t',num2str(localmin_t(t)),'.edge'],ave_adj{t},'delimiter','\t')
   
    BrainNet_MapCfg(['sparsity_',num2str(spar_level),'/Node_ROI_t',num2str(localmin_t(t)),'.node'],...
        ['sparsity_',num2str(spar_level),'/Weighted_t',num2str(localmin_t(t)),'.edge'],...
        'BrainMesh_Ch2withCerebellum.nv',...
        ['sparsity_',num2str(spar_level),'/Brainnet_setup_t',num2str(localmin_t(t)),'.mat'],...
        ['sparsity_',num2str(spar_level),'/network_t',num2str(localmin_t(t)),'.fig']);
    saveas(gcf,['sparsity_',num2str(spar_level),'/network_t',num2str(localmin_t(t)),'.fig'])
   
end
cd ..
