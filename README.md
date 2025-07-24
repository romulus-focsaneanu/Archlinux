Arch Linux installation script

Windows 10 will reach its end of support on October 14, 2025, after which it will no longer receive security updates or technical assistance.
This script is aimed at new users coming from Windows who cannot afford to buy a new PC or laptop that meets the minimum requirements of Windows 11.
Poverty is a reality of our days that should not be ignored.

Welcome in the world of linux!

# Description

This README contains the steps I do to install and configure a fully-functional Arch Linux installation containing a KDE-Plasma desktop environment, all the support packages (network, bluetooth, audio, printers, etc.), along with all my preferred applications and utilities. The shell scripts in this repo allow the entire process to be automated.

* Desktop environment KDE-Plasma.
* Partitions layout designed for a 512 GB NVMe drive. If your nvme drive is smaller or bigger than 512 GB, adjust the size of /home partition as required from arch.sh line 18
* Root partition formatted as BTRFS with subvolumes layout for snapper-rollback
* Home partition formatted as Ext4 (separate /home partition)
* Bootloader: GRUB
* Host name: arch
* Timezone: America/New_York
* No AUR helper (paru or yay). No packages from Arch User Repository (AUR) others than snapper-rollback, btrfs-assistant and btrfs maintence. I do not recommend installing packages from AUR, only if absolutely necessary, you expose yourself to high security risks!!!
* Installation on UEFI hardware
* Nvidia-dkms driver by default. The latest nvidia GPU's Turing (NV160/TUXXX) and newer, needs nvidia-open driver (https://wiki.archlinux.org/title/NVIDIA); You can change nvidia-dkms to nvidia-open in arch.sh line 116.
Don't have an NVIDIA GPU? than comment (#) line 116.
* Default kernel: linux.
* Pkgs list: see pkg_list.txt in the repo
* Username: u
* Password: password (once u reach into desktop environment can change your username and password from system settings; I recommend to do this after post-install script)
* Estimated installation time: about 15 minutes or so.
* Difficulty level: Easy 

# Requirements:

`git`

# Installation procedure

1. Download official Arch Linux iso from https://archlinux.org/download/, and put on a USB drive with. Rufus (https://rufus.ie/en/), Etcher (https://www.balena.io/etcher/) or Ventoy (https://www.ventoy.net/en/download.html), can do the job.
2. Ensure u are in uefi mode and secure boot is disabled from firmware settings. 
3. Boot into official Arch Linux iso
4. If your keyboard layout is US, you have nothing to do here, can skip to point no. 5, but if it is UK or France, than u need to type in the console:

loadkeys uk

or

loadkeys fr

5. If u have an Ethernet connection, can skip to point no. 6. In case of WIFI, use iwctl utility (bulit-in into official Arch Linux iso) to connect to the internet (https://wiki.archlinux.org/title/Iwd#iwctl):

a) for old models of wifi adapters type in the console:

iwctl 

press enter than type in the console:

device list

press enter than type in the console:

adapter phy0 set-property Powered on    # The adapter name might be different. Check the adapter name in the device list if it is phy0 or another.

press enter than type in the console:

station wlan0 get-networks

press enter than type in the console:

station wlan0 connect SSID    # SSID is the network name, e.g. TP-Link_56D

press enter than type in the console:

your wifi password    # e.g. 1234567890

press enter than type in the console:

exit

b) for newer models of wifi adapters type in the console:

iwctl --passphrase your wifi password station wlan0 connect SSID    # e.g. iwctl --passphrase 1234567890 station wlan0 connect TP-Link_56D

press enter than type in the console:

exit

6. Make sure you are connected to internet by typing in the console:

ping -c 10 google.com

than, press Ctrl-c to stop.

6a. Troubles? can't connect to wifi? Check if the WiFi is blocked by typing in the console:

rfkill list

press enter

If it says:

"Soft blocked: yes", then type in the console:

rfkill unblock wifi

press enter

After unblocking the WiFi, you can connect to it. Go through the steps of point no.5 again.

7. synchronize the pacman database, type in the console:

pacman -Sy

press enter

8. Install "git", type in the console:

pacman -S git

press enter

9. Download my script from github.com, set permissions and run it; type in the console:

git clone https://github.com/romulus-focsaneanu/Archlinux.git

chmod a+rwx Archlinux/arch.sh

./Archlinux/arch.sh

* Note: it will take about 15 minutes or so to install. 

10. Once you get into the desktop environment you have to run post-install script. Archlinux folder containing the scripts is located in the /home directory. Copy post_install.sh from the Archlinux folder into the root of the /home directory. Set the permissions for the post-install script:

sudo chmod a+rwx post_install.sh

than run the script:

./post_install.sh

* Note: it will takes a few minutes.

* Enjoy! Now u have a fully-functional Arch Linux desktop environment.



