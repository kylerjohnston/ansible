#!/usr/bin/env bash

MOUNTPOINT=/var/alexandria

mount | grep $MOUNTPOINT > /dev/null 2>&1
if [ $? != 0 ]; then
    STATUS=0
else
    STATUS=1
fi

echo "descartes_alexandria_mounted ${STATUS}" > /var/www/html/metrics
