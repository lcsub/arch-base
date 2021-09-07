#!/bin/bash

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
sed -i '393s/.//' /etc/locale.gen
locale-gen
echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	arch.localdomain arch" >> /etc/hosts
echo root:nnsd8r78 | chpasswd
useradd -m lcsub
echo lcsub:lyt56erw | chpasswd
echo "lcsub ALL=(ALL) ALL" >> /etc/sudoers.d/lcsub
mkinitcpio -P linux
sed -i '93s/.//' /etc/pacman.conf
sed -i '94s/.//' /etc/pacman.conf
pacman -Sy
pacman -S --noconfirm efibootmgr grub xf86-video-amdgpu xorg-server lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings firefox steam dhcpcd alacritty xfce4

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable fstrim.timer
systemctl enable dhcpcd@enp4s0.service

rm -r /home
cp /etc/fstab /etc/fstab.old
echo "UUID=1293dfd5-799a-4d6c-93c4-a2b430615def		/home		ext4		rw,noatime	0 0" >> /etc/fstab
