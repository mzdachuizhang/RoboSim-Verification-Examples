#!/bin/bash

echo "Alpha Algorithm verification"

path="/TASEcaseStudies/AlphaAlgorithm/FDR"

pathFDR4="/fdr4/bin/"

cd $pathFDR4

echo "  Property 1 - Deadlock-free."


for (( i = 1; i <= 10; i++ )); do
    echo "   Verification $i "

    rm -rf $path/log/P1/V$i/*.txt

    (time ./refines --brief $path/CSPFiles/mainP1.csp) 1>> "$path/log/P1/V$i/assertionFDR4V$i.txt" 2>> "$path/log/P1/V$i/timeFDR4V$i.txt"
    
done

echo "  Property 2 - No outputs conflict."


for (( i = 1; i <= 10; i++ )); do
    echo "   Verification $i "

    rm -rf $path/log/P2/V$i/*.txt

    (time ./refines --brief $path/CSPFiles/mainP2.csp) 1>> "$path/log/P2/V$i/assertionFDR4V$i.txt" 2>> "$path/log/P2/V$i/timeFDR4V$i.txt"
    
done

echo "  Property 3 - No more than RC continuous time units are spent in the state Receive of the state-machine Communication."


for (( i = 1; i <= 10; i++ )); do
    echo "   Verification $i "

    rm -rf $path/log/P3/V$i/*.txt

    (time ./refines --brief $path/CSPFiles/mainP3.csp) 1>> "$path/log/P3/V$i/assertionFDR4V$i.txt" 2>> "$path/log/P3/V$i/timeFDR4V$i.txt"
    
done
    
echo "  Property 4 - The state machine Communication starts to enter the state Receive exactly every RC units."


for (( i = 1; i <= 10; i++ )); do
    echo "   Verification $i "

    rm -rf $path/log/P4/V$i/*.txt

    (time ./refines --brief $path/CSPFiles/mainP4.csp) 1>> "$path/log/P4/V$i/assertionFDR4V$i.txt" 2>> "$path/log/P4/V$i/timeFDR4V$i.txt"
    
done

echo "  Property 5 - No more than 360/av time units are spent in the state Turning."

for (( i = 1; i <= 10; i++ )); do
    echo "   Verification $i "

    rm -rf $path/log/P5/V$i/*.txt

    (time ./refines --brief $path/CSPFiles/mainP5.csp) 1>> "$path/log/P5/V$i/assertionFDR4V$i.txt" 2>> "$path/log/P5/V$i/timeFDR4V$i.txt"
    
done

echo "  Property 6 - State SMove is reachable. "


for (( i = 1; i <= 10; i++ )); do
    echo "   Verification $i "

    rm -rf $path/log/P6/V$i/*.txt

    (time ./refines --brief $path/CSPFiles/mainP6.csp) 1>> "$path/log/P6/V$i/assertionFDR4V$i.txt" 2>> "$path/log/P6/V$i/timeFDR4V$i.txt"

done

echo "  Property 7 - State Turn180 is reachable. "

for (( i = 1; i <= 10; i++ )); do
    echo "   Verification $i "

    rm -rf $path/log/P7/V$i/*.txt

    (time ./refines --brief $path/CSPFiles/mainP7.csp) 1>> "$path/log/P7/V$i/assertionFDR4V$i.txt" 2>> "$path/log/P7/V$i/timeFDR4V$i.txt"

done

echo "  Property 8 - The behavior of communication should consist of a broadcast followed by a receive event."


for (( i = 1; i <= 10; i++ )); do
    echo "   Verification $i "

    rm -rf $path/log/P8/V$i/*.txt

    (time ./refines --brief $path/CSPFiles/mainP8.csp) 1>> "$path/log/P8/V$i/assertionFDR4V$i.txt" 2>> "$path/log/P8/V$i/timeFDR4V$i.txt"

done

echo "  Property 9 - The robot should start moving, and after every obstacle, move at least once. "


for (( i = 1; i <= 10; i++ )); do
    echo "   Verification $i "

    rm -rf $path/log/P9/V$i/*.txt

    (time ./refines --brief $path/CSPFiles/mainP9.csp) 1>> "$path/log/P9/V$i/assertionFDR4V$i.txt" 2>> "$path/log/P9/V$i/timeFDR4V$i.txt"

done

echo "  Property 10 - Initially, and after exactly RC time units, when a broadcast.id happens, the events broadcast and receive are offered before RC time units elapse. "


for (( i = 1; i <= 10; i++ )); do
    echo "   Verification $i "

    rm -rf $path/log/P10/V$i/*.txt

    (time ./refines --brief $path/CSPFiles/mainP10.csp) 1>> "$path/log/P10/V$i/assertionFDR4V$i.txt" 2>> "$path/log/P10/V$i/timeFDR4V$i.txt"


echo "FINISHED"
