#!/bin/bash

# --- Welcome Message ---
echo "
+----------------------------------------------+
| Arch Linux Installation Script by Romulus F. |
+----------------------------------------------+
"
# Cleaning the TTY
clear

# Update system clock
timedatectl set-ntp true

# Refreshing mirrorlist
pacman -Sy

# Initialize the pacman keyring
pacman-key --init

# Populate the local keyring
pacman-key --populate archlinux

# Edit pacman parameters
sed -i 's/^#Color/Color/' /etc/pacman.conf
sed -i '38d' /etc/pacman.conf
sed -i '38 i ParallelDownloads = 10' /etc/pacman.conf
sed -i '92s/.//' /etc/pacman.conf
sed -i '93s/.//' /etc/pacman.conf
sed -i '34 i ILoveCandy' /etc/pacman.conf

# Refreshing mirrorlist
pacman -Sy

# Cleaning the TTY
clear

# Prompt for a username
get_username() {
    read -p "Enter your username: " username
}

# Prompt for user password
get_user_password() {
    while true; do
        read -s -p "Enter your password: " user_password
        echo
        read -s -p "Confirm your password: " confirm_password
        echo
        
        if [ "$user_password" == "$confirm_password" ]; then
            break
        else
            echo "Passwords do not match. Please try again."
        fi
    done
}

# Prompt for root password
get_root_password() {
    while true; do
        read -s -p "Enter a password for the root account: " root_password
        echo
        read -s -p "Confirm the root password: " confirm_root_password
        echo
        
        if [ "$root_password" == "$confirm_root_password" ]; then
            break
        else
            echo "Root passwords do not match. Please try again."
        fi
    done
}

# Main execution
get_username
get_user_password

read -p "Do you want the same password for the root account? (y/n): " same_as_root

if [[ "$same_as_root" == "y" ]]; then
    root_password=$user_password
    echo "The root password has been set to the same as your user password."
else
    get_root_password
fi

# Cleaning the TTY
clear

# Prompt for language
function get_locale() {
    local language=$1
    # Construct the locale string based on the input language
    case "$language" in
        "1") echo "en_US.UTF-8" ;;  # English (US)
        "2") echo "en_GB.UTF-8" ;;  # English (UK)
        "3") echo "ro_RO.UTF-8" ;;  # Romanian
        "4") echo "fr_FR.UTF-8" ;;  # French
        "5") echo "es_ES.UTF-8" ;;  # Spanish
        "6") echo "de_DE.UTF-8" ;;  # German
        "7") echo "it_IT.UTF-8" ;;  # Italian
        "8") echo "pl_PL.UTF-8" ;;  # Polish
        "9") echo "nl_NL.UTF-8" ;;  # Dutch
        "10") echo "hu_HU.UTF-8" ;;  # Hungarian
        "11") echo "cs_CZ.UTF-8" ;;  # Czech
        "12") echo "sk_SK.UTF-8" ;;  # Slovak
        "13") echo "pt_PT.UTF-8" ;;  # Portuguese
        "14") echo "sv_SE.UTF-8" ;;  # Swedish
        "15") echo "fi_FI.UTF-8" ;;  # Finnish
        "16") echo "da_DK.UTF-8" ;;  # Danish
        *) echo "" ;;  # Default case for unsupported languages
    esac
}

# Display language options
echo "Please select your preferred language:"
echo "1. English (US)"
echo "2. English (UK)"
echo "3. Romanian"
echo "4. French"
echo "5. Spanish"
echo "6. German"
echo "7. Italian"
echo "8. Polish"
echo "9. Dutch"
echo "10. Hungarian"
echo "11. Czech"
echo "12. Slovak"
echo "13. Portuguese"
echo "14. Swedish"
echo "15. Finnish"
echo "16. Danish"
echo ""

# Reading user choice
read -r user_choice

# Get the corresponding locale from the choice
user_locale=$(get_locale "$user_choice")

