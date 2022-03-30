#!/bin/bash

source /etc/os-release
TYPE=Unknown

if [ "Ubuntu" == "$NAME" ]; then
  TYPE=apt
elif [ "Linux Mint" == "$NAME" ]; then
  TYPE=apt
elif [ "Raspbian GNU/Linux" == "$NAME" ]; then
  TYPE=apt
elif [ "AlmaLinux" = "$NAME" ]; then
  TYPE=dnf
else
  echo "Unsupported OS = $NAME"
  exit 1
fi

if [ "apt" == "$TYPE" ]; then
  apt-get update
  apt-get -u upgrade --assume-no
fi

if [ "dnf" == "$TYPE" ]; then
  dnf list updates
fi
