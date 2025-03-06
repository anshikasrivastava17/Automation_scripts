#!/bin/bash

read -e -p "Enter file name " forbid_file
#block forbidden commands written in a file
echo $forbid_file

# Check if the forbidden commands file exists
if [ ! -f "$forbid_file" ]; then
    echo "Error: Forbidden commands file not found"
    exit 1
fi

# Read the forbidden commands into an array
readarray -t forbidden_comm < "$forbid_file"

# Get the user input for command
read -p "Enter the command: " user_command

# Check if the entered command is in the forbidden list
for cmd in "${forbidden_comm[@]}"; do
    if [[ "$user_command" == "$cmd"* ]]; then
        echo "Error: Execution of '$user_command' is forbidden"
        exit 1
    fi
done

# Execute the command if not forbidden
eval "$user_command"

# Add script to crontab
path_to_script=$(realpath "$0")
if ! (crontab -l | grep -Fqx "0 0 * * * $path_to_script > /dev/null 2>&1"); then
    (crontab -l; echo "0 0 * * * $path_to_script > /dev/null 2>&1") | crontab -
    echo "Script added to Cron"
fi