if [[ -z $user_locale ]]; then
    echo "Error: Unsupported language choice. Please run the script again."
    exit 1
fi

# Print the selected locale
echo "You have selected: $user_locale"

# Cleaning the TTY
clear

# Prompt for keyboard layout
echo "Please enter your preferred keyboard layout (e.g. us by ca cf cz de dk es et fa fi fr gr hu il it lt lv mk nl no pl ro ru sg ua uk):"
read KEYBOARD

# Cleaning the TTY
clear

#Timezone
# Function to get timezones based on country
function get_timezones() {
    local country=$1
    echo "Searching for timezones in '$country'..."
    # List all timezones matching the country name (case insensitive)
    timedatectl list-timezones | grep -i "$country"
}

# Display country options
echo "Please select your country from the list below:"
echo "1. United States"
echo "2. UK"
echo "3. France"
echo "4. Romania"
echo "5. Germany"
echo "6. Canada"
echo "7. All European Countries"  # Option for all Europe
read -r user_country_choice

# Determine the corresponding country name
case $user_country_choice in
    "1") user_country="America" ;;  # Use America to match timezones
    "2") user_country="Europe/London" ;;  # UK can be redirected directly
    "3") user_country="Europe/Paris" ;;
    "4") user_country="Europe/Bucharest" ;;  # Specific for Romania
    "5") user_country="Europe/Berlin" ;;    # Specific for Germany
    "6") user_country="America" ;;  # Use America for Canada
    "7") user_country="Europe" ;;  # Search within Europe
    *) echo "Invalid choice. Please run the script again."; exit 1 ;;
esac

# Get timezones
available_timezones=$(get_timezones "$user_country")

if [[ -z $available_timezones ]]; then
    echo "No timezones found for the country '$user_country'. Please make sure you entered the correct name."
    exit 1
fi

# Create an array of available timezones
mapfile -t timezone_array < <(echo "$available_timezones")

if [ ${#timezone_array[@]} -eq 0 ]; then
    echo "No timezones found for the given country. Exiting."
    exit 1
fi

# Display available timezones in a formatted manner
echo "Available timezones for '$user_country':"
for tz in "${timezone_array[@]}"; do
    printf "%-30s\n" "$tz"
done

# Prompt user to select a timezone
echo "Please select your preferred timezone from the list above:"
select user_timezone in "${timezone_array[@]}"; do
    if [[ -n $user_timezone ]]; then
        break
    else
        echo "Invalid selection. Please try again."
    fi
done

# Set the system timezone
timedatectl set-timezone "$user_timezone"
echo "Your timezone has been set to: $user_timezone"

# Inform the user of their current date and time in the selected timezone
echo "Current date and time in '$user_timezone':"
TZ="$user_timezone" date

# Cleaning the TTY
clear

# Prompt user for hostname
read -p "Please enter the hostname: " hostname

# Cleaning the TTY
clear

# Choose which Linux kernel u want to install
display_options() {
    echo "Please choose which Linux kernel(s) you want to install:"
    echo "1) linux"
    echo "2) linux-zen"
    echo "3) linux-lts"
    echo "4) linux and linux-lts"
    echo "5) linux-zen and linux-lts"
    echo "6) linux and linux-zen"
    echo "7) Exit"
}

# Prompt the user for their choice
prompt_choice() {
    display_options
    read -rp "Enter the number of your choice: " choice
    echo
}

# Main script execution
while true; do
    prompt_choice

    case $choice in
        1)
            linux="linux linux-headers"
            echo "You chose to install: $linux"
            break
            ;;
        2)
            linux="linux-zen linux-zen-headers"
            echo "You chose to install: $linux"
            break
            ;;
        3)
            linux="linux-lts linux-lts-headers"
            echo "You chose to install: $linux"
            break
            ;;
        4)
            linux="linux linux-headers linux-lts linux-lts-headers"
            echo "You chose to install: $linux"
            break
            ;;
        5)
            linux="linux-zen linux-zen-headers linux-lts linux-lts-headers"
            echo "You chose to install: $linux"
            break
            ;;
        6)
            linux="linux linux-headers linux-zen linux-zen-headers"
            echo "You chose to install: $linux"
            break
            ;;
        7)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done

