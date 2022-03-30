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
  echo "Unknown Linux OS = $NAME"
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
    OUTPUT=`needrestart -b 2>&1 | grep "NEEDRESTART-SVC"`
    if [ "$OUTPUT" != "" ]; then
      echo "reboot required"
    else
      OUTPUT=`needrestart -b 2>&1 | grep "NEEDRESTART-KSTA"`
      if [ "$OUTPUT" != "NEEDRESTART-KSTA: 1" ]; then
        if [ "$NAME" != "Raspbian GNU/Linux"]; then
          echo "reboot required"
        fi
      fi
    fi
  fi
fi

if [ "dnf" == "$PACKAGE_MANAGER" ]; then
  OUTPUT=`needs-restarting -r 2>&1 | grep "Reboot should not be necessary."`
  if [ "$OUTPUT" != "Reboot should not be necessary." ]; then
    echo "reboot required"
  fi
fi
