#!/bin/bash

while IFS=',' read -ra array; do
  test+=("${array[0]}")
  result+=("${array[1]}")
done < tests.csv   

for i in `seq 1 ${#test[@]}`
do
    if ./tcas$1  ${test[$i-1]} | grep -q "${result[$i-1]/ /}"; then
        echo $i:P
        :
    else
        echo $i:F
        #echo $i:F   ---  `./tcas  ${test[$i-1]}` --- ${result[$i-1]} ----------- ${test[$i-1]}
    fi


done
