#!/bin/bash

source /etc/os-release
PACKAGE_MANAGER=Unknown

if [ "Ubuntu" == "$NAME" ]; then
  echo "Ubuntu"
  PACKAGE_MANAGER=apt
elif [ "Linux Mint" == "$NAME" ]; then
  echo "Linux Mint"
  PACKAGE_MANAGER=apt
elif [ "Raspbian GNU/Linux" == "$NAME" ]; then
  echo "Raspbian GNU/Linux"
  PACKAGE_MANAGER=apt
elif [ "AlmaLinux" = "$NAME" ]; then
  echo "AlmaLinux"
  PACKAGE_MANAGER=dnf
else
  echo "Unknown Linux type"
  exit 1
fi

if [ "apt" == "$PACKAGE_MANAGER" ]; then
  if [ -f /var/run/reboot-required ]; then
    reboot
  fi
fi

if [ "dnf" == "$PACKAGE_MANAGER" ]; then
  OUTPUT=`needs-restarting -r | grep "Reboot should not be necessary."`
  if [ "$OUTPUT" != "Reboot should not be necessary." ]; then
    reboot
  fi
fi
