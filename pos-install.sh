#!/usr/bin/env bash
# Shell script to run some important tasks
set -e

# Create user folders
xdg-user-dirs-update

# Clone polybar-themes (credits for adi1090x)
git clone --depth=1 https://github.com/adi1090x/polybar-themes.git $HOME/polybar-themes
chmod +x $HOME/polybar-themes/setup.sh

# Setup Dunst
mkdir -p $HOME/.config/dunst
cp Configs/dunstrc $HOME/.config/dunst

# Move wallpaper to ~/Pictures/Wallpapers
#mkdir -p $HOME/Pictures/Wallpapers
#cp Wallpaper/1.jpg $HOME/Pictures/Wallpapers
mkdir -p $HOME/Imagens/Wallpapers
cp Wallpaper/1.jpg $HOME/Imagens/Wallpapers

# Move wallpaper to /usr/share/backgrounds
sudo mkdir -p /usr/share/backgrounds
sudo cp Wallpaper/1.jpg /usr/share/backgrounds

# Update Nix channel
sudo nix-channel --update

# Setup home-manager
cp -r nixpkgs $HOME/.config/
home-manager switch

# Clean system
sudo nix-collect-garbage -d
printf "Cleaning...\nThis may take a while...\n"
sudo nix-store --optimise

# Compress and defragment subvolumes (only Btrfs)
printf "\nCompressing and defragmenting /...\n"
sudo btrfs filesystem defragment -r -czstd /
printf "Compressing and defragmenting /home..."
sudo btrfs filesystem defragment -r -czstd /home
printf "\nCompressing and defragmenting /nix...\nThis can take a long time to finish..."
sudo btrfs filesystem defragment -r -czstd /nix
printf "\nCompressing and defragmenting /var..."
sudo btrfs filesystem defragment -r -czstd /var
printf "\nCompressing and defragmenting /tmp...\n"
sudo btrfs filesystem defragment -r -czstd /tmp

# End
printf "\nSuccessfully concluded.\n\n"
