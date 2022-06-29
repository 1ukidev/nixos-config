#!/usr/bin/env bash
# Shell script to run some important tasks
set -e

# Move wallpaper to ~/Pictures/Wallpapers
#mkdir -p $HOME/Pictures/Wallpapers
#cp Wallpaper/1.png $HOME/Pictures/Wallpapers
mkdir -p $HOME/Imagens/Wallpapers
cp Wallpaper/1.png $HOME/Imagens/Wallpapers

# Update Nix channel
sudo nix-channel --update

# Setup home-manager
cp -r nixpkgs $HOME/.config/
home-manager switch

# Clean system
sudo nix-collect-garbage -d
printf "Cleaning...\nThis may take a while...\n"
sudo nix-store --optimise

# End
printf "\nSuccessfully concluded.\n\n"
