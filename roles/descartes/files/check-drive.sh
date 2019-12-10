#!/usr/bin/env bash

MOUNTPOINT=/var/alexandria

mount | grep $MOUNTPOINT > /dev/null 2>&1
if [ $? != 0 ]; then
    STATUS=1
else
    STATUS=0
fi

echo "descartes_alexandria_mounted ${STATUS}" > /var/www/html/metrics
