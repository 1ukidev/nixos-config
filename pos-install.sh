# Shell script to configure some things
# Untested script

set -e

# Enable unfree packages
mkdir -p $HOME/.config/nixpkgs
printf "{ allowUnfree = true; }" >> $HOME/.config/nixpkgs/config.nix

# Download polybar-themes e rofi (credits for adi1090x)
git clone --depth=1 https://github.com/adi1090x/polybar-themes.git $HOME/polybar-themes
chmod +x $HOME/polybar-themes/setup.sh
git clone --depth=1 https://github.com/adi1090x/rofi $HOME/rofi
chmod +x $HOME/rofi/setup.sh 

# Configure i3
cp Configs/i3config $HOME/.config/i3/config

# Configure alacritty
mkdir -p $HOME/.config/alacritty
cp Configs/alacritty.yml $HOME/.config/alacritty

# Configure picom
mkdir -p $HOME/.config/picom
cp Configs/picom.conf $HOME/.config/picom

# Configure dunst
mkdir -p $HOME/.config/dunst
cp Configs/dunstrc $HOME/.config/dunst

# Transfer wallpaper
mkdir -p $HOME/Imagens/Wallpapers
cp Wallpaper/1.jpg $HOME/Imagens/Wallpapers

# Transfer wallpaper to /usr/share/backgrounds (because of LightDM)
sudo mkdir -p /usr/share/backgrounds
sudo cp Wallpaper/1.jpg /usr/share/backgrounds

# Update nix
sudo nix-channel --update

# Run garbage collect
sudo nix-collect-garbage

# End
printf "\n\nEverything is ok.\n\n\n"
