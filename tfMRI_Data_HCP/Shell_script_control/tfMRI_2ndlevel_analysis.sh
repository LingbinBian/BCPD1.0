#!/bin/bash
# Second level analysis
# Generate the subject list to make modifying this script
# to run just a subset of subjects easier.
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
        # change “100408” to the current subject number
        cp ../Design_2nd_level_cope12_13.fsf .
      
        # Note that we are using the | character to delimit the patterns
        # instead of the usual / character because there are / characters
        # in the pattern.
        sed -i '' "s|100408|${subj}|g" \
            Design_2nd_level_cope12_13.fsf
    

        # Now everything is set up to run feat
        echo "===> Starting feat for 2nd Level"
        feat Design_2nd_level_cope12_13.fsf

                echo

    # Go back to the directory containing all of the subjects, and repeat the loop
    cd ..
done

echo
cd ../Shell_script_control