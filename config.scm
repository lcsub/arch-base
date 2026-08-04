;; -*- mode: scheme; -*-
;; This is an operating system configuration template
;; for a "desktop" setup with GNOME and Xfce where the
;; root partition is encrypted with LUKS, and a swap file.

(use-modules (gnu) (gnu system nss) (guix utils)
             (guix packages))
(use-service-modules desktop xorg networking)
(use-package-modules bootloaders wm text-editors fonts version-control terminals xorg)

(operating-system
  (host-name "ThinkCentre")
  (timezone "America/Sao_Paulo")
  (locale "en_US.utf8")

  ;; Choose US English keyboard layout.  The "altgr-intl"
  ;; variant provides dead keys for accented characters.
  (keyboard-layout (keyboard-layout "us" "altgr-intl"))

  ;; Use the UEFI variant of GRUB
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets '("/boot/efi"))))

  ;; File systems declaration
  (file-systems (cons*
                 ;; EFI System Partition
                 (file-system
                   (mount-point "/boot/efi")
                   (device (uuid "7A10-73F2" 'fat))
                   (type "vfat"))

                 ;; Btrfs Root Subvolume
                 (file-system
                   (mount-point "/")
                   (device (uuid "b8172221-7957-4f38-9034-25ed74fec4af" 'btrfs))
                   (type "btrfs")
                   (options "subvol=@guix"))

                 ;; Btrfs Home Subvolume
                 (file-system
                   (mount-point "/home")
                   (device (uuid "b8172221-7957-4f38-9034-25ed74fec4af" 'btrfs))
                   (type "btrfs")
                   (options "subvol=@data"))

                 %base-file-systems))

  ;; Specify a swap file for the system, which resides on the
  ;; root file system.

  ;; System-wide packages and users
  (users (cons (user-account
                 (name "lcsuberti")
                 (comment "lucasu")
                 (group "users")
                 (supplementary-groups '("wheel" "netdev" "audio" "video")))
               %base-user-accounts))

  ;; This is where we specify system-wide packages.
  (packages (append (list i3-wm rofi alacritty xorg-server xinit xwallpaper xrandr vim icecat git wget)
                    %base-packages))

  ;; Add GNOME and Xfce---we can choose at the log-in screen
  ;; by clicking the gear.  Use the "desktop" services, which
  ;; include the X11 log-in service, networking with
  ;; NetworkManager, and more.
  (services (append (list (service xorg-server-service-type)
                          (service dhcpcd-service-type))
                    %base-services)))
