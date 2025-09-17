#!/bin/bash

# Ask user if wants to disable the linux fallback image
read -p "Do you want to disable the linux fallback image? (y/n): " fallback_choice

# adjusting pacman configuration
sudo sed -i '38d' /etc/pacman.conf

# Setting GRUB_TOP_LEVEL in grub cfg file for linux kernel
## Get the kernel list
kernels=$(pacman -Q | grep -E 'linux|linux-zen|linux-lts' | wc -l)

# Check if there is more than one kernel installed.
if [ "$kernels" -gt 1 ] && [ -d /boot/grub ]; then
    echo "There are $kernels kernels installed."

    # Check if linux kernel is installed.
    if pacman -Q | grep -q 'linux'; then
        kernel_choice="linux"
    fi

    kernel_path="/boot/vmlinuz-linux"

    if [ -f "$kernel_path" ]; then
        echo "Setting GRUB_TOP_LEVEL in /etc/default/grub"
        sudo sed -i '3d' /etc/default/grub
        sudo sed -i '3i GRUB_DEFAULT="0"' /etc/default/grub
        sudo sed -i '2i GRUB_TOP_LEVEL="/boot/vmlinuz-linux"' /etc/default/grub
    else
        echo "Kernel path does not exist."
    fi
else
    echo "There is only one kernel installed or no grub installed as bootloader."
fi

# Setting GRUB_TOP_LEVEL in grub cfg file for linux-zen kernel
## Get the kernel list
kernels=$(pacman -Q | grep -E 'linux|linux-zen|linux-lts' | wc -l)

# Check if there is more than one kernel installed.
if [ "$kernels" -gt 1 ] && [ -d /boot/grub ]; then
    echo "There are $kernels kernels installed."

    # Check if linux kernel is installed.
    if pacman -Q | grep -q 'linux-zen'; then
        kernel_choice="linux-zen"
    fi

    kernel_path="/boot/vmlinuz-linux-zen"

    if [ -f "$kernel_path" ]; then
        echo "Setting GRUB_TOP_LEVEL in /etc/default/grub"
        sudo sed -i '3d' /etc/default/grub
        sudo sed -i '3i GRUB_DEFAULT="0"' /etc/default/grub
        sudo sed -i '2i GRUB_TOP_LEVEL="/boot/vmlinuz-linux-zen"' /etc/default/grub
    else
        echo "Kernel path does not exist."
    fi
else
    echo "There is only one kernel installed or no grub installed as bootloader."
fi

# Enable numlock on log in
echo -e "[General]
Numlock=on" > /home/$USER/sddm.conf
sudo cp /home/$USER/sddm.conf /etc
rm /home/$USER/sddm.conf


# Download and install snapper-rollback
curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/snapper-rollback.tar.gz
tar -xf snapper-rollback.tar.gz
rm snapper-rollback.tar.gz
cd snapper-rollback/
makepkg -sic --noconfirm

# Download and install btrfs-assistant
curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/btrfs-assistant.tar.gz
tar -xf btrfs-assistant.tar.gz
rm btrfs-assistant.tar.gz
cd btrfs-assistant/
makepkg -sic --noconfirm

# Download and install btrfs-maintenance
curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/btrfsmaintenance.tar.gz
tar -xf btrfsmaintenance.tar.gz
rm btrfsmaintenance.tar.gz
cd btrfsmaintenance/
makepkg -sic --noconfirm

# Disable fallback image from mkinitcpio
if [[ "$fallback_choice" == "y" && -d /boot/grub ]]; then
    if [[ -f /etc/mkinitcpio.d/linux.preset ]]; then
        echo "linux.preset exists in /etc/mkinitcpio.d directory."
        sudo sed -i '6d' /etc/mkinitcpio.d/linux.preset
        sudo sed -i '6 i PRESETS=('default')' /etc/mkinitcpio.d/linux.preset
    else
        echo "linux.preset not found in /etc/mkinitcpio.d directory."
    fi

    if [[ -f /etc/mkinitcpio.d/linux-lts.preset ]]; then
        echo "linux-lts.preset exists in /etc/mkinitcpio.d directory."
        sudo sed -i '6d' /etc/mkinitcpio.d/linux-lts.preset
        sudo sed -i '6 i PRESETS=('default')' /etc/mkinitcpio.d/linux-lts.preset
    else
        echo "linux-lts.preset not found in /etc/mkinitcpio.d directory." 
    fi

    if [[ -f /etc/mkinitcpio.d/linux-zen.preset ]]; then
        echo "linux-zen.preset exists in /etc/mkinitcpio.d directory."
        sudo sed -i '6d' /etc/mkinitcpio.d/linux-zen.preset
        sudo sed -i '6 i PRESETS=('default')' /etc/mkinitcpio.d/linux-zen.preset
    else
        echo "linux-zen.preset not found in /etc/mkinitcpio.d directory."    
    fi

    if [[ -f /boot/initramfs-linux-fallback.img ]]; then
        echo "initramfs-linux-fallback.img exists in /boot directory."
        sudo rm -r /boot/initramfs-linux-fallback.img
    else
        echo "initramfs-linux-fallback.img not found in /boot directory."
    fi

    if [[ -f /boot/initramfs-linux-lts-fallback.img ]]; then
        echo "initramfs-linux-lts-fallback.img exists in /boot directory."
        sudo rm -r /boot/initramfs-linux-lts-fallback.img
    else
        echo "initramfs-linux-lts-fallback.img not found in /boot directory."
    fi

    if [[ -f /boot/initramfs-linux-zen-fallback.img ]]; then
        echo "initramfs-linux-zen-fallback.img exists in /boot directory."
        sudo rm -r /boot/initramfs-linux-zen-fallback.img
    else
        echo "initramfs-linux-zen-fallback.img not found in /boot directory."
    fi
