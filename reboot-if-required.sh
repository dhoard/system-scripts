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
  echo "Unsupported OS = $NAME"
  exit 1
fi

if [ "apt" == "$PACKAGE_MANAGER" ]; then
  if [ -f /var/run/reboot-required ]; then
    reboot
  else
    OUTPUT=`needrestart -b 2>&1 | grep "NEEDRESTART-SVC"`
    if [ "$OUTPUT" != "" ]; then
      reboot
    else
      OUTPUT=`needrestart -b 2>&1 | grep "NEEDRESTART-KSTA"`
      if [ "$OUTPUT" != "NEEDRESTART-KSTA: 1" ]; then
        reboot
      fi
    fi
  fi
fi

if [ "dnf" == "$PACKAGE_MANAGER" ]; then
  OUTPUT=`needs-restarting -r 2>&1 | grep "Reboot should not be necessary."`
  if [ "$OUTPUT" != "Reboot should not be necessary." ]; then
    reboot
  fi
fi
