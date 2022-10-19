#!/bin/bash
#
# bash scripts to generate env file
# Usage: ./env-gen.sh
#
# Author: jmartin@42lausanne.ch
# Date: 01.10.2022

# Color
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
GREY='\033[1;37m'
NC='\033[0m'

# Variables
BASEDIR=./srcs/
ENV_PATH=$BASEDIR.env

# Catch if ctrl+c is pressed
trap ctrl_c INT
function ctrl_c() {
  echo -e "\n${RED}Exiting${NC}"
  exit 1
}

# Check if .env file exists in project
if [ -f $ENV_PATH ]; then
  echo -e "${YELLOW}.env file already exists${NC}"
  # ask if user wants to overwrite¨
  read -p "Do you want to overwrite it? [y/n] " -n 1 -r
  # if yes, overwrite
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n\nOverwriting .env file"
    rm $ENV_PATH
    cp $BASEDIR.env.example $ENV_PATH
  # if no, exit
  else
    echo -e "\n${RED}Exiting${NC}"
    exit 1
  fi
# if .env file does not exist, create it
else
  echo -e "${YELLOW}Creating .env file${NC}"
  cp $BASEDIR.env.example $ENV_PATH
fi

# Fill .env variables with prompt input
echo -e "\n${GREY}Enter your database root password:${NC}"
read -r MYSQL_ROOT_PASSWORD
sed -i "s/MYSQL_ROOT_PASSWORD=.*/MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD/" $ENV_PATH
echo -e "\n${GREY}Enter your database password:${NC}"
read -r MYSQL_PASSWORD
sed -i "s/MYSQL_PASSWORD=.*/MYSQL_PASSWORD=$MYSQL_PASSWORD/" $ENV_PATH
echo -e "\n${GREY}Enter your database name:${NC}"
read -r MYSQL_DATABASE
sed -i "s/MYSQL_DATABASE=.*/MYSQL_DATABASE=$MYSQL_DATABASE/" $ENV_PATH
echo -e "\n${GREY}Enter your database user:${NC}"
read -r MYSQL_USER
sed -i "s/MYSQL_USER=.*/MYSQL_USER=$MYSQL_USER/" $ENV_PATH
echo -e "\n${GREY}Enter your wp admin user:${NC}"

# if .env not filled exit
if [ -z "$MYSQL_ROOT_PASSWORD" ] || [ -z "$MYSQL_PASSWORD" ] || [ -z "$MYSQL_DATABASE" ] || [ -z "$MYSQL_USER" ]; then
  echo -e "\n${RED}Error: .env file not filled${NC}"
  exit 1
else
  # if .env filled, success
  echo -e "\n${GREEN}Success!${NC} .env file created"
fi
