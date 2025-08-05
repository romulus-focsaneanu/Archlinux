<div align="center">
<img src="./logo2.png" />
 
# Arch Linux installation script
# KDE-Plasma with BTRFS root, separate /home partition formatted as Ext4 and snapper-rollback

</div>

Windows 10 will reach its end of support on October 14, 2025, after which it will no longer receive security updates or technical assistance.
These two scripts are aimed at users coming from Windows who cannot afford to buy a new PC or laptop that meets the minimum requirements of Windows 11, Linux being the last chance for them.
Poverty is a reality of our days that should not be ignored.

### Welcome in the world of Linux!

### Description

The following contains the steps required to configure a fully-functional Arch Linux installation containing a KDE-Plasma desktop environment, all the support packages (network, bluetooth, audio, printers, etc.), along with the applications and utilities that I considered necessary for you to have. These two simple bash scripts, arch.sh and post_install.sh, allow the entire process to be automated.

* Desktop environment KDE-Plasma.
* No AUR helper (paru or yay). No packages from Arch User Repository (AUR) others than snapper-rollback, btrfs-assistant and btrfs-maintenance. I do not recommend installing packages from AUR, only if absolutely necessary, you expose yourself to security risks!
* Installation on UEFI hardware
* Applications and utilities: see pkg_list.txt in the repo
* Estimated installation time: about 15 minutes or so.
* Difficulty level: Easy 

### Requirements:

`git`

### Installation procedure

1. Download official Arch Linux iso from https://archlinux.org/download/, and put on a USB drive with. Rufus (https://rufus.ie/en/), Etcher (https://www.balena.io/etcher/) or Ventoy (https://www.ventoy.net/en/download.html), can do the job.
2. Ensure u are in uefi mode and secure boot is disabled from firmware settings. 
3. Boot into official Arch Linux iso
4. If your keyboard layout is US, you have nothing to do here, can skip to point no. 5, but if it is UK or French, than u need to type in the console:
```sh
loadkeys uk
```
or
```sh
loadkeys fr
```
5. If u have an Ethernet connection, can skip to point no. 6. In case of WiFi, use iwctl utility (bulit-in into official Arch Linux iso) to connect to the internet (https://wiki.archlinux.org/title/Iwd#iwctl):

a) for old models of wifi adapters type in the console:
```sh
iwctl 
```
press enter than type in the console:
```sh
device list
```
press enter than type in the console:
```sh
adapter phy0 set-property Powered on    
```
(The adapter name might be different. Check in the device list if it is phy0 or not).

press enter than type in the console:
```sh
station wlan0 get-networks
```
press enter than type in the console:
```sh
station wlan0 connect SSID    
```
(SSID is the network name, e.g. TP-Link_56D).

press enter than type in the console:

your wifi password    #(e.g. 1234567890).

press enter than type in the console:
```sh
exit
```
b) for newer models of wifi adapters type in the console:
```sh
iwctl --passphrase your wifi password station wlan0 connect SSID    
```
(e.g. iwctl --passphrase 1234567890 station wlan0 connect TP-Link_56D).

press enter than type in the console:
```sh
exit
```
6. Make sure you are connected to internet by typing in the console:
```sh
ping -c 10 google.com
```
than, press Ctrl-c to stop.

6a. Troubles? can't connect to wifi? Check if the WiFi is blocked by typing in the console:
```sh
rfkill list
```
press enter

If it says:

"Soft blocked: yes", then type in the console:
```sh
rfkill unblock wifi
```
press enter

After unblocking the WiFi, you can connect to it. Go through the steps of point no.5 again.

7. synchronize the pacman database, type in the console:
```sh
pacman -Sy
```
press enter

8. Install "git", type in the console:
```sh
pacman -S git
```
press enter 

9. Download my script from github.com, set permissions and run it; type in the console:
```sh
git clone https://github.com/romulus-focsaneanu/Archlinux.git
```
```sh
chmod a+rwx Archlinux/arch.sh
```
```sh
./Archlinux/arch.sh
```
* Note: it will take about 15 minutes or so to install. 

10. Once you are on the desktop environment you need to run the post-install script. Archlinux folder containing the scripts is located in the /home directory. Copy post_install.sh from Archlinux folder into the root of the /home directory and set the permissions for the post-install script. Press Ctrl + Alt + T to open the terminal (konsole) and type:
 ```sh  
cp -r ~/home/Archlinux/post_install.sh ~/home
```
```sh
sudo chmod a+rwx post_install.sh
```
than run the script:
```sh
./post_install.sh
```
* Note: it will takes a few minutes.

* Now u have a fully-functional Arch Linux desktop environment.

### Snapper-rollback (In case something goes wrong...)

* As you might know it is possible to boot a btrfs snapshot of your root filesystem. That allows you to recover your system from an unbootable state after installing a botched update or just...did you manage to do something that causes errors and break the system.
* Snapper-rollback it's a script written in Python, to rollback BTRFS filesystems using the [ArchWiki suggested subvolume layout](https://wiki.archlinux.org/index.php/Snapper#Suggested_filesystem_layout).
* For each pacman transaction a pre and post snapshot will be created. In case something goes wrong you can reboot the system and from GRUB menu using the down arrow key and selecting snapshots list, u can boot a read-only snapshot. Once u are into the desktop, open the terminal (Ctrl + Alt + T) and type:
```sh
sudo snapper list
```
press enter, a list of all availble snapshots for each pacman transaction will be shown. Find the coresponding number of a previous snapshot and type:
```sh
sudo snapper-rollback 10 #(can be any other number)
```
Press enter and confirm by typing:
```sh
CONFIRM
```
Reboot your system. That's all, enjoy!



