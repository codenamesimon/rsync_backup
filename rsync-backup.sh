# The ultimate Backup script with rsync

# Some variables:

# This file contains global ignored folders and files for RSYNC
GLOBAL_RSYNC_IGNORE="/mnt/c/.rsync-ignore-global"

# This is the filename that contains RSYNC specific ignore rules in a VCS style
RSYNC_FILTER_NAME=".rsync-filter"

# Backup directory. 
# This directory will be used, when a file from SOURCE will be changed. Before being overriden at TARGET
# the file will be copied to the directory, tagged with the suffix
# Use Full path.
BACKUP_DIR="/mnt/nas/Backup/Windows_Deleted"

# SOURCE dir
# This is the path from which the backup will start.
SOURCE_DIR="/mnt/c"

# TARGET dir
# This is the path to a directory where the backup will be stored
TARGET_DIR="/mnt/nas/Backup/Windows/"

#Explanation of the command itself:
# rsync -rvvb
## -r  - recursive
## -b  - backs up deleted and modified files
## -vv - double-verbose
# --exclude='.git' 
## It will always exclude directory or file named '.git' 
# --filter='merge, $GLOBAL_RSYNC_IGNORE' 
## configuration of the global ignore file
# --filter='dir-merge,-n /.gitignore' 
## Adding filter based on .gitignore file
# --filter='dir-merge,-n /$RSYNC_FILTER_NAME' 
## Adding filder based on the RSYNC_FILTER_NAME file. 
## NOTE: This will override .gitignore, so if .gitignore excludes sth,
## this file can include it back
# --update 
## enables differential backup
# --times 
## preserves 'modified' time
# --delete-excluded
## if a folder or file will be excluded after it was backuped, it will be deleted from TARGET 
# $SOURCE_DIR $TARGET_DIR
## directories setup

rsync -rvvb \
--exclude='.git' \
--filter='merge, $GLOBAL_RSYNC_IGNORE' \
--filter='dir-merge,-n /.gitignore' \
--filter='dir-merge,-n /$RSYNC_FILTER_NAME' \
--backup-dir=$BACKUP_DIR --suffix=$(date+_%F-%T) \
--update \
--times  \
--delete-excluded \
$SOURCE_DIR \
$TARGET_DIR

# MANUAL:
# https://ss64.com/bash/rsync.html
# https://linux.die.net/man/1/rsync

# RESOURCES:
# https://serverfault.com/questions/279609/what-exactly-will-delete-excluded-do-for-rsync
# https://rootconsole.net/how-to-do-backup-with-rsync-and-keep-a-copy-of-modified-files/

