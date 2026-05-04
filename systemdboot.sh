#!/bin/bash

rm /boot/efi/loader/loader.conf
touch /boot/efi/loader/loader.conf
echo "default mint" >> /boot/efi/loader/loader.conf
echo "timeout 4" >> /boot/efi/loader/loader.conf
echo "console-mode max" >> /boot/efi/loader/loader.conf
echo "editor no" >> /boot/efi/loader/loader.conf
rm /boot/efi/loader/entries/linux.conf
touch /boot/efi/loader/entries/linux.conf
echo "title	ArchLinux" >> /boot/efi/loader/entries/linux.conf
echo "linux	/vmlinuz-linux" >> /boot/efi/loader/entries/linux.conf
echo "initrd	/amd-ucode.img" >> /boot/efi/loader/entries/linux.conf
echo "initrd	/initramfs-linux.img" >> /boot/efi/loader/entries/linux.conf
echo "options root=/dev/sda3	loglevel=3 rootflags=subvol=@arch rw" >> /boot/efi/loader/entries/arch.conf
bootctl --path=/boot/efi update

