#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

src="/home/alex/practice/files/*"
dest="/var/www/html"

echo -e "${GREEN}-------------------- Install nginx and copy files to /var/www/html --------------------${ENDCOLOR}"

apt update
apt -y install nginx

echo -e "${YELLOW}-------------------- Configuration firewall --------------------${ENDCOLOR}"

ufw app list
ufw allow 'Nginx HTTP'
ufw status

echo -e "${GREEN}-------------------- Checking your Web server --------------------"

systemctl status nginx

echo -e "${YELLOW}-------------------- Copy files from $src to $dest --------------------${ENDCOLOR}"

cp -r $src $dest

echo -e "${GREEN}-------------------- Restart Nginx web server --------------------${ENDCOLOR}"

service nginx restart

echo -e "${GREEN}-------------------- All done!!! --------------------${ENDCOLOR}"
