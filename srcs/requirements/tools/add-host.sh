#!/bin/bash

set -e

# Variables
BASEDIR=./srcs/
ENV_PATH=$BASEDIR.env

# Search first occurrence of a DOMAIN in .env and save value to variable
DOMAIN=$(grep -m 1 DOMAIN $ENV_PATH | cut -d '=' -f2)

# Add the domain to the /etc/hosts file if it doesn't already exist
if ! grep "$DOMAIN" /etc/hosts; then
  sudo -- sh -c -e "echo '127.0.0.1  ${DOMAIN}' >> /etc/hosts"
  sudo -- sh -c -e "echo '127.0.0.1  www.${DOMAIN}' >> /etc/hosts"
  cat /etc/hosts
else
  echo "$DOMAIN Host already existing in /etc/hosts"
fi

# For wsl2, add the domain to windows hosts file => c/Windows/System32/drivers/etc/hosts via powershell command (run as admin):
# Add-Content -Path "C:\Windows\System32\drivers\etc\hosts" -Value "127.0.0.1  ${DOMAIN}"