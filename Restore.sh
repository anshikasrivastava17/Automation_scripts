#!/bin/bash

recycle_bin="$HOME/recycle_bin"

# Function to restore items from recycle bin
restore_from_recycle_bin() {
    for item in "$@"; do
        original_path="$(basename "$item")"
        if [ -e "$original_path" ]; then
            echo "Error: Item already exists at the original location: $original_path"
        else
            mv "$recycle_bin/$item" ./
            echo "Restored: $item"
        fi
    done
}

# Main script
echo "Use this script to restore files/folders from the recycle bin."
echo "Enter 'exit' to quit."

# Add cron job
if crontab -l | grep -q "$0"; then
    echo "Cron job already exists."
else
    (crontab -l 2>/dev/null; echo "0 0 * * * echo 'Running $0' && /bin/bash $0 && echo 'Cron job added for $0'") | crontab -
    echo "Cron job added."
fi

while true; do
    read -p "Enter file/folder to restore: " input

    if [ "$input" = "exit" ]; then
        echo "Exiting script."
        exit 0
    fi

    if [ -e "$recycle_bin/$input" ]; then
        restore_from_recycle_bin "$input"
    else
        echo "Item not found in the recycle bin: $input"
    fi
done