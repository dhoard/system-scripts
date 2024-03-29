#!/bin/bash

OUTPUT=`grep "# tune.sh" /etc/sysctl.conf`

if [ "$OUTPUT" == "" ]; then

  echo "#" >> /etc/sysctl.conf
  echo "# tune.sh" >> /etc/sysctl.conf
  echo "#" >> /etc/sysctl.conf

  echo net.core.rmem_max=16777216 >> /etc/sysctl.conf
  echo net.core.wmem_max=16777216 >> /etc/sysctl.conf
  echo net.ipv4.tcp_rmem=4096 87380 16777216 >> /etc/sysctl.conf
  echo net.ipv4.tcp_wmem=4096 65536 16777216 >> /etc/sysctl.conf
  echo 'vm.swappiness=5' >> /etc/sysctl.conf
  echo 'vm.vfs_cache_pressure=50' >> /etc/sysctl.conf

  sysctl -p

  echo 0 > /sys/block/vda/queue/rotational
  echo 0 > /sys/block/vda/queue/rq_affinity
  echo "none" > /sys/block/vda/queue/scheduler

  #echo "#" >> /etc/rc.local
  #echo "# tune.sh" >> /etc/rc.local
  #echo "#" >> /etc/rc.local

  echo "echo 0 > /sys/block/vda/queue/rotational" >> /etc/rc.local
  echo "echo 0 > /sys/block/vda/queue/rq_affinity" >> /etc/rc.local
  echo "echo none > /sys/block/vda/queue/scheduler" >> /etc/rc.local

  #chmod u+x /etc/rc.local
  #systemctl enable rc-local
  #systemctl restart rc-local
  #systemctl restart rc-local

fi