# Cleaning the TTY
clear

# Partitions setup
#set -x
# Display available drives
echo "Available drives:"
lsblk

# Choosing the target for the installation.
echo "Available disks for the installation:"
PS3="Please select the number of the corresponding disk (e.g. 1): "
select ENTRY in $(lsblk -dpnoNAME|grep -P "/dev/sd|nvme|vd");
do
    drive="$ENTRY"
    echo "Arch Linux will be installed on the following disk: $drive"
    break
done

# Prompt for partition sizes
read -p "Enter EFI partition size in MB (e.g., 300 or 512): " efi_size
read -p "Enter the size for the Btrfs root partition in MB (e.g., 85000): " btrfsroot_size
read -p "Enter the size for the home partition in MB (e.g., 50000 or 0 to use the rest of the disk): " home_size

# Cleaning the TTY
clear

# Convert sizes to sectors (assuming 1MB = 2048 sectors)
efi_size_sec=$(( efi_size * 2048 ))
btrfs_size_sec=$(( btrfsroot_size * 2048 ))
home_size_sec=0
swap_size_sec=0

# Get the end sector using sgdisk command
ENDSECTOR=$(sgdisk -E "$drive")

# Determine sizes
if [[ -z "$home_size" ]]; then
    home_size_sec=$(( ENDSECTOR - efi_size_sec - btrfs_size_sec ))
else
    home_size_sec=$(( home_size * 2048 ))
fi

# Ask the user about creating a swap partition only if home size is not 0
if [[ "$home_size" -ne 0 ]]; then
    echo "Do you want to create a swap partition? (y/n)"
    read -r SWAP_ANSWER
fi

# Create partitions using sgdisk
sgdisk --zap-all $drive
sgdisk -og $drive
sgdisk -n 1:0:+${efi_size_sec} -c 1:"EFI" -t 1:ef00 $drive
sgdisk -n 2:0:+${btrfs_size_sec} -c 2:"BTRFSROOT" -t 2:8300 $drive
sgdisk -n 3:0:+${home_size_sec} -c 3:"HOME" -t 3:8300 $drive

# If user wants to create swap partition
    if [[ "$SWAP_ANSWER" == "y" ]]; then
        sgdisk -n 4:0:0 -c 4:"SWAP" -t 4:8200 "${drive}"  
    echo "Swap partition created using the remaining space."
fi

# Get partition information
    if [[ "$drive" == "/dev/sda" ]]; then
        part_efi="${drive}1"
        part_btrfsroot="${drive}2"
        part_home="${drive}3"
        part_swap="${drive}4"
    fi

    # Get partition information
    if [[ "$drive" == "/dev/sdb" ]]; then
        part_efi="${drive}1"
        part_btrfsroot="${drive}2"
        part_home="${drive}3"
        part_swap="${drive}4"
    fi

    # Get partition information
    if [[ "$drive" == "/dev/sdc" ]]; then
        part_efi="${drive}1"
        part_btrfsroot="${drive}2"
        part_home="${drive}3"
        part_swap="${drive}4"
    fi

    # Get partition information
    if [[ "$drive" == "/dev/nvme0n1" ]]; then
        part_efi="${drive}p1"
        part_btrfsroot="${drive}p2"
        part_home="${drive}p3"
        part_swap="${drive}p4"
    fi

    # Get partition information
    if [[ "$drive" == "/dev/nvme1n1" ]]; then
        part_efi="${drive}p1"
        part_btrfsroot="${drive}p2"
        part_home="${drive}p3"
        part_swap="${drive}p4"
    fi

# Format the partitions
mkfs.vfat -F32 $part_efi                          
mkfs.btrfs -f $part_btrfsroot                     
mkfs.ext4 -F $part_home                           

