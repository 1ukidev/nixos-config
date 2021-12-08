#!/usr/bin/env bash
# Shell script to run some important tasks
set -e

# Create user folders
xdg-user-dirs-update

# Download polybar-themes and rofi (credits for adi1090x)
git clone --depth=1 https://github.com/adi1090x/polybar-themes.git $HOME/polybar-themes
chmod +x $HOME/polybar-themes/setup.sh
git clone --depth=1 https://github.com/adi1090x/rofi $HOME/rofi
chmod +x $HOME/rofi/setup.sh 

# Setup i3
cp Configs/i3-config $HOME/.config/i3/config

# Setup kitty
mkdir -p $HOME/.config/kitty
cp Configs/kitty.conf $HOME/.config/kitty

# Setup picom
mkdir -p $HOME/.config/picom
cp Configs/picom.conf $HOME/.config/picom

# Setup Dunst
mkdir -p $HOME/.config/dunst
cp Configs/dunstrc $HOME/.config/dunst

# Move wallpaper to ~/Pictures/Wallpapers
mkdir -p $HOME/Pictures/Wallpapers
cp Wallpaper/1.jpg $HOME/Pictures/Wallpapers

# Move wallpaper to /usr/share/backgrounds
sudo mkdir -p /usr/share/backgrounds
sudo cp Wallpaper/1.jpg /usr/share/backgrounds

# Update Nix channel
sudo nix-channel --update

# Clean system
sudo nix-collect-garbage -d
printf "Cleaning...\nThis may take a while...\n"
sudo nix-store --optimise

# Compress and defragment subvolumes (only Btrfs)
printf "\nCompressing and defragmenting /..."
sudo btrfs filesystem defragment -r -czstd /
printf "\nCompressing and defragmenting /home..."
sudo btrfs filesystem defragment -r -czstd /home
printf "\nCompressing and defragmenting /nix...\nThis can take a long time to finish..."
sudo btrfs filesystem defragment -r -czstd /nix
printf "\nCompressing and defragmenting /var..."
sudo btrfs filesystem defragment -r -czstd /var
printf "\nCompressing and defragmenting /tmp...\n"
sudo btrfs filesystem defragment -r -czstd /tmp

# End
printf "\nSuccessfully concluded.\n\n"
