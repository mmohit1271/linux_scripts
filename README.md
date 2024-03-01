# linux_scripts
Some useful linux scripts 

1. Backup Script

# Backup Script

This script automates the backup of a specified directory to a backup destination and sends an email notification upon completion.

## Usage

1. Set the source directory to be backed up by modifying the `source_dir` variable in the script.
2. Set the destination directory where backups will be stored by modifying the `backup_dir` variable in the script.
3. Set the email address to receive notifications by modifying the `email_address` variable in the script.
4. Set up an SMTP server configuration for sending emails (e.g., Gmail SMTP).
5. Make sure the required packages for sending emails are installed (e.g., `ssmtp`, `mailutils`).
6. Make the script executable:
   ```bash
   chmod +x backup_script.sh

* Run the Script
./backup_script.sh




