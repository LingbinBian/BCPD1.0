#!bin/bash
# K, W, n,  

mkdir Data/synthetic_n1.9
for i in `seq -w 1001 1100`; do   
    mkdir Data/synthetic_n1.9/$i 
done

mkdir Global_fitting_synthetic/infer_synthetic_K5_W20_n1.9
for i in `seq -w 1001 1100`; do    
    mkdir Global_fitting_synthetic/infer_synthetic_K5_W20_n1.9/$i 
done

mkdir Local_inference_synthetic/n1.9
mkdir Local_fitting_synthetic/n1.9