# Mount the Btrfs root partition
mount $part_btrfsroot /mnt                      
cd /mnt

# Create Btrfs subvolumes
btrfs su cr @
btrfs su cr @snapshots
btrfs su cr @log
btrfs su cr @cache
btrfs su cr @tmp
btrfs su cr @srv

# Unmount Btrfs root to remount with subvolumes
cd
umount /mnt

# Remount the subvolumes with specified options
mount -o subvol=@,noatime,ssd,compress=zstd,space_cache=v2,discard=async $part_btrfsroot /mnt  
mkdir -p /mnt/{efi,.snapshots,srv,var/log,var/cache,var/tmp,.btrfsroot,home}
mount -o subvol=@snapshots $part_btrfsroot /mnt/.snapshots                                                 
mount -o subvol=@log $part_btrfsroot /mnt/var/log                                                          
mount -o subvol=@cache $part_btrfsroot /mnt/var/cache                                                      
mount -o subvol=@tmp $part_btrfsroot /mnt/var/tmp                                                          
mount -o subvol=@srv $part_btrfsroot /mnt/srv                                                              
mount -o subvolid=5 $part_btrfsroot /mnt/.btrfsroot    

# Mount the home partition
mount $part_home /mnt/home

# Mount the EFI partition
mount $part_efi /mnt/efi

# Create and enable swap if requested
if [[ "$SWAP_ANSWER" == "y" ]]; then
    mkswap $part_swap
    swapon $part_swap
fi

# Cleaning the TTY
clear

# Display available drives
echo "Available drives:"

lsblk



echo -ne "Partitions have been created, formatted, and mounted successfully! 


The installation will continue in a few seconds..."

sleep 15

# Cleaning the TTY
clear

# Setting mirrors
reflector --verbose --country $user_country_choice -l 20 --sort rate --save /etc/pacman.d/mirrorlist

# Synchronize mirrors
pacman -Sy

# Cleaning the TTY
clear

# Detect if Intel CPU found
if lscpu | grep -qi "intel" > /dev/null; then
         ucode="intel-ucode"
    echo "Intel CPU detected. Setting ucode to '$ucode'."
else
    echo "No Intel CPU detected."
fi   

# Detect if AMD CPU found
if lscpu | grep -qi "amd" > /dev/null; then
         ucode="amd-ucode"
    echo "AMD CPU detected. Setting ucode to '$ucode'."
else
    echo "AMD CPU not detected."
fi  

# Cleaning the TTY
clear

# Install essential packages
echo "Installing essential packages..."
pacstrap -K /mnt base base-devel $linux linux-firmware $ucode efibootmgr nano openssh git dhcpcd wget reflector rsync networkmanager network-manager-applet pacman-contrib flatpak terminus-font dialog firefox grub btrfs-progs

# Cleaning the TTY
clear

# Generate fstab 
echo "Generate fstab..."
genfstab -U /mnt >> /mnt/etc/fstab

# Cleaning the TTY
clear

# Chroot into the new system
arch-chroot /mnt /bin/bash <<EOF 

# Set timezine
echo "Setting timezone to $user_timezone..."
ln -sf /usr/share/zoneinfo/$user_timezone /etc/localtime

# Sync hardware clock
hwclock --systohc

# Inform the user
echo "Timezone has been set to $timezone."

# Cleaning the TTY
clear

# Enable the selected locale in locale.gen
echo "Enabling locale: $user_locale"
if grep -q "^#$user_locale" /etc/locale.gen; then
    sed -i "s/^#$user_locale/$user_locale/" /etc/locale.gen
elif grep -q "^$user_locale" /etc/locale.gen; then
    echo "Locale '$user_locale' is already enabled."
else
    echo "Locale '$user_locale' not found in locale.gen, please check if it is correct."
    exit 1
fi

# Cleaning the TTY
clear

# Generate the locales
echo "Generating the locales..."
locale-gen

