#!/bin/bash
# The script intends to great a 'reg' folder, which is essential for 2-level analysis
# Running Feat to do registration can create 'reg' folder.
# 
# Version 1.0
# 15-Jan-2020
# Copyright (c) 2020, Lingbin Bian

 
cd ../subjects
for subj in `cat subject.txt` ; do
  
    echo "===> Starting processing $subj"
    echo
    cd $subj

        # Copy design files to the subject directory, and change '100307' to the current subject id
        cp ../Registration_LR.fsf .
        cp ../Registration_RL.fsf .

        # We are use the | character to delimit the patterns instead of the usual / character because there are / characters in the pattern.
        sed -i '' "s|100307|${subj}|g" \
            Registration_LR.fsf 
        sed -i '' "s|100307|${subj}|g" \
            Registration_RL.fsf

        # run feat
        echo "===> Starting feat for run 1"
        feat Registration_LR.fsf 
        echo "===> Starting feat for run 2"
        feat Registration_RL.fsf
                echo

    # Go back to the directory containing all of the subjects, and repeat the loop
    cd ..
done

echo
cd ../Shell_script_control