#!/bin/bash

# Set keyboard layout to UK
#sudo localectl --no-convert set-x11-keymap gb pc104

# adjusting pacman configuration
sudo sed -i '38d' /etc/pacman.conf

# Create config root 
sudo umount /.snapshots
sudo rm -rf /.snapshots
sudo snapper -c root create-config /
sudo btrfs subvolume delete /.snapshots
sudo mkdir /.snapshots
sudo mount -a

# Setting default btrfs subvol  
sudo btrfs subvol set-default 256 /

# Enable numlock on log in
echo -e "[General]
Numlock=on" > /home/$username/sddm.conf
sudo cp /home/$username/sddm.conf /etc
rm /home/$username/sddm.conf


# Download and install snapper-rollback
curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/snapper-rollback.tar.gz
tar -xf snapper-rollback.tar.gz
rm snapper-rollback.tar.gz
cd snapper-rollback/
makepkg -sic

# Download and install btrfs-assistant
curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/btrfs-assistant.tar.gz
tar -xf btrfs-assistant.tar.gz
rm btrfs-assistant.tar.gz
cd btrfs-assistant/
makepkg -sic

# Download and install btrfs-maintenance
curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/btrfsmaintenance.tar.gz
tar -xf btrfsmaintenance.tar.gz
rm btrfsmaintenance.tar.gz
cd btrfsmaintenance/
makepkg -sic

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
}' > /home/$username/romulus
sudo cp /home/$username/romulus /etc/initcpio/hooks
rm /home/$username/romulus


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
}' > /home/$username/romulus
sudo cp /home/$username/romulus /etc/initcpio/install
rm /home/$username/romulus


# Setting permissions for snapshots directory
sudo chmod a+rx /.snapshots
sudo chown :$username /.snapshots

# Edit mkinitcpio config.
sudo sed -i '55d' /etc/mkinitcpio.conf
sudo sed -i '55 i HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block filesystems fsck romulus)' /etc/mkinitcpio.conf

# Resume setting apparmor
sudo groupadd -r audit
sudo gpasswd -a $username audit
sudo sed -i '5 i log_group = audit' /etc/audit/auditd.conf
mkdir -p ~/.config/autostart
echo -e "[Desktop Entry]
Type=Application
Name=AppArmor Notify
Comment=Receive on screen notifications of AppArmor denials
TryExec=aa-notify
Exec=aa-notify -p -s 1 -w 60 -f /var/log/audit/audit.log
StartupNotify=false
NoDisplay=true" > /home/$username/.config/autostart/apparmor-notify.desktop

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




