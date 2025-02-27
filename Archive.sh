#!/bin/bash

read -e -p "Log Directory: " log_directory
read -e -p "File Extension: " extension
read -e -p "Backup Directory: " backup_directory
# archive logs and move them to backup directory

# 00*** repeat everyday at midnight
(crontab -l ; echo "0 0 * * * /bin/bash $(realpath "$0")") | crontab -

tar czf archive.tar.gz $(find "$log_directory" -name "*.$extension")
mv archive.tar.gz "$backup_directory"/$(date +%F).tar.gz
rm $(find "$log_directory" -name "*.$extension")

exit 0