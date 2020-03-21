#!/usr/bin/env bash

MOUNTPOINT=/var/alexandria

if mount | grep $MOUNTPOINT > /dev/null 2>&1
then
    STATUS=1
else
    STATUS=0
fi

sed -Ei "s/descartes_alexandria_mounted [0-9]+/descartes_alexandria_mounted ${STATUS}/g" /var/www/html/metrics
