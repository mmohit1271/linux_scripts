#!/bin/bash

# Directory to be backed up
source_dir="/path/to/source/directory"

# Backup directory
backup_dir="/path/to/backup/directory"

# Number of backup files to retain
retain_count=5

# Log file
log_file="/path/to/backup/log/backup_log.txt"

# Email notification settings
send_email=true
email_recipient="your_email@example.com"
email_subject="Backup Status"

# Create timestamp for the backup filename
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# Create the backup filename
backup_filename="backup_$timestamp.tar.gz"

# Archive the source directory and compress it
tar -czf "$backup_dir/$backup_filename" "$source_dir"

# Check if backup was successful
if [ $? -eq 0 ]; then
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Backup completed successfully: $backup_filename" >> "$log_file"
else
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Backup failed" >> "$log_file"
    if [ "$send_email" = true ]; then
        echo "Backup failed for $source_dir. Please check." | mail -s "$email_subject" "$email_recipient"
    fi
    exit 1
fi

# Remove older backups if necessary
backup_files=$(ls -t "$backup_dir" | grep '^backup_' | tail -n +$(($retain_count + 1)))
if [ -n "$backup_files" ]; then
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Removing old backup files:" >> "$log_file"
    for file in $backup_files; do
        rm "$backup_dir/$file"
        echo "$(date +"%Y-%m-%d %H:%M:%S") - Removed: $file" >> "$log_file"
    done
fi

# Send email notification upon successful backup
if [ "$send_email" = true ]; then
    echo "Backup completed successfully for $source_dir." | mail -s "$email_subject" "$email_recipient"
fi
