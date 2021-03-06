# NixOS 22.05 packages - 1ukidev

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
    ipfs
    kodi
    qbittorrent
    qutebrowser
    signal-desktop
    unstable.tdesktop
    # tor-browser-bundle-bin
    unstable.discord

    # Production
    audacity-gtk3
    blender
    darktable
    kdenlive
    krita

    # Development
    adoptopenjdk-bin
    adoptopenjdk-jre-bin
    android-studio
    cabal-install
    cargo
    clang_14
    cmake
    distrobox
    diff-so-fancy
    unstable.emacs
    fritzing
    gcc12
    gdb
    gh
    ghc
    ghidra-bin
    git
    gnumake
    go
    google-cloud-sdk
    lldb_14
    nasm
    neovim
    ngrok
    ninja
    nodejs-16_x
    nodePackages.npm
    pypy3
    python39Full
    python39Packages.pip
    qtcreator
    rustc
    scenebuilder
    shc
    unstable.vscode
    yarn

    # System
    aria
    bat
    coreutils-full
    curl
    dosfstools
    dracula-theme
    duf
    exa
    exfat
    exfatprogs
    flameshot
    fuse
    gnome.gnome-tweaks
    home-manager
    kitty
    linuxHeaders
    lxqt.lxqt-sudo
    papirus-icon-theme
    pciutils
    ripgrep
    srm
    udisks
    upower
    utillinux
    xorg.xhost

    # Gnome extensions
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.caffeine
    gnomeExtensions.places-status-indicator
    gnomeExtensions.openweather

    # Video, audio and recording
    cmus
    ffmpeg
    mpv
    simplescreenrecorder
    vlc

    # Extras
    alsaUtils
    anki
    appimage-run
    calibre
    cron
    fd
    flex
    hakuneko
    hdparm
    keynav
    killall
    linuxKernel.packages.linux_zen.cpupower
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
    btop
    btrfs-progs
    cava
    cmatrix
    compsize
    cpufetch
    elinks
    figlet
    htop
    intel-gpu-tools
    iotop
    ncdu
    neofetch
    nix-tree
    nnn
    pipes
    speedtest-cli
    spotdl
    tmux
    tokei
    tree
    tty-clock
    yt-dlp

    # Games
    chiaki
    ppsspp
    superTuxKart
    # snes9x-gtk
    # unstable.osu-lazer

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
    # veracrypt
    wireshark

    # Virtualization
    gnome.gnome-boxes
    qemu
    qemu-utils
 
    # Libs
    glibc
    gvfs
    libopus
    libsForQt5.full
    libsForQt5.qtstyleplugins
    libvorbis
    libvpx
    llvm_14
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
    fakeroot
    file
    findutils
    gawk
    gettext
    gnum4
    gnupatch
    gnused
    libtool
    pkgconf
    texinfo
    which
  ];
}
