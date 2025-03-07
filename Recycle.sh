#!/bin/bash

#Move deleted files/folders to the recycle bin.
recycle_bin="$HOME/recycle_bin"

# Check if recycle bin directory exists, create if not
if [ ! -d "$recycle_bin" ]; then
    mkdir -p "$recycle_bin"
fi

# Function to move deleted items to recycle bin
move_to_recycle_bin() {
    for item in "$@"; do
        mv "$item" "$recycle_bin"
        echo "Deleted: $item"
    done
}

# Main script
echo "Use this script to delete files/folders. They will be moved to the recycle bin."
echo "Enter 'exit' to quit."

# Add cron job
if crontab -l | grep -q "$0"; then
    echo "Cron job already exists."
else
    (crontab -l 2>/dev/null; echo "0 0 * * * echo 'Running $0' && /bin/bash $0 && echo 'Cron job added for $0'") | crontab -
    echo "Cron job added."
fi

while true; do
    read -p "Enter file/folder to delete: " input

    if [ "$input" = "exit" ]; then
        echo "Exiting script."
        exit 0
    fi

    if [ -e "$input" ]; then
        move_to_recycle_bin "$input"
    else
        echo "File/folder not found: $input"
    fi
done