# Set the system locale
echo "LANG=\"$user_locale\"" > /etc/locale.conf
# Confirm that /etc/locale.conf has been updated successfully
if [[ $? -ne 0 ]]; then
    echo "Error: Unable to write to /etc/locale.conf"
    exit 1
fi

# Inform the user about the selected locale
echo "Your system locale has been set to: $user_locale."
echo "You can verify the locale settings with the command: locale"

# Cleaning the TTY
clear

# Set the keyboard layout
echo "Setting keyboard layout to $KEYBOARD..."
echo "KEYMAP=$KEYBOARD" > /etc/vconsole.conf

# Cleaning the TTY
clear

# Network configuration
echo "$hostname" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 $hostname.localdomain $hostname" >> /etc/hosts

# Inform the user
echo "Network configuration have been set."

# Cleaning the TTY
clear

# Set the root password
echo "Setting the root password..."
echo "root:$root_password" | chpasswd
echo "Root password has been set successfully."

# Cleaning the TTY
clear

# Create the user
useradd -m -G wheel "$username"
echo "$username:$user_password" | chpasswd
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Inform the user
echo "User $username has been created successfully."
echo "User password $password has been set successfully."

# Cleaning the TTY
clear

# Edit pacman parameters
sed -i 's/^#Color/Color/' /etc/pacman.conf
sed -i '38d' /etc/pacman.conf
sed -i '38 i ParallelDownloads = 10' /etc/pacman.conf
sed -i '92s/.//' /etc/pacman.conf
sed -i '93s/.//' /etc/pacman.conf
sed -i '34 i ILoveCandy' /etc/pacman.conf

# Refresh pacman
pacman -Syy

# Cleaning the TTY
clear

# Check for existing swap partitions
if swapon --show | grep -q '^'; then
    echo "Swap partition exists. Skipping zram-generator installation."
else
    echo "No swap partition detected. Installing zram-generator..."
    pacman -S --noconfirm zram-generator && echo "[zram0]
    zram-size = ram / 2
    swap-priority = 100" > /etc/systemd/zram-generator.conf
    echo "zram-generator installed and configuration created."
fi

# Cleaning the TTY
clear

# Installing audio drivers
yes | pacman -S alsa-utils alsa-firmware pipewire pipewire-alsa pipewire-pulse pipewire-jack pipewire-audio pipewire-zeroconf wireplumber sof-firmware pavucontrol libpipewire lib32-libpipewire lib32-pipewire ffnvcodec-headers pipewire-x11-bell pipewire-v4l2 || true

# Cleaning the TTY
clear

