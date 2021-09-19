#!/bin/bash

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
sed -i '393s/.//' /etc/locale.gen
locale-gen
echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
echo "main_machine" >> /etc/hostname
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	main_machine.localdomain main_machine" >> /etc/hosts
echo root:nnsd8r78 | chpasswd
useradd -m lcsub
echo lcsub:lyt56erw | chpasswd
echo "lcsub ALL=(ALL) ALL" >> /etc/sudoers.d/lcsub
mkinitcpio -P linux
sed -i '93s/.//' /etc/pacman.conf
sed -i '94s/.//' /etc/pacman.conf
pacman -Sy
pacman -S --noconfirm efibootmgr grub xf86-video-amdgpu xorg-server os-prober firefox steam networkmanager alacritty gnome-shell gnome-control-center nautilus gdm gnome-tweak-tool pcsx2 snapper

os-prober
echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable fstrim.timer
systemctl enable NetworkManager

mkdir media
mkdir /media/HD_Drive
chmod 700 /media/HD_Drive
chown lcsub:lcsub /media/HD_Drive
cp /etc/fstab /etc/fstab.old
swapon /dev/sda3
echo "UUID=1293dfd5-799a-4d6c-93c4-a2b430615def		/media/HD_Drive		ext4		rw,noatime	0 0" >> /etc/fstab
echo "UUID=3ddb341a-2150-44cd-bf98-adfda1907500		none			swap		defaults	0 0" >> /etc/fstab
mount /media/HD_Drive
cp /media/HD_Drive/scripts/.alacritty.yml /home/lcsub/
