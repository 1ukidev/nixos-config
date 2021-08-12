# NixOS 21.05 config - 1ukidev

{ config, pkgs, lib, ... }:

# Easy way to install unstable packages.
let
  unstable = import (builtins.fetchTarball
    "https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable") {
    config = config.nixpkgs.config;
  };
in 

{
  imports = [ 
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Enable unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Allow "wheel" on nix.
  nix.allowedUsers = [ "@wheel" ];
  nix.trustedUsers = [ "@wheel" ];

  # Use zen kernel.
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Define mount options (only btrfs).
  fileSystems."/" = {
    options = [ "subvol=nixos" "compress=zstd" "discard" "noatime" "ssd" "space_cache" "autodefrag" ];
  };

  # Set CPUFreq governor.
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  # Use GRUB 2 bootloader.
  boot.loader = {
    timeout = 1;
    efi = {
      canTouchEfiVariables = false;
      efiSysMountPoint = "/boot/efi";
    };
    
    grub = {
      enable = true;
      version = 2;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
    };
  };

  networking.hostName = "LuKi-PC"; # Define your hostname.
  networking.wireless.enable = false; # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Enable NetworkManager.

  # Define DNS.
  networking.networkmanager.insertNameservers = [ "8.8.8.8" "8.8.4.4" ];
  networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.wlo1.useDHCP = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };

  # Enable X11, LightDM, i3 and XMonad.
  services.xserver = {
    enable = true;
    displayManager = {
      lightdm.enable = true;
      lightdm.background = "/usr/share/backgrounds/1.jpg";
      lightdm.greeters.gtk = {
        enable = true;
        theme = { name = "Dracula"; };
      };
      defaultSession = "none+i3";
    };
    
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [ rofi polybarFull i3lock ];
    };
    
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
  };

  # Set environment.
  environment.variables = { EDITOR = "emacs"; };

  # Enable qt5ct.
  programs.qt5ct.enable = true;

  # Set keymap in X11.
  services.xserver.layout = "br";

  # Enable drivers in X11.
  services.xserver.videoDrivers = [ "modesetting" ];
  services.xserver.useGlamor = true;
  services.xserver.libinput.enable = true;
  
  # Enable support for Intel hybrid codec and NUR.
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    nur = import (builtins.fetchTarball
      "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
  };

  # Enable OpenGL and accelerated video playback (experimental).
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Update Intel microcode.
  hardware.cpu.intel.updateMicrocode = true;

  # Enable print support.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.epson-escpr2 ];
  hardware.sane.enable = false;
  hardware.sane.extraBackends = [ pkgs.epkowa ];

  # Enable Bluetooth support.
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable sound and PulseAudio.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    # Reduce microphone noise.
    extraConfig = ''
      load-module module-echo-cancel aec_args="analog_gain_control=0 digital_gain_control=0" source_name=noiseless
      set-default-source noiseless
    '';
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.luki = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "fuse" "video" "audio" "scanner" "lp" ];
    shell = pkgs.fish;
  };

  # Configure fish.
  programs.fish = {
    enable = true;
    shellAliases = {
      sysrs = "sudo nixos-rebuild switch";
      sysup = "sudo nixos-rebuild switch --upgrade";
      sysrsgit = "sysrs -I nixpkgs=/home/$USER/nixpkgs";
      sysupgit = "sysup -I nixpkgs=/home/$USER/nixpkgs";
      sysclean = "sudo nix-collect-garbage -d; and sudo nix-store --optimise";
      search = "nix search";
      nixconfig = "sudo nvim /etc/nixos/configuration.nix";
      lgit = "git add .; and git commit; and git push";
      lgitf = "git add .; and git commit; and git pull; and git push";
      ga = "git add .";
      ll = "ls -l";
      l = "ls -a";
      la = "ls -la";
      grep = "rg";
      rmf = "sudo rm -rf";
      cp = "cp -i";
    };

    shellInit = ''
      # Remove welcome message.
      set fish_greeting ""
    '';
  };

  # Change root shell.
  users.users.root = { shell = pkgs.fish; };

  # Install fonts.
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    dejavu_fonts
    corefonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Define fontconfig.
  fonts.fontconfig = {
    enable = true;
    antialias = true;
    useEmbeddedBitmaps = true;
    defaultFonts = {
      serif = [
        "Noto Serif"
        "Noto Color Emoji"
        "Noto Emoji"
        "DejaVu Serif"
      ];
      
      sansSerif = [ 
        "Noto Sans"
        "Noto Color Emoji"
        "Noto Emoji"
        "DejaVu Sans" 
      ];

      monospace = [
        "JetBrainsMono Nerd Font"
        "Noto Color Emoji"
        "Noto Emoji"
        "Noto Sans Mono"
      ];
    };
  };

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
    pidgin
    qutebrowser
    ripcord
    signal-desktop
    tdesktop
    thunderbird-bin
    tor-browser-bundle-bin
    transmission_gtk
    unstable.discord

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
    dracula-theme
    dunst
    exfat
    exfatprogs
    flameshot
    fuse
    fuse3
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
    pcmanfm
    picom
    ripgrep
    sxiv
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
    nmap
    protonvpn-cli
    veracrypt
    wireshark

    # Virtualization
    docker
    qemu
    qemu-utils

    # Libs
    glibc
    libopus
    libsForQt5.full
    libsForQt5.qtstyleplugins
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
    zstd

    # Others GNU tools
    autoconf
    automake
    bc
    binutils
    bison
    file
    findutils
    gawk
    gettext
    gnufdisk
    gnum4
    gnupatch
    gnused
    libtool
    mc
    pkgconf
    texinfo
    which

  ];

  # Allow ffmpeg installation.
  nixpkgs.config.permittedInsecurePackages = [ "ffmpeg-3.4.8" ];

  # Enable VirtualBox.
  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  # users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  # Enable the Android Debug Bridge.
  programs.adb.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = false;
    permitRootLogin = "no";
    ports = [ 2222 ];
    extraConfig = ''
      MaxAuthTries 2
    '';
  };

  # Enable Docker.
  virtualisation.docker.enable = false;
 
  # Enable MPD.
  # services.mpd = {
  #   enable = true;
  #   extraConfig = ''
  #   audio_output {
  #     type "pulse" # MPD must use Pulseaudio
  #     name "PulseAudio" # Whatever you want
  #     server "127.0.0.1" # MPD must connect to the local sound server
  #    }
  #  '';
  # };
  # programs.ncmpcpp.enable = true;

  # Enable fstrim.
  services.fstrim.enable = true;

  # Enable the firewall.
  networking.firewall.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 2222 ];
  networking.firewall.allowedUDPPorts = [ 2222 ];
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}
