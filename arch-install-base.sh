#!/bin/bash

#install

# pacman -S networkmanager grub efibootmgr grub-btrfs amd-ucode

# enable

# config
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
sed -i '172s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
echo "archstation" >> /etc/hostname
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	archstation.localdomain archstation" >> /etc/hosts
echo root:nnsd8r78 | chpasswd
useradd -m lcsub
echo lcsub:lyt56erw | chpasswd
echo "lcsub ALL=(ALL) ALL" >> /etc/sudoers.d/lcsub
mkinitcpio -P linux-lts

# install bootloader

# grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub_uefi --recheck
# cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
# grub-mkconfig -o /boot/grub/grub.cfg
