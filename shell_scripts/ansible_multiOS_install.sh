#!/bin/bash
# ------------------------------------------------
# Install ansible MultiOS by Alex
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
			if [[ ${VERSION_ID} -lt 9 ]]; then
				echo "Your version of Debian (${VERSION_ID}) is not supported. Please use Debian 9 Stretch or later"
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

function installAsible() {
  if [[ ${OS} == 'ubuntu' ]]; then # Ubuntu
    apt update
    apt install -y software-properties-common
    apt add-apt-repository --yes --update ppa:ansible/ansible
    echo -e "${GREEN}-------------------- Installing Ansible --------------------${NC}"
    apt install -y ansible
    echo -e "${GREEN}-------------------- Done! --------------------${NC}"
  elif [[ ${OS} == 'debian' ]]; then # Debian
    if [[ ${VERSION_ID} -eq 9 ]]; then
      deb http://ppa.launchpad.net/ansible/ansible/ubuntu xenial main
    elif [[ ${VERSION_ID} -eq 10 ]]; then
      deb http://ppa.launchpad.net/ansible/ansible/ubuntu bionic main
    elif [[ ${VERSION_ID} -eq 11 ]]; then
      deb http://ppa.launchpad.net/ansible/ansible/ubuntu focal main
    fi
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
    apt update
    echo -e "${GREEN}-------------------- Installing Ansible --------------------${NC}"
    apt install -y ansible
    echo -e "${GREEN}-------------------- Done! --------------------${NC}"
  elif [[ ${OS} == 'fedora' ]]; then # Fedora
    echo -e "${GREEN}-------------------- Installing Ansible --------------------${NC}"
    dnf install -y ansible
    echo -e "${GREEN}-------------------- Done! --------------------${NC}"
  elif [[ ${OS} == 'centos' ]]; then # CentOS
    yum install -y epel-release
    echo -e "${GREEN}-------------------- Installing Ansible --------------------${NC}"
    yum install -y ansible
    echo -e "${GREEN}-------------------- Done! --------------------${NC}"
  elif [[ ${OS} == 'redhat' ]]; then # RedHat
    echo -e "${GREEN}-------------------- Installing Ansible --------------------${NC}"
    yum install -y ansible
    echo -e "${GREEN}-------------------- Done! --------------------${NC}"
  fi
}

initialCheck
installAsible
