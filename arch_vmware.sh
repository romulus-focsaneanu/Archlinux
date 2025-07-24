#!/bin/bash

# Update system clock
timedatectl set-ntp true

# Refreshing mirrorlist
pacman -Sy

# Initialize the pacman keyring
pacman-key --init

# Creating the partitions
echo "Creating the partitions..."
sgdisk --zap-all /dev/sda
sgdisk -og /dev/sda
sgdisk -n 1:0:+300M -c 1:"EFI" -t 1:ef00 /dev/sda
sgdisk -n 2:0:+85GB -c 2:"BTRFSROOT" -t 2:8300 /dev/sda
sgdisk -n 3:0:+55GB -c 3:"HOME" -t 3:8300 /dev/sda
sgdisk -n 4:0:"$ENDSECTOR" -c 4:"SWAP" -t 4:8200 /dev/sda

# Set up partition variables
echo "Set up partition variables..."
partition1=/dev/sda1
partition2=/dev/sda2
partition3=/dev/sda3
partition4=/dev/sda4

# Format the partitions
echo "Formatting the partitions..."
mkfs.fat -F32 /dev/sda1
mkfs.btrfs -f /dev/sda2
mkfs.ext4 -F /dev/sda3
mkswap /dev/sda4
swapon /dev/sda4

# Mount the BTRFS partition and create subvolumes
echo "Setting up BTRFS..."
mount /dev/sda2 /mnt
cd /mnt
btrfs su cr @
btrfs su cr @snapshots
btrfs su cr @log
btrfs su cr @cache
btrfs su cr @tmp
btrfs su cr @srv
cd
umount /mnt

# Remount the BTRFS subvolumes
mount -o noatime,ssd,compress=zstd,space_cache=v2,discard=async,subvol=@ /dev/sda2 /mnt
mkdir /mnt/efi
mkdir /mnt/home
mkdir /mnt/.snapshots
mkdir /mnt/srv
mkdir -p /mnt/var/log
mkdir -p /mnt/var/cache
mkdir -p /mnt/var/tmp
mkdir /mnt/.btrfsroot
mount /dev/sda1 /mnt/efi
mount /dev/sda3 /mnt/home
mount -o noatime,ssd,compress=zstd,space_cache=v2,discard=async,subvol=@snapshots /dev/sda2 /mnt/.snapshots
mount -o noatime,ssd,compress=zstd,space_cache=v2,discard=async,subvol=@log /dev/sda2 /mnt/var/log
mount -o noatime,ssd,compress=zstd,space_cache=v2,discard=async,subvol=@cache /dev/sda2 /mnt/var/cache
mount -o noatime,ssd,compress=zstd,space_cache=v2,discard=async,subvol=@tmp /dev/sda2 /mnt/var/tmp
mount -o noatime,ssd,compress=zstd,space_cache=v2,discard=async,subvol=@srv /dev/sda2 /mnt/srv
mount -o noatime,ssd,compress=zstd,space_cache=v2,discard=async,subvolid=5 /dev/sda2 /mnt/.btrfsroot

# Install essential packages
echo "Installing essential packages..."
pacstrap -K /mnt base base-devel linux linux-firmware linux-headers efibootmgr nano intel-ucode amd-ucode openssh git dhcpcd wget reflector rsync networkmanager network-manager-applet pacman-contrib flatpak terminus-font dialog firefox btrfs-progs grub

# Generate fstab 
echo "Generate fstab..."
genfstab -U /mnt >> /mnt/etc/fstab

# Chroot into the new system
arch-chroot /mnt /bin/bash <<EOF

# Set timezine
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc

# Localization
sed -i '171s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=us" >> /etc/vconsole.conf

# Network configuration
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts

# Set root password
echo root:password | chpasswd

