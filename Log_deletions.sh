#!/bin/bash

# log all deleted actions
recycle_bin="$HOME/recycle_bin"
log_file="$HOME/recycle_bin.log"

# Check if recycle bin directory exists, create if not
if [ ! -d "$recycle_bin" ]; then
    mkdir -p "$recycle_bin"
fi

touch "$log_file"  # Create log file if it doesn't exist

# Function to move deleted items to recycle bin and log the action
move_to_recycle_bin() {
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    for item in "$@"; do
        mv "$item" "$recycle_bin"
        echo "$timestamp - Deleted: $item" >> "$log_file"
        echo "Deleted: $item"
    done
}

# Main script
echo "Use this script to delete files/folders. They will be moved to the recycle bin, and actions will be logged."
echo "Enter 'exit' to quit."

# Add cron job
if crontab -l | grep -q "$0"; then
    echo "Cron job already exists."
else
    (crontab -l ; echo "0 0 * * * echo 'Running $0' && /bin/bash $0 && echo 'Cron job added for $0'") | crontab -
    echo "Cron job added."
fi

while true; do
    read -p "Enter file/folder to delete: " input

    if [ "$input" == "exit" ]; then
        echo "Exiting script."
        exit 0
    fi

    if [ -e "$input" ]; then
        move_to_recycle_bin "$input"
    else
        echo "File/folder not found: $input"
    fi
done
