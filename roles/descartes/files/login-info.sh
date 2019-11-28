#!/usr/bin/env bash

MOUNTPOINT=/var/alexandria
SCRIPTPATH=/root/scripts/mount-drive.sh

cat /etc/motd

mount | grep $MOUNTPOINT > /dev/null 2>&1
if [ $? != 0 ]; then
    echo -e "\e[31m\e[1mWARNING:\e[0m \e[31m$MOUNTPOINT is not mounted! \e[39m"
    echo -e "\e[33m\e[1msudo ${SCRIPTPATH}\e[0m"
else
    df -h /var/alexandria
fi
