#!/bin/bash

source /etc/os-release

if [ "Ubuntu" == "$NAME" ]; then
  echo "Ubuntu"
elif [ "Linux Mint" == "$NAME" ]; then
  echo "Linux Mint"
elif [ "Raspbian GNU/Linux" == "$NAME" ]; then
  echo "Raspbian GNU/Linux"
else
  echo "Unknown"
  exit 1
fi

if [ "Raspbian GNU/Linux" == "$NAME" ]; then
  apt-get -y update
else
  apt-get -y update -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold'
fi

apt-get -y upgrade
apt-get -y dist-upgrade
apt-get -y autoremove

if [ -f /var/run/reboot-required ]; then
  echo 'reboot required'
fi
