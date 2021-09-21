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

apt-get -y update -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold'
apt-get -y upgrade
apt-get -y dist-upgrade
apt autoremove -y

if [ -f /var/run/reboot-required ]; then
  echo 'reboot required'
fi
