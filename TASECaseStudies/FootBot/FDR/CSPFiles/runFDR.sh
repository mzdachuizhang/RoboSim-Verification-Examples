#!/bin/bash

echo "FootBot verification"

path="/TASEcaseStudies3005/FootBot/FDR"

pathFDR4="/tools/fdr4/bin/"

cd $pathFDR4

echo "  Property 1 - Deadlock-free."


for (( i = 1; i <=10; i++ )); do
    echo "   Verification $i "

    rm -rf $path/log/P1/V$i/*.txt

    (time ./refines --brief $path/CSPFiles/mainP1.csp) 1>> "$path/log/P1/V$i/assertionFDR4V$i.txt" 2>> "$path/log/P1/V$i/timeFDR4V$i.txt"
    
done

echo "  Property 2 - No outputs conflict."


for (( i = 1; i <=10; i++ )); do
    echo "   Verification $i "

    rm -rf $path/log/P2/V$i/*.txt

    (time ./refines --brief $path/CSPFiles/mainP2.csp) 1>> "$path/log/P2/V$i/assertionFDR4V$i.txt" 2>> "$path/log/P2/V$i/timeFDR4V$i.txt"
    
done

echo "  Property 3 - State SMove is reachable."


for (( i = 1; i<=10; i++ )); do
    echo "   Verification $i "

    rm -rf $path/log/P3/V$i/*.txt

    (time ./refines --brief $path/CSPFiles/mainP3.csp) 1>> "$path/log/P3/V$i/assertionFDR4V$i.txt" 2>> "$path/log/P3/V$i/timeFDR4V$i.txt"
    
done
    


echo "FINISHED"
