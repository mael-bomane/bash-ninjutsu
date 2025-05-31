#!/bin/bash

read -p "Directory to backup: " dir
read -p "Remote user@host (e.g., user@example.com): " remote
read -p "Remote destination path (e.g., /remote/backup/): " remote_path

# Validate directory
if [[ ! -d "$dir" ]]; then
    echo "Error: Directory '$dir' does not exist."
    exit 1
fi

# Create timestamp
timestamp=$(date +%Y%m%d_%H%M%S)

# Archive filename
archive="backup_${timestamp}.tar.gz"

# Create tar archive of directory CONTENTS (not including the directory itself)
tar -czf "$archive" -C "$dir" .

if [[ $? -ne 0 ]]; then
    echo "Error: Failed to create archive."
    exit 1
fi

# Copy archive to remote via scp
scp "$archive" "${remote}:${remote_path}"

if [[ $? -ne 0 ]]; then
    echo "Error: Failed to copy archive to remote."
    exit 1
fi

# Remove local archive
rm "$archive"

echo "Backup successful: $archive sent to $remote:$remote_path"

