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
cfdisk -z /dev/sdX
mkfs.fat -F 32 /dev/sdXX && fatlabel /dev/sdXX BOOT
mkfs.btrfs -f -L ROOT /dev/sdXX
mkswap -L SWAP /dev/sdXX
```

### Mount partitions
```
swapon /dev/sdXX
mount /dev/sdXX /mnt
btrfs subvolume create /mnt/nixos
umount /mnt
mount -o subvol=nixos /dev/sdXX /mnt
btrfs subvolume create /mnt/var
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/tmp
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
cd nixos-config-main
cd Nix
cp configuration.nix /mnt/etc/nixos/configuration.nix
```

### Install NixOS
```
*Remove "options" inside the partition / in /mnt/etc/nixos/hardware-configuration.nix file*
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
