# NixOS 23.05 config - 1ukidev

{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
in

{
  imports = [ 
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Include the packages that will be installed.
    ./packages.nix
    # Include home-manager.
    (import "${home-manager}/nixos")
  ];

  # Enable unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Allow "wheel" on nix.
  nix.settings = {
    allowed-users = [ "@wheel" ];
    trusted-users = [ "@wheel" ];
  };
  
  # Allow experimental features on nix.
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = lib.optionalString (config.nix.package == pkgs.nixFlakes)
      "experimental-features = nix-command flakes";
  };

  # Use zen kernel.
  boot.kernelPackages = pkgs.linuxPackages_zen;
  
  # Define mount options (only Btrfs).
  fileSystems."/" = {
    options = [ "subvol=@" "noatime" "space_cache=v2" "autodefrag" "discard=async" "compress=zstd" ];
  };

  fileSystems."/home" = {
    options = [ "subvol=@home" "noatime" "space_cache=v2" "autodefrag" "discard=async" "compress=zstd" ];
  };

  fileSystems."/nix" = {
    options = [ "subvol=@nix" "noatime" "space_cache=v2" "autodefrag" "discard=async" "compress=zstd" ];
  };

  fileSystems."/var" = {
    options = [ "subvol=@var" "noatime" "space_cache=v2" "autodefrag" "discard=async" "compress=zstd" ];
  };

  fileSystems."/tmp" = { 
    options = [ "subvol=@tmp" "noatime" "space_cache=v2" "autodefrag" "discard=async" "compress=zstd" ];
  };
  
  # If set, NixOS will enforce the immutability of the Nix store
  # by making /nix/store a read-only bind mount.
  # Nix will automatically make the store writable when needed.
  # I leave it disabled only initially, due to Btrfs compression.
  nix.readOnlyStore = false;

  # Set CPU frequency.
  powerManagement = {
    enable = true;
    powertop.enable = false;
    cpuFreqGovernor = "performance";
  };
  
  services.tlp = {
    enable = false;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "performance";
      CPU_SCALING_MIN_FREQ_ON_AC = 4100000;
      CPU_SCALING_MAX_FREQ_ON_AC = 4100000;
      CPU_SCALING_MIN_FREQ_ON_BAT = 4100000;
      CPU_SCALING_MAX_FREQ_ON_BAT = 4100000;
    };
  };
  
  #boot.kernelParams = [ "intel_pstate=disable" ];
  
  # Use systemd-boot.
  boot.loader = {
    timeout = 1;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    
    systemd-boot = {
      enable = true;
    };
  };

  networking.hostName = "256G8"; # Define your hostname.
  networking.wireless.enable = false; # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Enable NetworkManager.

  # Define DNS.
  #networking.networkmanager.insertNameservers = [ "1.1.1.1" "1.0.0.1" ];
  #networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];

  # Set your time zone.
  time.timeZone = "America/Fortaleza";

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

  # Enable GDM and GNOME.
  services.xserver = {
    enable = true;
    displayManager = {
      sddm.enable = true;
    };
	
    desktopManager = {
      plasma5.enable = true;
    };
  };

  programs.dconf.enable = true;

  # Set environment.
  environment.variables = { EDITOR = "emacs"; };

  # Enable qt5ct.
  # programs.qt5ct.enable = true;

  # Set keymap in X11.
  services.xserver.layout = "br";

  # Enable drivers in X11.
  services.xserver.videoDrivers = [ "modesetting" ];
  # services.xserver.useGlamor = true;
  services.xserver.libinput.enable = true;
  
  # Enable support for Intel hybrid codec.
  # nixpkgs.config.packageOverrides = pkgs: {
  #   vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  # };

  # Enable OpenGL and accelerated video playback.
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      libva
      libva-utils
      intel-media-driver
    ];
  };

  # Update Intel microcode.
  hardware.cpu.intel.updateMicrocode = true;

  # Enable print support.
  services.printing.enable = false;
  services.printing.drivers = [ pkgs.epson-escpr ];
  hardware.sane.enable = false;
  hardware.sane.extraBackends = [ pkgs.utsushi ];

  # Enable Bluetooth support.
  hardware.bluetooth.enable = true;
  # services.blueman.enable = true;

  # Enable sound and PulseAudio.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
    # Reduce microphone noise.
    extraConfig = ''
      load-module module-echo-cancel aec_args="analog_gain_control=0 digital_gain_control=0" source_name=noiseless
      set-default-source noiseless
    '';
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.luki = {
    isNormalUser = true;
    description = "Leonardo Monteiro";
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "fuse" "scanner" "lp" "libvirtd" "kvm" ];
    shell = pkgs.zsh;
  };
  
  security.sudo.extraConfig = ''
    Defaults pwfeedback
  '';

  # Configure zsh.
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
    };

    promptInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    '';

    shellAliases = {
      sysrs = "sudo nixos-rebuild switch";
      sysup = "sudo nixos-rebuild switch --upgrade";
      sysrsgit = "sysrs -I nixpkgs=/home/$USER/nixpkgs";
      sysupgit = "sysup -I nixpkgs=/home/$USER/nixpkgs";
      sysclean = "sudo nix-collect-garbage -d; sudo nix-store --optimise";
      homers = "home-manager switch";
      search = "nix search";
      nixconfig = "sudo nvim /etc/nixos/configuration.nix";
      lgit = "git add .; git commit; git push";
      lgitf = "git add .; git commit; git pull; git push";
      ga = "git add .";
      gp = "git pull";
      ls = "exa --icons";
      sl = "exa --icons";
      ll = "exa -l --icons";
      l = "exa -a --icons";
      la = "exa -la --icons";
      grep = "rg";
      cgrep = "/run/current-system/sw/bin/grep";
      rmf = "sudo rm -rf";
      cp = "cp -i";
      cat = "bat --theme Dracula";
      less = "bat --theme Dracula";
      e = "emacs -nw";
      de = "distrobox-enter";
      ds = "distrobox-stop";
      docker = "podman";
    };
  };

  # Change root shell.
  users.users.root = { shell = pkgs.zsh; };

  # Install fonts.
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    dejavu_fonts
    corefonts
    source-han-sans
    source-han-serif
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
        "Noto Sans Display"
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

  # Allow ffmpeg installation.
  nixpkgs.config.permittedInsecurePackages = [ "ffmpeg-4.4.1" "qtwebkit-5.212.0-alpha4" ];

  # Enable VirtualBox and libvird.
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
  virtualisation.libvirtd.enable = false;
 
  # Enable podman
  virtualisation.podman.enable = true;

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
      MaxAuthTries 3
      MaxSessions 3
    '';
  };

  # Enable the firewall.
  networking.firewall.enable = true;
  networking.firewall.checkReversePath = "loose";

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 2222 631 41641 ];
  networking.firewall.allowedUDPPorts = [ 2222 631 41641 ];
  
  # Others services.
  services = {
    udisks2.enable = true;
    upower.enable = true;
    cron.enable = true;
    syncthing = {
      enable = true;
      user = "luki";
      dataDir = "/home/luki";
      openDefaultPorts = true;
    };
    tailscale.enable = true;
    nginx.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
