#!/bin/bash
array=(5 2 3 1 7)

# Length of the array
length=${#array[@]}

# bubble sort algorithm
for ((i = 0; i < length-1; i++)); do
  for ((j = 0; j < length-i-1; j++)); do
    if [ ${array[j]} -gt ${array[j+1]} ]; then
      temp=${array[j]}
      array[j]=${array[j+1]}
      array[j+1]=$temp
    fi
  done
done

# Printing
echo "Sorted array: ${array[@]}"
