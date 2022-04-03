#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

echo -e "${RED}-------------------- Stopping docker service --------------------${ENDCOLOR}"

systemctl stop docker.socket
systemctl stop docker.service

echo -e "${GREEN}-------------------- Prepare to install docker, get update from repo --------------------${ENDCOLOR}"

apt install -y ca-certificates curl gnupg lsb-release

echo -e "${GREEN}-------------------- Add Docker official GPG key --------------------${ENDCOLOR}"

curl -fsSL \
https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --batch --yes -o /usr/share/keyrings/docker-archive-keyring.gpg

echo -e "${GREEN}-------------------- Add stable repo --------------------${ENDCOLOR}"

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo -e "${GREEN}-------------------- Get update from repo --------------------${ENDCOLOR}"

apt update -y

echo -e "${GREEN}-------------------- Installing Docker --------------------${ENDCOLOR}"

apt install -y docker-ce docker-ce-cli containerd.io

echo -e "${GREEN}-------------------- Add docker group --------------------${ENDCOLOR}"

groupadd docker
usermod -aG docker $USER

echo -e "${YELLOW}-------------------- Starting docker service --------------------${ENDCOLOR}"

systemctl start docker
systemctl enable docker

echo -e "${GREEN}-------------------- Test docker --------------------${ENDCOLOR}"

docker run hello-world

echo -e "${GREEN}-------------------- Done! --------------------${ENDCOLOR}"
