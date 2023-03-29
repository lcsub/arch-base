#!/bin/bash

# config
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
echo "workstation" >> /etc/hostname
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	workstation.localdomain workstation" >> /etc/hosts
echo root:nnsd8r78 | chpasswd
useradd -m lcsub
echo lcsub:lyt56erw | chpasswd
echo "lcsub ALL=(ALL) ALL" >> /etc/sudoers.d/lcsub
pacman -Sy
pacman -S --noconfirm efibootmgr grub xorg-server networkmanager thermald

# xinit config
# cp /etc/X11/xinit/xinitrc /home/lcsub/.xinitrc

# bootloader
# os-prober
echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
grub-mkconfig -o /boot/grub/grub.cfg

# service
systemctl enable fstrim.timer
systemctl enable NetworkManager
systemctl enable thermald
