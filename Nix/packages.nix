# NixOS 21.05 packages - 1ukidev

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
    # In alphabetic order.
    # Internet
    brave
    element-desktop
    firefox-bin
    ipfs
    kodi
    megasync
    ngrok
    pidgin
    qutebrowser
    ripcord
    signal-desktop
    tdesktop
    thunderbird-bin
    # tor-browser-bundle-bin
    transmission_gtk
    unstable.discord
    unstable.dotnet-runtime
    unstable.dotnet-sdk

    # Production
    audacity-gtk3
    blender
    gimp-with-plugins
    inkscape-with-extensions
    kdenlive
    lmms

    # Development
    android-studio
    cargo
    clang_12
    cmake
    emacs
    fritzing
    gcc11
    gdb
    gh
    ghc
    gitFull
    gnumake
    go
    google-cloud-sdk
    nasm
    neovide
    neovim
    ninja
    nodejs-14_x
    nodePackages.npm
    # oraclejdk8
    # oraclejre8
    postman
    python39Full
    python39Packages.pip
    qtcreator
    rustc
    shc
    unstable.sublime4
    unstable.vscode
    yarn

    # System
    aria
    coreutils-full
    curl
    dosfstools
    dracula-theme
    dunst
    exfat
    exfatprogs
    flameshot
    fuse
    gparted
    kitty
    leafpad
    linuxHeaders
    linuxPackages_zen.v4l2loopback
    lxappearance
    mtpfs
    nitrogen
    papirus-icon-theme
    pavucontrol
    picom
    ripgrep
    sxiv
    thunar
    thunar-volman
    utillinux
    xarchiver
    xfce.xfce4-power-manager
    xorg.xbacklight
    zathura

    # Video, audio and recording
    cmus
    ffmpeg-full
    mpv
    obs-studio
    simplescreenrecorder

    # Extras
    alsaUtils
    anki
    appimage-run
    calibre
    cool-retro-term
    cron
    fd
    flex
    gksu
    hdparm
    keynav
    killall
    lm_sensors
    lolcat
    scrcpy
    sct
    tldr
    unstable.betterdiscordctl
    vulkan-tools
    winetricks
    wineWowPackages.full
    wirelesstools
    xbanish
    xcolor
    xdg-launch
    xdg_utils
    xdg-user-dirs
    xonsh
    xorg.xkill
    xsane

    # CLI/TUI tools and some useless packages
    bpytop
    btrfsProgs
    cmatrix
    compsize
    cpufetch
    drive
    elinks
    figlet
    htop
    ncdu
    neofetch
    nix-tree
    nnn
    pfetch
    pipes
    pulsemixer
    speedtest-cli
    spotdl
    tmux
    tokei
    tree
    tty-clock
    youtube-dl

    # Games
    chiaki
    ppsspp
    snes9x-gtk
    unstable.osu-lazer

    # Text
    libreoffice-fresh
    pandoc
    unstable.groff
    unstable.obsidian

    # Security and clean
    bleachbit
    chkrootkit
    nmap
    protonvpn-cli
    veracrypt
    wireshark

    # Virtualization
    docker
    qemu
    qemu-utils
    virt-manager
 
    # Libs
    glibc
    libopus
    libsForQt5.full
    libsForQt5.qtstyleplugins
    libvirt
    libvorbis
    libvpx
    llvm_12
    python39Packages.pygame
    x264
    x265
   
    # Compression tools
    lz4
    p7zip
    unrar
    unzip
    xz
    zstd

    # Others GNU tools (unnecessary?)
    autoconf
    automake
    bc
    binutils
    bison
    file
    findutils
    gawk
    gettext
    gnum4
    gnupatch
    gnused
    libtool
    mc
    pkgconf
    texinfo
    which
  ];
}
