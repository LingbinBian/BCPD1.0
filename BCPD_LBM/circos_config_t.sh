#!/bin/bash
# if you can not find the commond circos: (1) bin/circos should add to export (2) PATH=~/software/circos/current/bin:$PATH (3) . ~/.bash_profile
cd Local_inference_real_LR/sparsity_30/circos_configuration/brain
for t in 41 76 107 140 175 206 239 278 306 334 375; do 
   cd circos_t$t;
   circos -conf circos_t$t.conf;
   cd ..
done

cd ../../../..

cd Local_inference_real_RL/sparsity_30/circos_configuration/brain
for t in 41 77 99 139 175 209 236 275 305 334 376; do 
   cd circos_t$t;
   circos -conf circos_t$t.conf;
   cd ..
done

cd ../../../..

