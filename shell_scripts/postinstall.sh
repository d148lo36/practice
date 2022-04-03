#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"
workdir="/home"

echo
echo -e "$RED----- This is post installation script by Alex -----$ENDCOLOR"
echo
echo -e "$YELLOW----- Prepare to install Google Chrome -----$ENDCOLOR"

if apt list --installed | grep google-chrome-stable
then
echo -e "$GREEN----- Chrome is installed -----$ENDCOLOR"
else
  if grep ls $workdir/google-chrome-stable_current_amd64.deb
  then
    echo -e "$GREEN----- Chrome binary is exist -----$ENDCOLOR"
  else
    wget -P $workdir https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  fi

  if apt list --installed | grep google-chrome-stable
  then
    echo -e "$GREEN----- Chrome is installed -----$ENDCOLOR"
  else
    echo -e "$YELLOW----- Prepare to install Google Chrome -----$ENDCOLOR"
    echo
    echo -e "$GREEN----- Install Google Chrome -----$ENDCOLOR"
    dpkg -i $workdir/google-chrome-stable_current_amd64.deb
  fi
fi



if apt list --installed | grep atom/any
then
echo -e "$GREEN----- Atom is installed -----$ENDCOLOR"
else
echo -e "$RED----- Atom is not installed -----$ENDCOLOR"
echo
echo -e "$YELLOW----- Prepare to install Atom -----$ENDCOLOR"
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add
sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
apt update

echo -e "$GREEN----- Install Atom -----$ENDCOLOR"
apt install atom
fi