# Create user
useradd -mG wheel u
echo u:password | chpasswd
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Edit pacman parameters
sed -i 's/^#Color/Color/' /etc/pacman.conf
sed -i '38d' /etc/pacman.conf
sed -i '38 i ParallelDownloads = 10' /etc/pacman.conf
sed -i '92s/.//' /etc/pacman.conf
sed -i '93s/.//' /etc/pacman.conf
sed -i '34 i ILoveCandy' /etc/pacman.conf

# Refresh pacman
pacman -Syy

# Installing audio drivers
yes | pacman -S alsa-utils alsa-firmware pipewire pipewire-alsa pipewire-pulse pipewire-jack pipewire-audio pipewire-zeroconf wireplumber sof-firmware pavucontrol libpipewire lib32-libpipewire lib32-pipewire ffnvcodec-headers pipewire-x11-bell pipewire-v4l2

# Installing common pkgs
pacman -S --needed --noconfirm xorg xorg-server xorg-xinit xorg-apps xorg-twm xorg-xclock xf86-input-libinput xf86-input-evdev  xorg-xkill xdg-user-dirs xdg-user-dirs-gtk gstreamer gvfs gvfs-mtp gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-nfs gvfs-smb smartmontools arch-install-scripts libwnck3 b43-fwcutter busybox cpio mobile-broadband-provider-info modem-manager-gui net-snmp networkmanager-openconnect networkmanager-openvpn networkmanager-pptp networkmanager-vpnc dnsutils modemmanager netctl net-tools ntfs-3g sg3_utils nss-mdns usb_modeswitch whois wireless_tools dhclient dnsmasq ethtool openconnect openvpn rp-pppoe wireless-regdb wpa_supplicant wvdial iwd iw linux-atm ndisc6 ppp pptpclient vpnc xl2tpd upower hwinfo python solid mlocate glances htop screenfetch ffmpeg fsarchiver ark bluez bluez-utils bluez-tools archiso ffmpegthumbnailer poppler-glib libgsf libopenraw freetype2 gst-libav gsound gst-plugins-base gst-plugins-base-libs gst-plugins-good gst-plugins-ugly gst-plugins-bad gst-plugins-bad-libs sdparm libdvdcss systemd-ui dosfstools mtools os-prober bash-completion bc partimage json-glib libsoup dbus-glib polkit efitools cdrkit crda ddrescue exfat-utils gpart gparted android-tools android-udev mtpfs nfs-utils vte3 gtk3 libnotify desktop-file-utils appstream-glib archlinux-appstream-data gettext itstool vala meson ninja gobject-introspection squashfs-tools crypto++ ecryptfs-utils fuse3 pv unrar unzip asciidoc libhandy lxsession yaml-cpp appstream-qt5 bluez-qt5 inxi mkinitcpio-archiso plasma-framework5 qt5-tools qt5-webengine syslinux cmake clonezilla cups cups-filters cups-pdf ghostscript gsfonts foomatic-db-engine foomatic-db foomatic-db-ppds foomatic-db-nonfree foomatic-db-nonfree-ppds gutenprint foomatic-db-gutenprint-ppds system-config-printer hplip splix xf86-input-vmmouse expac lynis rkhunter bluez-obex gvim neovim fuseiso arch-audit links elinks zsh apparmor python-notify2 inotify-tools acpi acpi_call-dkms acpid 7zip adwaita-cursors adwaita-icon-theme adwaita-icon-theme-legacy accountsservice archlinux-contrib archlinux-keyring archlinux-wallpaper avahi curl cronie darkhttpd ddrescue duf fastfetch ffmpegthumbs font-manager fontconfig fwupd fwupd-efi gedit haveged hicolor-icon-theme hwdata iotop isoimagewriter jdk-openjdk lm_sensors man-db man-pages mdadm nethogs pacutils papirus-icon-theme plymouth power-profiles-daemon tar ufw ufw-extras gufw unrar unzip veracrypt which zip meld jq openbsd-netcat gstreamer-vaapi blueman discord gimp gimp-plugin-gmic fuse2fs thunderbird btop plymouth-kcm ncdu audacious audacious-plugins bleachbit conky inkscape qbittorrent shortwave shotwell libreoffice-fresh vlc vlc-plugins-all

