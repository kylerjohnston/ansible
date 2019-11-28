#!/usr/bin/env bash

cryptsetup open /dev/sda1 backup
mount /dev/mapper/backup /var/alexandria
