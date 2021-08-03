#!/bin/bash

# This script deletes the first line of the node.txt and connectivity.txt


cd Local_inference_real_RL/sparsity_30

for t in 49 77 99 139 175 209 236 275 305 334 376; do 

  sed '1d' circos_node_v_t$t.txt >> circos_brain_network/circos_brain_node_t$t.txt;
  sed '1d' circos_connectivity_in_v_t$t.txt >> circos_brain_network/circos_brain_connectivity_in_t$t.txt;
  sed '1d' circos_connectivity_out_v_t$t.txt >> circos_brain_network/circos_brain_connectivity_out_t$t.txt;
  
done

cd ../..