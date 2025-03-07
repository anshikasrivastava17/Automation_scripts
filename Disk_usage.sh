#!/bin/bash

#Monitor the disk usage and alert if it is beyond the given threshold.
# Set the threshold for disk usage (in percentage)
threshold=90

# Get the current directory of the script
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Get the current disk usage
current_usage=$(df -h / | awk 'NR==2 {print $5}' | cut -d'%' -f1)

# Check if disk usage exceeds the threshold
if [ "$current_usage" -gt "$threshold" ]; then
    # Send an alert
    echo "Disk usage is beyond the threshold. Current Usage: $current_usage%"
    mail -s "Disk Usage Alert" anshikashrivastava561@gmail.com <<< "Disk usage is beyond the threshold. Current Usage: $current_usage%"
else
    echo "Disk usage is within the threshold. Current Usage: $current_usage%"
fi

# Check if the cron job is already added
if crontab -l | grep -q "$script_dir"; then
    echo "Cron job already exists. Not added."
else
    # Add cron job
    (crontab -l 2>/dev/null; echo "*/5 * * * * /bin/bash $script_dir/$(basename "$0")") | crontab -
    echo "Cron job added successfully."
fi