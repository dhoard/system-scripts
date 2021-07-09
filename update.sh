#!/bin/bash

source /etc/os-release

if [ "Ubuntu" == "$NAME" ]; then
  echo "Ubuntu"
elif [ "Linux Mint" == "$NAME" ]; then
  echo "Linux Mint"
else
  echo "Unknown"
  exit 1
fi

sudo apt-get -y update -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold'
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt autoremove -y

if [ -f /var/run/reboot-required ]; then
  echo 'reboot required'
fi
