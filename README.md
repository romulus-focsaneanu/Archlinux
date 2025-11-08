<div align="center">
<img src="./logo2.png" />
 
# Arch Linux installation script
# KDE-Plasma, BTRFS, Snapper

</div>

### Description

The following contains the steps required to configure a fully-functional Arch Linux installation containing a KDE-Plasma desktop environment, all the support packages (network, bluetooth, audio, printers, etc.), along with the applications and utilities that I considered necessary for you to have. This simple bash script allow the entire process to be automated.

* Desktop environment KDE-Plasma.
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

### Snapper and Btrfs-Assistant (In case something goes wrong...)

* As you might know it is possible to boot a btrfs snapshot of your root filesystem. That allows you to recover your system from an unbootable state after installing a botched update or just...did you manage to do something that causes errors and break the system.
* You can roll-back the system to last working state with btrfs-assistant while booted into the snapshot




