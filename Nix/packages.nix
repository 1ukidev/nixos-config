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
    chromium
    element-desktop
    ipfs
    kodi
    megasync
    ngrok
    qbittorrent
    qutebrowser
    signal-desktop
    unstable.tdesktop
    # tor-browser-bundle-bin
    unstable.discord

    # Production
    audacity-gtk3
    blender
    gimp-with-plugins
    inkscape-with-extensions
    kdenlive
    lmms

    # Development
    adoptopenjdk-bin
    adoptopenjdk-jre-bin
    android-studio
    cargo
    clang_12
    cmake
    dotnet-sdk_5
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
    netbeans
    ninja
    nodejs-14_x
    nodePackages.npm
    postman
    python39Full
    python39Packages.pip
    pypy3
    qtcreator
    rustc
    shc
    unstable.dotnet-runtime
    unstable.sublime4
    unstable.vscode
    vimHugeX
    yarn

    # System
    aria
    coreutils-full
    curl
    dosfstools
    dracula-theme
    duf
    dunst
    exa
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
    okular
    papirus-icon-theme
    pavucontrol
    picom
    ripgrep
    srm
    sxiv
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    utillinux
    xarchiver
    xfce.xfce4-power-manager
    xorg.xbacklight

    # Video, audio and recording
    cmus
    ffmpeg
    mplayer
    mpv
    obs-studio
    simplescreenrecorder
    vlc

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
    iotop
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
    pcsx2
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
    dig
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
    gnome.gvfs
    libcaca
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