else
    echo "grub is not installed"
fi    

if [[ "$fallback_choice" == "y" && -d /boot/loader ]]; then
    if [[ -f /etc/mkinitcpio.d/linux.preset ]]; then
        echo "linux.preset exists in /etc/mkinitcpio.d directory."
        sudo sed -i '6d' /etc/mkinitcpio.d/linux.preset
        sudo sed -i '6 i PRESETS=('default')' /etc/mkinitcpio.d/linux.preset
    else
        echo "linux.preset not found in /etc/mkinitcpio.d directory."
    fi

    if [[ -f /etc/mkinitcpio.d/linux-lts.preset ]]; then
        echo "linux-lts.preset exists in /etc/mkinitcpio.d directory."
        sudo sed -i '6d' /etc/mkinitcpio.d/linux-lts.preset
        sudo sed -i '6 i PRESETS=('default')' /etc/mkinitcpio.d/linux-lts.preset
    else
        echo "linux-lts.preset not found in /etc/mkinitcpio.d directory." 
    fi

    if [[ -f /etc/mkinitcpio.d/linux-zen.preset ]]; then
        echo "linux-zen.preset exists in /etc/mkinitcpio.d directory."
        sudo sed -i '6d' /etc/mkinitcpio.d/linux-zen.preset
        sudo sed -i '6 i PRESETS=('default')' /etc/mkinitcpio.d/linux-zen.preset
    else
        echo "linux-zen.preset not found in /etc/mkinitcpio.d directory."    
    fi

    if [[ -f /boot/initramfs-linux-fallback.img ]]; then
        echo "initramfs-linux-fallback.img exists in /boot directory."
        sudo rm -r /boot/initramfs-linux-fallback.img
    else
        echo "initramfs-linux-fallback.img not found in /boot directory."
    fi

    if [[ -f /boot/initramfs-linux-lts-fallback.img ]]; then
        echo "initramfs-linux-lts-fallback.img exists in /boot directory."
        sudo rm -r /boot/initramfs-linux-lts-fallback.img
    else
        echo "initramfs-linux-lts-fallback.img not found in /boot directory."
    fi

    if [[ -f /boot/initramfs-linux-zen-fallback.img ]]; then
        echo "initramfs-linux-zen-fallback.img exists in /boot directory."
        sudo rm -r /boot/initramfs-linux-zen-fallback.img
    else
        echo "initramfs-linux-zen-fallback.img not found in /boot directory."
    fi

    if [[ -f /boot/loader/entries/arch-fallback.conf ]]; then
        echo "arch-fallback.conf exists in /boot/loader directory."
        sudo rm -r /boot/loader/entries/arch-fallback.conf
    else
        echo "arch-fallback.conf not found in /boot/loader directory."
    fi

    if [[ -f /boot/loader/entries/arch2-fallback.conf ]]; then
        echo "arch2-fallback.conf exists in /boot/loader directory."
        sudo rm -r /boot/loader/entries/arch2-fallback.conf
    else
        echo "arch2-fallback.conf not found in /boot/loader directory."
    fi
else
    echo "systemd-boot is not installed"
fi

