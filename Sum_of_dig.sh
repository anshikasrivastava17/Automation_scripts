# A script that calculates the sum of the digits of a given number.

#!/bin/bash
echo "Enter number"
read num
sum=0

while [ $num -gt 0 ]; do
digit=$(($num % 10)) # Extract the last digit
sum=$(($sum + $digit)) # Add the digit to the sum 
num=$(($num / 10)) # Remove the last digit

done
echo "The sum of digits is: $sum"