# Installing fonts pkgs
pacman -S --needed --noconfirm ttf-dejavu gnu-free-fonts ttf-liberation ttf-bitstream-vera ttf-ubuntu-font-family ttf-caladea ttf-carlito ttf-croscore cantarell-fonts noto-fonts ttf-anonymous-pro ttf-cascadia-code ttf-droid ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-font-awesome ttf-hack ttf-inconsolata ttf-opensans ttf-roboto ttf-roboto-mono adobe-source-code-pro-fonts inter-font noto-fonts-emoji

# Installing video drivers
# Intel drivers
pacman -S --needed --noconfirm libvdpau-va-gl libva-intel-driver vulkan-intel intel-gmmlib intel-media-driver libva-utils vulkan-headers vulkan-icd-loader vulkan-tools mesa mesa-utils mesa-demos lib32-mesa

# Nvidia drivers
pacman -S --needed --noconfirm nvidia-dkms nvidia-utils nvidia-settings nvidia-prime lib32-nvidia-utils lib32-opencl-nvidia nvtop

# Installing kde-plasma
pacman -S --needed --noconfirm kf6 qt6 plasma-meta kde-applications-meta packagekit-qt5 packagekit-qt6 kde-cli-tools kdeplasma-addons plasma-activities polkit-kde-agent flatpak-kcm bluedevil glib2 ibus kaccounts-integration kscreen libaccounts-qt plasma-nm plasma-pa scim extra-cmake-modules kaccounts-integration kdoctools libibus wayland-protocols plasma-applet-window-buttons plasma-workspace appmenu-gtk-module kwayland-integration plasma5-integration xdg-desktop-portal-gtk kde-pim-meta kde-system-meta kde-gtk-config kwin-x11 plasma-x11-session gnome-disk-utility

# Installing snapper 
pacman -S --needed --noconfirm grub-btrfs snap-pac snapper

# Add flatpak repo
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install grub 
grub-install --target=x86_64-efi --efi-directory=/efi --boot-directory=/boot --bootloader-id=GRUB /dev/sda2

# Edit grub parameters
sed -i '4d' /etc/default/grub
sed -i '4 i GRUB_TIMEOUT="2"' /etc/default/grub
sed -i '6d' /etc/default/grub
sed -i '6 i GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet splash lsm=landlock,lockdown,yama,integrity,apparmor,bpf audit=1"' /etc/default/grub
sed -i '42d' /etc/default/grub
sed -i '42 i export GRUB_COLOR_NORMAL="white/black"' /etc/default/grub
sed -i '43d' /etc/default/grub
sed -i '43 i export GRUB_COLOR_HIGHLIGHT="light-red/black"' /etc/default/grub
sed -i '46d' /etc/default/grub
sed -i '46 i GRUB_BACKGROUND="/etc/default/splash.png"' /etc/default/grub

# Enable necessary services
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable dhcpcd.service
systemctl enable acpid
systemctl enable ufw
systemctl enable avahi-daemon
systemctl enable haveged.service
systemctl enable paccache.timer
systemctl enable sddm.service

# Add nvidia to mkinitcpio modules 
#sed -i 's/^MODULES=()/MODULES=(btrfs i915 nvidia)/g' /etc/mkinitcpio.conf

# Edit system parameters
sed -i '50s/^#DefaultTimeoutStopSec=90s/DefaultTimeoutStopSec=5s/' /etc/systemd/system.conf

# Refreshing grub
grub-mkconfig -o /boot/grub/grub.cfg

# Generating intramfs
mkinitcpio -P

EOF

# Copy arch into working directory after reboot
cp -r arch /mnt/home/u

# Setting boot wallpaper in directory
cp -r arch/splash.png /mnt/etc/default

# Unmount all partitions and reboot
umount -R /mnt
reboot
