#!/bin/bash

# directory driver tl823n
make
make install
echo “blacklist rtl8xxxu” | sudo tee /etc/modprobe.d/rtl8xxxu.conf
echo -e “8192eu\n\nloop” | sudo tee /etc/modules
echo “options 8192eu rtw_power_mgnt=0 rtw_enusbss=0” | sudo tee /etc/modprobe.d/8192eu.conf
grub-mkconfig -o /boot/grub/grub.cfg
mkinitcpio -P

