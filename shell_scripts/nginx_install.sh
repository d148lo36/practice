#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

src="/home/alex/practice/files"
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
# src_files = os.listdir(src)
# for file_name in src_files:
#     full_file_name = os.path.join(src, file_name)
#     if os.path.isfile(full_file_name):
#         shutil.copy(full_file_name, dest)
echo -e "${GREEN}-------------------- Restart Nginx web server --------------------${ENDCOLOR}"

service nginx restart

echo -e "${GREEN}-------------------- All done!!! --------------------${ENDCOLOR}"
