# A script that takes a number as input and checks whether it is a prime number or not

#!/bin/bash
echo "Enter a number"
read num

# 0 and 1 are not prime numbers
if [ $num -lt 2]; then
 echo "$num is not a prime number."
 exit
fi

# Check for factors from 2 to the square root of the number
for ((i=2; i*i<=$num; i++)); do
  if [ $(($num % $i)) -eq 0 ]; then
echo "$num is not a prime number."
exit
fi
done

echo "$num is a prime number."
