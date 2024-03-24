#!/bin/bash
echo "Enter number"
read num

# Count the number of digits in the entered number
num_digits=${#num}
sum=0
temp=num

# Calculate the sum of digits each raised to the power of the number of digits
while [ $temp -gt 0 ]; do
digit=$(( $temp % 10 ))
sum=$(( $sum + $digit ** $num_digits))
temp=$(( $temp / 10))
done

# Check if the number is an Armstrong number
 if [ $sum -eq $num ]; then

echo "$user_input is an Armstrong number."
else
echo "$user_input is not an Armstrong number."
fi