# Setting snapper config
sudo sed -i '22d' /etc/snapper/configs/root
sudo sed -i '22 i ALLOW_GROUPS-"wheel"' /etc/snapper/configs/root
sudo sed -i '38d' /etc/snapper/configs/root
sudo sed -i '38 i NUMBER_MIN_AGE="1800"' /etc/snapper/configs/root
sudo sed -i '44d' /etc/snapper/configs/root
sudo sed -i '44 i TIMELINE_CREATE="no"' /etc/snapper/configs/root
sudo sed -i '50d' /etc/snapper/configs/root
sudo sed -i '50 i TIMELINE_MIN_AGE="1800"' /etc/snapper/configs/root
sudo sed -i '51d' /etc/snapper/configs/root
sudo sed -i '51 i TIMELINE_LIMIT_HOURLY="5"' /etc/snapper/configs/root
sudo sed -i '52d' /etc/snapper/configs/root
sudo sed -i '52 i TIMELINE_LIMIT_DAILY="7"' /etc/snapper/configs/root
sudo sed -i '53d' /etc/snapper/configs/root
sudo sed -i '53 i TIMELINE_LIMIT_WEEKLY="0"' /etc/snapper/configs/root
sudo sed -i '54d' /etc/snapper/configs/root
sudo sed -i '54 i TIMELINE_LIMIT_MONTHLY="0"' /etc/snapper/configs/root
sudo sed -i '55d' /etc/snapper/configs/root
sudo sed -i '55 i TIMELINE_LIMIT_QUARTERLY="0"' /etc/snapper/configs/root
sudo sed -i '56d' /etc/snapper/configs/root
sudo sed -i '56 i TIMELINE_LIMIT_YEARLY="0"' /etc/snapper/configs/root
sudo sed -i '63d' /etc/snapper/configs/root
sudo sed -i '63 i EMPTY_PRE_POST_MIN_AGE="1800"' /etc/snapper/configs/root

# Edit snapper-rollback.conf 
sudo sed -i '25d' /etc/snapper-rollback.conf
sudo sed -i '25 i mountpoint = /.btrfsroot' /etc/snapper-rollback.conf

# Creating snapper hooks
echo -e '#!/usr/bin/bash

run_hook() {
	local current_dev=$(resolve_device "$root"); # resolve devices for blkid
	if [[ $(blkid ${current_dev} -s TYPE -o value) = "btrfs" ]]; then
		current_snap=$(mktemp -d); # create a random mountpoint in root of initrafms
		mount -t btrfs -o ro,"${rootflags}" "$current_dev" "${current_snap}";
		if [[ $(btrfs property get "${current_snap}" ro) != "ro=false" ]]; then # check if the snapshot is in read-only mode
			snaproot=$(mktemp -d);
			mount -t btrfs -o rw,subvolid=5 "${current_dev}" "${snaproot}";
			rwdir=$(mktemp -d)
			mkdir -p ${snaproot}${rwdir} # create a random folder in root fs of btrfs device
			btrfs sub snap "${current_snap}" "${snaproot}${rwdir}/rw";
			umount "${current_snap}";
			umount "${snaproot}"
			rmdir "${current_snap}";
			rmdir "${snaproot}";
			rootflags=",subvol=${rwdir}/rw";
		else
			umount "${current_snap}";
			rmdir "${current_snap}";
		fi
	fi
}' > /home/$USER/romulus
sudo cp /home/$USER/romulus /etc/initcpio/hooks
rm /home/$USER/romulus


echo -e '#!/bin/bash

build() {
    add_module btrfs
    add_binary btrfs
    add_binary btrfsck
    add_binary blkid
    add_runscript
}

help() {
    cat <<HELPEOF
This hook creates a copy of the snapshot in read only mode before boot.
HELPEOF
}' > /home/$USER/romulus
sudo cp /home/$USER/romulus /etc/initcpio/install
rm /home/$USER/romulus


# Edit mkinitcpio config.
sudo sed -i '55d' /etc/mkinitcpio.conf
sudo sed -i '55 i HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block filesystems fsck romulus)' /etc/mkinitcpio.conf

# Resume setting apparmor
sudo groupadd -r audit
sudo gpasswd -a $USER audit
sudo sed -i '5 i log_group = audit' /etc/audit/auditd.conf
mkdir -p /home/$USER/.config/autostart
echo -e "[Desktop Entry]
Type=Application
Name=AppArmor Notify
Comment=Receive on screen notifications of AppArmor denials
TryExec=aa-notify
Exec=aa-notify -p -s 1 -w 60 -f /var/log/audit/audit.log
StartupNotify=false
NoDisplay=true" > /home/$USER/.config/autostart/apparmor-notify.desktop

# Enable necessary services
sudo systemctl enable --now grub-btrfsd
sudo systemctl enable --now snapper-timeline.timer
sudo systemctl enable --now snapper-cleanup.timer
sudo systemctl enable --now btrfs-scrub@-.timer
sudo systemctl enable apparmor.service
sudo systemctl enable auditd.service

# Refreshing grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Generating intramfs
sudo mkinitcpio -P

EOF


reboot




