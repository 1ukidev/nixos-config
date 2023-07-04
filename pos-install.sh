#!/usr/bin/env bash
# Shell script to run some important tasks
set -e

# Move wallpaper to ~/Imagens/Wallpapers
mkdir -p $HOME/Imagens/Wallpapers
cp Wallpaper/"NixOS (by lunik1).png" $HOME/Imagens/Wallpapers

# Add home-manager channel
nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager

# Update Nix channel
sudo nix-channel --update
nix-channel --update

# Setup home-manager
cp -r home-manager $HOME/.config/
home-manager switch

# Clean system
sudo nix-collect-garbage -d
printf "Cleaning...\nThis may take a while...\n"
sudo nix-store --optimise

# End
printf "\nSuccessfully concluded.\n\n"
