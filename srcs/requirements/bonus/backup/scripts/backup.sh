#!/bin/sh

printf "\nBackup server started..."

# Create a backup every x minutes
while true; do

  # Current date
  FILE_DATE=$(date +"%Y-%m-%d_%H-%M-%S")
  FOLDER_DATE=$(date +"%Y-%m-%d")

  # Create a backup folder with the current date
  mkdir -p /backup/"$FOLDER_DATE"

  # Create a backup
  mysqldump -h "$WORDPRESS_DB_HOST" "$WORDPRESS_DB_NAME" \
      -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" \
      > /backup/"$FOLDER_DATE"/"$DOMAIN"_"$FILE_DATE".sql

  printf "Backup created: %s.sql" "$DOMAIN_$FILE_DATE"

  # Delete old folder backups (older than 7 day)
  find /backup/* -mtime +7 -exec rm -rf {} \;

  # Wait 15 minutes
  sleep 900
done

exit 0