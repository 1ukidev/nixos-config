## No encryption
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
mount -o subvol=root,noatime,space_cache,autodefrag,discard,compress=zstd /dev/sdXX /mnt
mkdir /mnt/home
mount -o subvol=home,noatime,space_cache,autodefrag,discard,compress=zstd /dev/sdXX /mnt
mkdir /mnt/nix
mount -o subvol=nix,noatime,space_cache,autodefrag,discard,compress=zstd /dev/sdXX /mnt
mkdir /mnt/var
mount -o subvol=var,noatime,space_cache,autodefrag,discard,compress=zstd /dev/sdXX /mnt
mkdir /mnt/tmp
mount -o subvol=tmp,noatime,space_cache,autodefrag,discard,compress=zstd /dev/sdXX /mnt
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
```

### Install NixOS
```
*Remove "options" from all "fileSystems" in hardware-configuration.nix*
*The mount options are defined in configuration.nix*
nixos-install -j 4
reboot
```

## Post-installation:
### Set password on user
```
*CTRL+ALT+F1*
*Login as root*
passwd <user>
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
```
