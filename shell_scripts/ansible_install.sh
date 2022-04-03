#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

echo -e "${RED}-------------------- Get update from repo --------------------${ENDCOLOR}"
apt -y update
echo -e "${GREEN}-------------------- Installing software-properties-common --------------------${ENDCOLOR}"
apt install -y software-properties-common
echo -e "${GREEN}-------------------- Add ansible repo --------------------${ENDCOLOR}"
add-apt-repository --yes --update ppa:ansible/ansible
echo -e "${GREEN}-------------------- Install Ansible --------------------${ENDCOLOR}"
apt install -y ansible
echo -e "${GREEN}-------------------- Done! --------------------${ENDCOLOR}"
