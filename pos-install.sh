#!/usr/bin/env bash
# Shell script to configure some things
set -e

# Create user folders
xdg-user-dirs-update

# Download polybar-themes and rofi (credits for adi1090x)
git clone --depth=1 https://github.com/adi1090x/polybar-themes.git $HOME/polybar-themes
chmod +x $HOME/polybar-themes/setup.sh
git clone --depth=1 https://github.com/adi1090x/rofi $HOME/rofi
chmod +x $HOME/rofi/setup.sh 

# Setup i3
cp Configs/i3config $HOME/.config/i3/config

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

# Move wallpaper to /usr/share/backgrounds (because of LightDM)
sudo mkdir -p /usr/share/backgrounds
sudo cp Wallpaper/1.jpg /usr/share/backgrounds

# Update Nix
sudo nix-channel --update

# Clean system
sudo nix-collect-garbage -d
printf "Cleaning...\nThis may take a while.\n"
sudo nix-store --optimise

# Compress and defragment / (only Btrfs)
printf "\nCompressing and defragmenting /\nThis can take a long time to finish.\n"
sudo btrfs filesystem defragment -r -czstd /

# End
printf "\nSuccessfully concluded.\n\n"
