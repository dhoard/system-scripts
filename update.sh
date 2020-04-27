#!/bin/bash

sudo apt-get -y update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade && sudo apt -y autoremove

if [ -f /var/run/reboot-required ]; then
  echo 'reboot required'
fi
