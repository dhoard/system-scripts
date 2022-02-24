#!/bin/bash

source /etc/os-release
TYPE=Unknown

if [ "Ubuntu" == "$NAME" ]; then
  echo "Ubuntu"
  TYPE=apt
elif [ "Linux Mint" == "$NAME" ]; then
  echo "Linux Mint"
  TYPE=apt
elif [ "Raspbian GNU/Linux" == "$NAME" ]; then
  echo "Raspbian GNU/Linux"
  TYPE=apt
elif [ "AlmaLinux" = "$NAME" ]; then
  echo "AlmaLinux"
  TYPE=dnf
else
  echo "Unknown"
  exit 1
fi

if [ "apt" == "$TYPE" ]; then
  apt-get update
  apt-get -u upgrade --assume-no
fi

if [ "dnf" == "$TYPE" ]; then
  dnf list updates
fi
