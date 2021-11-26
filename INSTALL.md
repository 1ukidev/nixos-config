## No encryption | Optimized for SSD
## Installation:
### Become superuser
```
sudo -i
```

### Load keyboard layout if necessary
```
loadkeys <layout>
```

### Enable Wi-Fi if necessary
```
ifconfig <interface> up
wpa_passphrase <ssid> <passphrase> >> /etc/wpa_supplicant.conf
wpa_supplicant -B -i <interface> -c /etc/wpa_supplicant.conf
```

### Partition disk
```
wipefs -a /dev/sdX
cfdisk -z /dev/sdX
mkfs.fat -F 32 /dev/sdXX && fatlabel /dev/sdXX BOOT
mkfs.btrfs -f -L ROOT /dev/sdXX
mkswap -L SWAP /dev/sdXX
```

### Mount partitions
```
swapon /dev/sdXX
mount /dev/sdXX /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix
btrfs subvolume create /mnt/var
btrfs subvolume create /mnt/tmp
umount /mnt
mount -o subvol=root,noatime,space_cache=v2,autodefrag,discard=async,compress=zstd /dev/sdXX /mnt
mkdir /mnt/home
mount -o subvol=home,noatime,space_cache=v2,autodefrag,discard=async,compress=zstd /dev/sdXX /mnt/home
mkdir /mnt/nix
mount -o subvol=nix,noatime,space_cache=v2,autodefrag,discard=async,compress=zstd /dev/sdXX /mnt/nix
mkdir /mnt/var
mount -o subvol=var,noatime,space_cache=v2,autodefrag,discard=async,compress=zstd /dev/sdXX /mnt/var
mkdir /mnt/tmp
mount -o subvol=tmp,noatime,space_cache=v2,autodefrag,discard=async,compress=zstd /dev/sdXX /mnt/tmp
mkdir -p /mnt/boot/efi
mount /dev/sdXX /mnt/boot/efi
```

### Generate config
```
nixos-generate-config --root /mnt
```

### Download my configuration
```
curl -L -O https://github.com/1ukidev/nixos-config/archive/main.tar.gz
tar xf main.tar.gz
cd nixos-config-main/Nix
cp configuration.nix /mnt/etc/nixos/configuration.nix
cp packages.nix /mnt/etc/nixos
```

### Install NixOS
```
*Remove "options" from all "fileSystems" in hardware-configuration.nix*
*The mount options are defined in configuration.nix*
nixos-install -j $(nproc)
reboot
```

## Post-installation:
### Set password on user
```
*CTRL+ALT+F1*
*Login as root*
passwd <user>
exit
*CTRL+ALT+F7*
```

### Run ./pos-install.sh
```
*Login with your user*
*Super+Return*
*Enable Wi-Fi with nmtui if necessary*
git clone https://github.com/1ukidev/nixos-config
cd nixos-config
./pos-install.sh
cd ../rofi
./setup.sh
cd ../polybar-themes
./setup.sh
reboot
```
