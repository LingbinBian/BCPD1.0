#!/bin/bash
# Creat dir subjects and unzip the data into subjects
# 
# Version 1.0
# 12-Jan-2020
# Copyright (c) 2020, Lingbin Bian

cd ..
mkdir subjects
for z in *.zip;
    do unzip $z -d subjects; 
done
cd subjects
ls >> subject.txt
cd ../Shell_script_control
