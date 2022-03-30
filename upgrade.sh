#!/bin/bash

source /etc/os-release
PACKAGE_MANAGER=Unknown

if [ "Ubuntu" == "$NAME" ]; then
  PACKAGE_MANAGER=apt
elif [ "Linux Mint" == "$NAME" ]; then
  PACKAGE_MANAGER=apt
elif [ "Raspbian GNU/Linux" == "$NAME" ]; then
  PACKAGE_MANAGER=apt
elif [ "AlmaLinux" = "$NAME" ]; then
  PACKAGE_MANAGER=dnf
else
  echo "Unknown Linux type"
  exit 1
fi

if [ "apt" == "$PACKAGE_MANAGER" ]; then
  if [ "Raspbian GNU/Linux" == "$NAME" ]; then
    apt-get -y update
  else
    apt-get -y update -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold'
  fi

  apt-get -y upgrade
  apt-get -y autoremove
fi

if [ "dnf" == "$PACKAGE_MANAGER" ]; then
  dnf upgrade --refresh -y
fi

if [ "apt" == "$PACKAGE_MANAGER" ]; then
  if [ -f /var/run/reboot-required ]; then
    echo "reboot required"
  else
    OUTPUT=`needrestart 2>&1 | grep "outdated processes"`
    if [ "$OUTPUT" != "" ]; then
      echo "reboot required"
    fi
  fi
fi

if [ "dnf" == "$PACKAGE_MANAGER" ]; then
  OUTPUT=`needs-restarting -r 2>&1 | grep "Reboot should not be necessary."`
  if [ "$OUTPUT" != "Reboot should not be necessary." ]; then
    echo "reboot required"
  fi
fi
