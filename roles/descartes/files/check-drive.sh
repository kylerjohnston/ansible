#!/usr/bin/env bash

MOUNTPOINT=/var/alexandria

mount | grep $MOUNTPOINT > /dev/null 2>&1
if [ $? != 0 ]; then
    STATUS="DOWN"
else
    STATUS="UP"
fi

echo "${STATUS},$(date +%s)" > /var/www/html/alexandria
