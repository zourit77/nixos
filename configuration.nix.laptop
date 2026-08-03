{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;

  programs.gamemode.enable = true;
  services.gnome.gnome-remote-desktop.enable = false;

  boot.kernelParams = [ "quiet" "splash" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot.plymouth.enable = true;
  boot.plymouth.theme = "spinner";

  services.flatpak.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Pour PRIME offload NVIDIA sous NixOS, garde seulement nvidia ici.
  services.xserver.videoDrivers = [ "nvidia" ];

  # Si tu as des soucis avec linuxPackages_latest, repasse sur pkgs.linuxPackages.
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_zen;
  
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    powerManagement.enable = true;
    powerManagement.finegrained = true;
    
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      # IMPORTANT :
      # Remplace par les vraies valeurs au format NixOS :
      # PCI:<bus>@<domain>:<device>:<function>
      #
      # Exemple si lspci donne :
      # 0000:05:00.0 -> PCI:5@0:0:0
      # 0000:01:00.0 -> PCI:1@0:0:0
      #
      # Vérifie bien avec :
      # lspci | grep -E "VGA|3D"
      amdgpuBusId = "PCI:5@0:0:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };
  };

  
  services.gvfs.enable = true;
  networking.hostName = "proprod";
  networking.networkmanager.enable = true;
  networking.firewall.allowedUDPPorts = [ 5353 ];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

 
  

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "fr_FR.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  console.keyMap = "fr";

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
 
  boot.kernel.sysctl = {
   "vm.max_map_count" = 1048576;
    };
 
  users.users.tux = {
    isNormalUser = true;
    description = "tux";
    extraGroups = [ "networkmanager" "wheel" "libvirtd"];
    packages = with pkgs; [
      plymouth
      adi1090x-plymouth-themes
      plymouth-proxzima-theme
      plymouth-matrix-theme
      mesa-demos
      brave
      parabolic
      photoflare
      steam
      heroic
      libreoffice-fresh
      thunderbird
      shortwave
      wireguard-tools
      jellyfin
      vlc
      ffmpeg
      audacity
      ardour
      mixxx
      htop
      btop
      #nvtopPackages.nvidia
      curl
      wget
      gamemode
      git
      anydesk
      gparted
      nextcloud-client
      flatpak
      docker
      docker-compose
      vscodium
      rpi-imager
      joplin-desktop
      transmission_4
      discord
      proton-vpn
      protonup-qt
      syncthing
      zoom-us
      bazaar
      gnome.gvfs
      samba
      smbclient-ng
      avahi
      wakeonlan
      github-desktop
      libnotify
      ocs-url
      telegram-desktop
      gnome-tweaks
      whitesur-gtk-theme
      whitesur-cursors
      whitesur-icon-theme
      gnomeExtensions.dash-to-dock
      gnomeExtensions.blur-my-shell
      gnomeExtensions.coverflow-alt-tab
      gnomeExtensions.freon
      gnomeExtensions.appindicator
      gnomeExtensions.desktop-icons-ng-ding
      gnomeExtensions.clipboard-history
      gnomeExtensions.hide-activities-button
      gnomeExtensions.weatherpanel
      gnomeExtensions.wallpaper-slideshow
      gnomeExtensions.ip-finder
      gnomeExtensions.gamemode-shell-extension
      gnomeExtensions.user-themes
    ];
  };

  programs.firefox.enable = false;
  
  environment.gnome.excludePackages = with pkgs; [
  epiphany
  yelp
  gnome-tour
  gnome-software
  ];
  
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    dates = "14:00";
    randomizedDelaySec = "45min";
    flags = [ "--print-build-logs" ];
  };
  
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.settings.auto-optimise-store = true;

  nix.optimise = {
    automatic = true;
    dates = [ "16:00" ];
  };
  
  environment.systemPackages = with pkgs; [
    vim
    pciutils
    qemu
    virt-manager
    virt-viewer
  ];
  
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  system.stateVersion = "26.05";
}
