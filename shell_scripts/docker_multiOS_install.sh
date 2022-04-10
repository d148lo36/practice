#!/bin/bash
# ------------------------------------------------
# Install docker MultiOS by Alex
#
# 2022
# ------------------------------------------------

RED='\033[0;31m'
ORANGE='\033[0;33m'
GREEN="\e[32m"
NC='\033[0m'

function initialCheck() {
	isRoot
	checkOS
}

function isRoot() {
	if [ "${EUID}" -ne 0 ]; then
		echo -e "${RED}-------------------- You need to run this script as root --------------------${NC}"
		exit 1
	fi
}

function checkOS() {
	# Check OS version
	if [[ -e /etc/debian_version ]]; then
		source /etc/os-release
		OS="${ID}" # debian or ubuntu
		if [[ ${ID} == "debian" || ${ID} == "raspbian" ]]; then
			if [[ ${VERSION_ID} -lt 10 ]]; then
				echo "Your version of Debian (${VERSION_ID}) is not supported. Please use Debian 10 Buster or later"
				exit 1
			fi
			OS=debian # overwrite if raspbian
		fi
	elif [[ -e /etc/fedora-release ]]; then
		source /etc/os-release
		OS="${ID}"
	elif [[ -e /etc/centos-release ]]; then
		source /etc/os-release
		OS=centos
  elif [[ -e /etc/redhat-release ]]; then
    source /etc/redhat-release
    OS=redhat
	else
		echo "Looks like you aren't running this installer on a Debian, Ubuntu, Fedora, RedHat and CentOS system"
		exit 1
	fi
}

function installDocker() {

  if [[ ${OS} == 'ubuntu' ]] || [[ ${OS} == 'debian' && ${VERSION_ID} -gt 10 ]]; then # Ubuntu and Debian
    echo -e "${RED}-------------------- Remove older docker version  --------------------${NC}"
    apt remove docker docker-engine docker.io containerd runc
		apt update
		apt install -y ca-certificates curl gnupg lsb-release
    if [[ ${OS} == 'debian' && ${VERSION_ID} -gt 10 ]]; then # Debian
      curl -fsSL \
      https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
      echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    fi
    if [[ ${OS} == 'ubuntu' ]]; then # Ubuntu
      curl -fsSL \
      https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --batch --yes -o /usr/share/keyrings/docker-archive-keyring.gpg
      echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    fi
    apt update -y
    echo -e "${GREEN}-------------------- Installing Docker --------------------${NC}"
    apt install -y docker-ce docker-ce-cli containerd.io
    groupadd docker
    usermod -aG docker $USER
		chmod 666 /var/run/docker.sock
    echo -e "${GREEN}-------------------- Starting docker service --------------------${NC}"
    systemctl start docker
    systemctl enable docker
    docker run hello-world
    echo -e "${GREEN}-------------------- Done! --------------------${NC}"
  elif [[ ${OS} == 'centos' ]]; then # CentOS
    echo -e "${RED}-------------------- Remove older docker version  --------------------${NC}"
    yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
    yum install -y yum-utils
    yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
    echo -e "${GREEN}-------------------- Installing Docker --------------------${NC}"
    yum install docker-ce docker-ce-cli containerd.io
    groupadd docker
    usermod -aG docker $USER
		chmod 666 /var/run/docker.sock
    echo -e "${GREEN}-------------------- Starting docker service --------------------${NC}"
    systemctl start docker
    docker run hello-world
    echo -e "${GREEN}-------------------- Done! --------------------${NC}"
  elif [[ ${OS} == 'fedora' ]]; then # Fedora
    if [[ ${VERSION_ID} -lt 34 ]]; then
      echo -e "${RED}-------------------- This version of Fedora (${VERSION_ID}) is not supported!!! --------------------${NC}"
      exit 1
    fi
    echo -e "${RED}-------------------- Remove older docker version  --------------------${NC}"
    dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine
    dnf -y install dnf-plugins-core
    dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo
    echo -e "${GREEN}-------------------- Installing Docker --------------------${NC}"
    dnf install docker-ce docker-ce-cli containerd.io
    groupadd docker
    usermod -aG docker $USER
		chmod 666 /var/run/docker.sock
    echo -e "${GREEN}-------------------- Starting docker service --------------------${NC}"
    systemctl start docker
    docker run hello-world
    echo -e "${GREEN}-------------------- Done! --------------------${NC}"
  elif [[ ${OS} == 'redhat' ]]; then # RedHat
    echo -e "${RED}-------------------- Remove older docker version  --------------------${NC}"
    yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine \
                  podman \
                  runc
    yum install -y yum-utils
    yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/rhel/docker-ce.repo
    echo -e "${GREEN}-------------------- Installing Docker --------------------${NC}"
    yum install docker-ce docker-ce-cli containerd.io
    groupadd docker
    usermod -aG docker $USER
		chmod 666 /var/run/docker.sock
    echo -e "${GREEN}-------------------- Starting docker service --------------------${NC}"
    systemctl start docker
    docker run hello-world
    echo -e "${GREEN}-------------------- Done! --------------------${NC}"
  fi
}

initialCheck
installDocker
