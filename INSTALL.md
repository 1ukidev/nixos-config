## Unencrypted / Optimized for SSD
## Installation:
### Become superuser
```
# sudo -i
```

### Load keyboard layout if necessary
```
# loadkeys <layout>
```

### Enable Wi-Fi if necessary
```
# ifconfig <interface> up
# wpa_passphrase <ssid> <passphrase> >> /etc/wpa_supplicant.conf
# wpa_supplicant -B -i <interface> -c /etc/wpa_supplicant.conf
```

### Partition disk
```
# wipefs -a /dev/nvme0n1pX
# cfdisk -z /dev/nvme0n1pX
# mkfs.fat -nEFI -F32 /dev/nvme0n1pX
# mkfs.btrfs -f -L ROOT --csum xxhash /dev/nvme0n1pX
# mkswap -L SWAP /dev/nvme0n1pX
```

### Mount partitions
```
# swapon /dev/nvme0n1pX
# BTRFS_OPTS="noatime,space_cache=v2,autodefrag,discard=async,compress=zstd"
# mount -o $BTRFS_OPTS /dev/nvme0n1pX /mnt
# btrfs subvolume create /mnt/@
# btrfs subvolume create /mnt/@home
# btrfs subvolume create /mnt/@nix
# btrfs subvolume create /mnt/@var
# btrfs subvolume create /mnt/@tmp
# umount /mnt
# mount -o subvol=@,$BTRFS_OPTS /dev/nvme0n1pX /mnt
# mkdir -p /mnt/{home,nix,var,tmp,boot/efi}
# mount -o subvol=@home,$BTRFS_OPTS /dev/nvme0n1pX /mnt/home
# mount -o subvol=@nix,$BTRFS_OPTS /dev/nvme0n1pX /mnt/nix
# mount -o subvol=@var,$BTRFS_OPTS /dev/nvme0n1pX /mnt/var
# mount -o subvol=@tmp,$BTRFS_OPTS /dev/nvme0n1pX /mnt/tmp
# mount -o noatime /dev/nvme0n1pX /mnt/boot/efi
```

### Generate configuration
```
# nixos-generate-config --root /mnt
```

### Download my configuration
```
# curl -LO https://github.com/1ukidev/nixos-config/archive/kde.tar.gz
# tar xf kde.tar.gz
# cd nixos-config-kde/Nix
# cp * /mnt/etc/nixos
```

### Install NixOS
```
*Remove "options" from all "fileSystems" in hardware-configuration.nix*
*The mount options are defined in configuration.nix*
# nixos-install --cores $(nproc)
# reboot
```

## Post-installation:
### Set password on user
```
*CTRL+ALT+F1*
*Login as root*
# passwd <user>
# exit
*CTRL+ALT+F7*
```

### Run ./pos-install.sh
```
*Login with your user*
*Open terminal*
# git clone https://github.com/1ukidev/nixos-config
# cd nixos-config
# ./pos-install.sh
```

```
# reboot
```
