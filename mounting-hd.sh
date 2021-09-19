#!/bin/bash

## /
mkdir media
mkdir /media/HD_Drive
chmod 700 /media/HD_Drive
chown lcsub:lcsub /media/HD_Drive
cp /etc/fstab /etc/fstab.old
swapon /dev/sda3
echo "UUID=1293dfd5-799a-4d6c-93c4-a2b430615def         /media/HD_Drive         ext4            rw,noatime      0 0" >> /etc/fstab
echo "UUID=3ddb341a-2150-44cd-bf98-adfda1907500         none                    swap            defaults        0 0" >> /etc/fstab
mount /media/HD_Drive

