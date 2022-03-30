#!/bin/bash

if [ ! -f "${2}" ]
then
  SUFFIX=$RANDOM$RANDOM
  FILE=($mktemp /tmp/run-on-hosts.${SUFFIX})
  echo "${2}" > ${FILE}
else
  FILE="${2}"
fi

rm -Rf ~/run-on.hosts.log
while read SERVERNAME 
do
  ping -c 1 ${SERVERNAME} > /dev/null 2>&1
  if [ "$?" == "0" ]
  then
    echo "[${SERVERNAME}]" | tee -a run-on-hosts.log 2>&1
    ssh administrator@${SERVERNAME} 'bash -s' < "${FILE}" | tee -a run-on-hosts.log 2>&1
  else
    echo "[!${SERVERNAME}]" | tee -a run-on-hosts.log 2>&1
  fi

done < "${1}"
