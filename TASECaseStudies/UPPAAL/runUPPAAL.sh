#!/bin/bash

echo "Alpha Algorithm verification - UPPAAL"

path="/home/mscf/Dropbox/UFPE/RS2UPPAAL/AlphaAlgorithm"
#path="/Users/madielfilho/Desktop/AlphaAlgorithm"

#pathUPPAAL="/Users/madielfilho/Desktop/uppaal/bin-Darwin"
pathUPPAAL="/home/mscf/tools/uppaal/bin-Linux"

cd $pathUPPAAL

echo "  Start verification"

for (( i = 1; i < 11; i++ )); do
    echo "   Verification $i "

    rm -rf $path/log/UPPALL/V$i/*.txt

    (time ./verifyta -u $path/UPPAAL/model.xml) 1>> "$path/log/UPPAAL/V$i/property$i.txt" 2>> "$path/log/UPPAAL/V$i/timeUPPAALV$i.txt"

done

echo " Finish verification"
