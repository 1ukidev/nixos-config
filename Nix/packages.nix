# NixOS 22.11 packages - 1ukidev

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
    firefox-bin
    google-chrome
    ipfs
    kodi
    signal-desktop
    unstable.tdesktop
    # tor-browser-bundle-bin
    transmission-gtk
    unstable.discord

    # Production
    audacity
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
    lldb_14
    nasm
    neovim
    # ngrok
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
    unstable.vscodium
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
    home-manager
    kitty
    linuxHeaders
    papirus-icon-theme
    pciutils
    ripgrep
    srm
    udisks
    upower
    utillinux
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
    hdparm
    killall
    linuxKernel.packages.linux_zen.cpupower
    lm_sensors
    lolcat
    scrcpy
    sct
    syncthing
    tailscale
    tldr
    unstable.betterdiscordctl
    unstable.warpd
    vulkan-tools
    winetricks
    wineWowPackages.full
    wirelesstools
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
    cmatrix
    compsize
    cpufetch
    elinks
    figlet
    htop
    libva-utils
    intel-gpu-tools
    iotop
    ncdu
    neofetch
    nix-tree
    nixos-option
    nnn
    onefetch
    pipes
    speedtest-cli
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
    superTuxKart
    steam
    # snes9x-gtk
    duckstation
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
    qemu
    qemu-utils
 
    # Libs
    glibc
    gvfs
    libopus
    libsForQt5.full
    libsForQt5.sddm-kcm
    libvorbis
    libvpx
    llvm_14
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
