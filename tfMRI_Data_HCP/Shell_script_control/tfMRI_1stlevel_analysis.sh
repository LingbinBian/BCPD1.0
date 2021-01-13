#!/bin/bash

# The first level analysis for 100 unrelated subject in HCP Working Memory task fMRI data 
#
# Version 1.0
# 13-Jan-2020
# Copyright (c) 2020, Lingbin Bian

cd ../subjects
for subj in `cat subject.txt` ; do
  
    echo "===> Starting processing of $subj"
    echo
    cd $subj

        # Copy the design files into the subject directory, and then
        # change “100307” to the current subject number
        cp ../Design_run1_LR.fsf .
        cp ../Design_run2_RL.fsf .

        # Note that we are using the | character to delimit the patterns
        # instead of the usual / character because there are / characters
        # in the pattern.
        sed -i '' "s|100307|${subj}|g" \
            Design_run1_LR.fsf
        sed -i '' "s|100307|${subj}|g" \
            Design_run2_RL.fsf

        # Now everything is set up to run feat
        echo "===> Starting feat for run 1"
        feat Design_run1_LR.fsf
        echo "===> Starting feat for run 2"
        feat Design_run2_RL.fsf
                echo

    # Go back to the directory containing all of the subjects, and repeat the loop
    cd ..
done
echo

cd ../Shell_script_control