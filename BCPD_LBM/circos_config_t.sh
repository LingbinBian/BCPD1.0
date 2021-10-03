#!/bin/bash
# if you can not find the commond circos: (1) under directory circos-0.69: bin/circos -modules (2) pwd (2) export PATH=~/software/circos/current/bin:$PATH (3)export PATH=pwd/bin:$PATH(4) . ~/.bash_profile



cd Local_inference_real_RL/sparsity_30/circos_configuration/brain
for t in 49 77 99 139 175 209 236 275 305 334 376; do 
   cd circos_t$t;
   circos -conf circos_t$t.conf;
   cd ..
done

cd ../../../..