# Installing common pkgs
pacman -S --needed --noconfirm xorg xorg-server xorg-xinit xorg-apps xorg-twm xorg-xclock xf86-input-libinput xf86-input-evdev  xorg-xkill xdg-user-dirs xdg-user-dirs-gtk gstreamer gvfs gvfs-mtp gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-nfs gvfs-smb smartmontools arch-install-scripts libwnck3 b43-fwcutter busybox cpio mobile-broadband-provider-info modem-manager-gui net-snmp networkmanager-openconnect networkmanager-openvpn networkmanager-pptp networkmanager-vpnc dnsutils modemmanager netctl net-tools ntfs-3g sg3_utils nss-mdns usb_modeswitch whois wireless_tools dhclient dnsmasq ethtool openconnect openvpn rp-pppoe wireless-regdb wpa_supplicant wvdial iwd iw linux-atm ndisc6 ppp pptpclient vpnc xl2tpd upower hwinfo python solid mlocate glances htop screenfetch ffmpeg fsarchiver ark bluez bluez-utils bluez-tools archiso ffmpegthumbnailer poppler-glib libgsf libopenraw freetype2 gst-libav gsound gst-plugins-base gst-plugins-base-libs gst-plugins-good gst-plugins-ugly gst-plugins-bad gst-plugins-bad-libs sdparm libdvdcss systemd-ui dosfstools mtools os-prober bash-completion bc partimage json-glib libsoup dbus-glib polkit efitools cdrkit crda ddrescue exfat-utils gpart gparted android-tools android-udev mtpfs nfs-utils vte3 gtk3 libnotify desktop-file-utils appstream-glib archlinux-appstream-data gettext itstool vala meson ninja gobject-introspection squashfs-tools crypto++ ecryptfs-utils fuse3 pv unrar unzip asciidoc libhandy lxsession yaml-cpp bluez-qt5 inxi mkinitcpio-archiso plasma-framework5 qt5-tools qt5-webengine syslinux cmake clonezilla cups cups-filters cups-pdf ghostscript gsfonts foomatic-db-engine foomatic-db foomatic-db-ppds foomatic-db-nonfree foomatic-db-nonfree-ppds gutenprint foomatic-db-gutenprint-ppds system-config-printer hplip splix xf86-input-vmmouse expac lynis rkhunter bluez-obex gvim neovim fuseiso arch-audit links elinks zsh apparmor python-notify2 inotify-tools acpi acpi_call-dkms acpid 7zip adwaita-cursors adwaita-icon-theme adwaita-icon-theme-legacy accountsservice archlinux-contrib archlinux-keyring archlinux-wallpaper avahi curl cronie darkhttpd ddrescue duf fastfetch ffmpegthumbs font-manager fontconfig fwupd fwupd-efi gedit haveged hicolor-icon-theme hwdata iotop isoimagewriter jdk-openjdk lm_sensors man-db man-pages mdadm nethogs pacutils papirus-icon-theme plymouth power-profiles-daemon tar ufw ufw-extras gufw unrar unzip veracrypt which zip meld jq openbsd-netcat gstreamer-vaapi blueman discord gimp gimp-plugin-gmic fuse2fs thunderbird btop plymouth-kcm ncdu audacious audacious-plugins bleachbit conky inkscape qbittorrent shortwave shotwell libreoffice-fresh vlc vlc-plugins-all || true

# Cleaning the TTY
clear

# Installing fonts pkgs
pacman -S --needed --noconfirm ttf-dejavu gnu-free-fonts ttf-liberation ttf-bitstream-vera ttf-ubuntu-font-family ttf-caladea ttf-carlito ttf-croscore cantarell-fonts noto-fonts ttf-anonymous-pro ttf-cascadia-code ttf-droid ttf-fira-code ttf-fira-mono ttf-fira-sans woff2-font-awesome ttf-hack ttf-inconsolata ttf-opensans ttf-roboto ttf-roboto-mono adobe-source-code-pro-fonts inter-font noto-fonts-emoji || true

# Cleaning the TTY
clear

# Append BTRFS to mkinitcpio modules
sed -i '/^MODULES=/s/)/btrfs)/' /etc/mkinitcpio.conf

# Check for Intel Integrated Graphics Controller
if lscpu | grep -i "intel" > /dev/null; then
    echo "INTEL GPU detected...Install INTEL drivers"
    sed -i '/^MODULES=/s/)/ i915)/' /etc/mkinitcpio.conf  && pacman -S --needed --noconfirm libvdpau-va-gl libva-intel-driver vulkan-intel intel-gmmlib intel-media-driver libva-utils vulkan-headers vulkan-icd-loader vulkan-tools mesa mesa-utils mesa-demos lib32-mesa intel-gpu-tools || true
fi  

# Check for the NVIDIA GPU
if lspci | grep -i nvidia > /dev/null; then
    echo "NVIDIA GPU detected...Install NVIDIA drivers"
    pacman -S --noconfirm nvidia-dkms libglvnd nvidia-utils opencl-nvidia lib32-libglvnd lib32-nvidia-utils lib32-opencl-nvidia nvidia-settings nvidia-prime nvtop
    sed -i '/^MODULES=/s/)/ nvidia)/' /etc/mkinitcpio.conf 
else
    echo "No NVIDIA GPU detected. Skipping NVIDIA driver installation."
fi

