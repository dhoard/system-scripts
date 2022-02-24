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

  if [ "Raspbian GNU/Linux" == "$NAME" ]; then
    apt-get -y update
  else
    apt-get -y update -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold'
  fi

  apt-get -y upgrade
  apt-get -y dist-upgrade
  apt-get -y autoremove
fi

if [ "dnf" == "$TYPE" ]; then
  dnf update -y
fi

if [ -f /var/run/reboot-required ]; then
  echo 'reboot required'
fi
