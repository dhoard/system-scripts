#!/bin/bash

# @see http://ubuntugenius.wordpress.com/2011/01/08/ubuntu-cleanup-how-to-remove-all-unused-linux-kernel-headers-images-and-modules/

current_kernel="$(uname -r | sed 's/\(.*\)-\([^0-9]\+\)/\1/')"
current_ver=${current_kernel/%-generic}

echo "Running kernel version is: ${current_kernel}"

function xpkg_list() {
    dpkg -l 'linux-*' | sed '/^ii/!d;/linux-libc-dev/d;/'${current_ver}'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d'
}

if [[ $# -eq 0 ]];
then
    echo "The following (unused) KERNEL packages will be removed:"
    xpkg_list
    
    read -p 'Do you want to continue [yN]? ' -n 1 -r
    printf "\n"
    
    if [[ $REPLY =~ ^[Yy]$ ]];
    then
        xpkg_list | xargs apt-get -y purge
    else
        echo 'Operation aborted. No changes were made.'
    fi
elif [ "$1" = "headless" ] || [ "$1" = "--headless" ] || [ "$1" = "-y" ] || [ "$1" = "--yes" ];
then
    echo "The following (unused) KERNEL packages will be removed:"
    xpkg_list
    xpkg_list | xargs apt-get -y purge
fi
