# NixOS 23.05 packages - 1ukidev

{ config, pkgs, ... }:

# Easy way to install unstable packages.
let
  unstable = import (builtins.fetchTarball
    "https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable") {
    config = config.nixpkgs.config;
  };
in

{
  # Install system packages.
  # Some packages are enabled in configuration.nix
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # In alphabetic order
    
    # Internet
    (vivaldi.override {
      commandLineArgs = [
        "--force-dark-mode"
        "--disable-features=UseChromeOSDirectVideoDecoder"
        "--enable-features=VaapiVideoDecoder,VaapiIgnoreDriverChecks"  
      ];
    })
    #tor-browser-bundle-bin
    ipfs
    kodi
    unstable.signal-desktop
    unstable.tdesktop
    qbittorrent
    unstable.discord

    # Production
    audacity
    darktable
    kdenlive
    krita

    # Development
    emacs
    unstable.vscode
    diff-so-fancy
    git
    gitui
    unstable.neovim
    fritzing
    distrobox

    # System
    aria
    bat
    curl
    dosfstools
    duf
    exa
    exfat
    exfatprogs
    fuse
    home-manager
    linuxHeaders
    pciutils
    ripgrep
    srm
    udisks
    upower
    xorg.xhost

    # Video, audio and recording
    ffmpeg
    mpv
    simplescreenrecorder
    stremio
    vlc

    # Extras
    alsaUtils
    anki
    appimage-run
    calibre
    cron
    fd
    flex
    killall
    linuxKernel.packages.linux_zen.cpupower
    lm_sensors
    scrcpy
    sct
    syncthing
    tailscale
    tldr
    unstable.betterdiscordctl
    unstable.warpd
    winetricks
    wineWowPackages.full
    wirelesstools
    xbanish
    xcolor
    xdg-launch
    xdg_utils
    xdg-user-dirs
    xorg.xkill
    xsane

    # CLI/TUI tools and some useless packages
    btop
    btrfs-progs
    cmatrix
    compsize
    figlet
    htop
    libva-utils
    intel-gpu-tools
    iotop
    ncdu
    neofetch
    nix-tree
    nixos-option
    onefetch
    pipes
    spotdl
    thefuck
    tmux
    tokei
    tree
    tty-clock
    unstable.zsh-powerlevel10k
    yt-dlp

    # Games
    ppsspp
    #superTuxKart
    steam
    #snes9x-gtk
    duckstation
    #unstable.osu-lazer

    # Text
    libreoffice-fresh
    unstable.pandoc
    unstable.groff
    unstable.obsidian

    # Security and cleaning tools
    bleachbit
    dig
    nmap
    protonvpn-cli
    #veracrypt
    wireshark

    # Virtualization
    qemu
    qemu-utils
 
    # Libs
    libopus
    libvorbis
    libvpx
    x264
    x265
   
    # Compression tools
    lz4
    p7zip
    unrar
    unzip
    xz
    zstd

    # Others GNU tools
    bc
    file
  ];
}