# Check for AMD GPU
if lspci | grep -i "advanced micro devices" > /dev/null; then
   echo "AMD GPU detected..."
   pacman -S --noconfirm --needed xf86-video-amdgpu
   sed -i '/^MODULES=/s/)/ amdgpu)/' /etc/mkinitcpio.conf
fi

# Cleaning the TTY
clear

# Installing KDE-Plasma as desktop environment
pacman -S --needed --noconfirm kf6 qt6 plasma-meta kde-applications-meta packagekit-qt6 kde-cli-tools kdeplasma-addons plasma-activities polkit-kde-agent flatpak-kcm bluedevil glib2 ibus kaccounts-integration kscreen libaccounts-qt plasma-nm plasma-pa scim extra-cmake-modules kaccounts-integration kdoctools libibus wayland-protocols plasma-applet-window-buttons plasma-workspace appmenu-gtk-module kwayland-integration plasma5-integration xdg-desktop-portal-gtk kde-pim-meta kde-system-meta kde-gtk-config kwin-x11 plasma-x11-session gnome-disk-utility || true

# Cleaning the TTY
clear

# installing snapper for btrfs filesystem
pacman -S --needed --noconfirm grub-btrfs snap-pac snapper

# Add flatpak repo
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Grub bootloader install for mount point /mnt/efi
grub-install --target=x86_64-efi --efi-directory=/efi --boot-directory=/boot --bootloader-id=GRUB $part_btrfsroot

# Update GRUB configuration for multiple kernels when btrfs file system exist
if [[ $choice -ge 4 && $choice -le 6 ]]; then
    echo "Two kernels are installed. Updating Grub configuration file..."
    if [ -f /etc/default/grub ]; then
        sed -i '3d' /etc/default/grub
        sed -i '3i GRUB_DEFAULT="1>2"' /etc/default/grub
        echo "GRUB configuration has been updated."
    else
        echo "GRUB configuration file not found. No changes made."
    fi
else
    echo "One kernel installed or grub configuration file not found or not required to be updated...."
fi

# Grub configuration settings
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

# Snapper configuration
umount /.snapshots
rm -rf /.snapshots
snapper --no-dbus -c root create-config /
btrfs subvolume delete /.snapshots
mkdir /.snapshots
mount -a
chmod a+rx /.snapshots
chown :$username /.snapshots
# Setting default btrfs subvol 256 root 
btrfs subvol set-default 256 /
   

# Set keymap service to run on the first boot
if [[ "$KEYBOARD" == "uk" ]]; then
    # Creating set-keymap service
    echo "
    [Unit]
    Description=Set X11 Keymap
    After=local-fs.target
    
    [Service]
    Type=oneshot
    ExecStart=/usr/bin/localectl --no-convert set-x11-keymap gb pc104
    RemainAfterExit=yes
    
    [Install]
    WantedBy=multi-user.target" > /etc/systemd/system/set-keymap.service
else
      # Creating set-keymap service
    echo "
    [Unit]
    Description=Set X11 Keymap
    After=local-fs.target
    
    [Service]
    Type=oneshot
    ExecStart=/usr/bin/localectl --no-convert set-x11-keymap $KEYBOARD
    RemainAfterExit=yes
    
    [Install]
    WantedBy=multi-user.target" > /etc/systemd/system/set-keymap.service
fi     

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
systemctl enable set-keymap.service
systemctl enable sddm.service

# Edit system parameters
sed -i '50s/^#DefaultTimeoutStopSec=90s/DefaultTimeoutStopSec=5s/' /etc/systemd/system.conf

# Refreshing grub
grub-mkconfig -o /boot/grub/grub.cfg

# Generating intramfs
mkinitcpio -P

EOF

# Copy ArchLinux into working directory after reboot
cp -r Archlinux /mnt/home/$username

# Setting boot wallpaper in directory
cp -r Archlinux/splash.png /mnt/etc/default

# Unmount all partitions and reboot
umount -R /mnt
reboot
















