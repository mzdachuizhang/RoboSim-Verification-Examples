#!/bin/bash

echo "FootBot verification - UPPAAL"

path="/TASEcaseStudies/FootBot/UPPAAL"

pathUPPAAL="/tools/uppaal/bin-Linux"

cd $pathUPPAAL

echo "  Start verification"

for (( i = 1; i <= 10; i++ )); do
    echo "   Verification $i "

    rm -rf $path/log/V$i/*.txt

    (time ./verifyta -u $path/files/CFootBot.xml) 1>> "$path/log/V$i/results$i.txt" 

done

echo " Finish verification"
