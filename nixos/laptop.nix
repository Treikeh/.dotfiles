# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, pkgs-unstable, ... }:

# Taken from: https://github.com/ARKye03/Xe_NixOS/blob/trunk/configuration.nix
# Somehow allows vscodium to use the dotnet-sdk
let
  dotnet-combined = (with pkgs.dotnetCorePackages; combinePackages [
    sdk_8_0
  ]).overrideAttrs (finalAttrs: previousAttrs: {
    # This is needed to install workload in $HOME
    # https://discourse.nixos.org/t/dotnet-maui-workload/20370/2

    postBuild = (previousAttrs.postBuild or '''') + ''
      for i in $out/sdk/*
      do
        i=$(basename $i)
        length=$(printf "%s" "$i" | wc -c)
        substring=$(printf "%s" "$i" | cut -c 1-$(expr $length - 2))
        i="$substring""00"
        mkdir -p $out/metadata/workloads/''${i/-*}
        touch $out/metadata/workloads/''${i/-*}/userlocal
      done
    '';
  });
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/asus.nix
      ./modules/amd.nix
      ./modules/nvidia.nix

      ./modules/plasma_de.nix
      #./modules/hyprland.nix
      #./modules/niri.nix
      #./modules/gnome_de.nix
      #./modules/cosmic_de.nix

      ./modules/nfc.nix
    ];
  
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Allow unfree packages. Would prefer to have this in the flake. Similar to what i have with the pkgs-unstable
  #nixpkgs.config.allowUnfree = true;


  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;


  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;


  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nb_NO.UTF-8";
    LC_IDENTIFICATION = "nb_NO.UTF-8";
    LC_MEASUREMENT = "nb_NO.UTF-8";
    LC_MONETARY = "nb_NO.UTF-8";
    LC_NAME = "nb_NO.UTF-8";
    LC_NUMERIC = "nb_NO.UTF-8";
    LC_PAPER = "nb_NO.UTF-8";
    LC_TELEPHONE = "nb_NO.UTF-8";
    LC_TIME = "nb_NO.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "no";

  # Enable japanese inputs
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-mozc
        #fcitx5-gtk
        kdePackages.fcitx5-qt
      ];
    };
  };
  services.xserver.desktopManager.runXdgAutostartIfNone = true;


  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "no";
    variant = "nodeadkeys";
  };


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable autodiscovery of network printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };


  # Enable fstrim
  services.fstrim.enable = lib.mkDefault true;

  # Laptop power management
  # Gnome 40 introduced a new way of managing power, without tlp.
  # However, these 2 services clash when enabled simultaneously.
  # https://github.com/NixOS/nixos-hardware/issues/260
  services.tlp = {
    enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "powersave";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_BOOST_ON_AC = 0;
        CPU_BOOST_ON_BAT = 0;


        # Max pref as
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 80;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

        # 5200000 MAX (with cpu boost)
        # 400000 MIN
        CPU_SCALING_MIN_FREQ_ON_AC = 400000;
        CPU_SCALING_MAX_FREQ_ON_AC = 4000000;

        CPU_SCALING_MIN_FREQ_ON_BAT = 400000;
        CPU_SCALING_MAX_FREQ_ON_BAT = 2000000;

        #Optional helps save long term battery health
        START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
        STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
      };
  };

  services.power-profiles-daemon.enable = false;
  #services.tlp.enable = lib.mkDefault ((lib.versionOlder (lib.versions.majorMinor lib.version) "21.05") || !config.services.power-profiles-daemon.enable);


  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.treikeh = {
    isNormalUser = true;
    description = "Treikeh";
    extraGroups = [ "networkmanager" "wheel" "input" "seat"];
    packages = with pkgs; [
      #
    ];
  };


  environment = {
    variables = {
      EDITOR = "codium";
      SYSTEMD_EDITOR = "codium";
      VISUAL = "codium";
    };

    # Taken from: https://github.com/ARKye03/Xe_NixOS/blob/trunk/configuration.nix
    sessionVariables = {
      #NIXOS_OZONE_WL = "1";
      DOTNET_ROOT = "${dotnet-combined}";
      #LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    };

    # Aliases
    shellAliases = {
      update-flake-boot = "sudo nixos-rebuild boot --flake ~/.dotfiles/nixos/#laptop";
      update-flake-switch = "sudo nixos-rebuild switch --flake ~/.dotfiles/nixos/#laptop";
      delete-free = "sudo nix-collect-garbage -d";
      delete-old = "sudo nix-collect-garbage --delete-older-than 14d";
    };
  };

  # Enable flatpak
  services.flatpak.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    lshw
    stow
    ffmpeg-full
    lm_sensors
    
    # Stuff for bevy
    pkgs-unstable.rustup

    vlc
    p7zip
    zip
    unrar
    wine
    #bottles # This version has a warning about sandboxing so use flatpak version instead
    steam-run
    #protontricks # This version had issues when trying to download vcrun for a game, but the flatpak version worked

    pkgs-unstable.librewolf
    pkgs-unstable.vscodium-fhs
    obsidian
    obs-studio
    libreoffice
    pkgs-unstable.protonvpn-gui

    pkgs-unstable.gimp
    pkgs-unstable.krita
    pkgs-unstable.inkscape
    pkgs-unstable.lmms
    pkgs-unstable.audacity
    pkgs-unstable.furnace
    pkgs-unstable.famistudio
    pkgs-unstable.ardour
    pkgs-unstable.blockbench
    pkgs-unstable.fontforge

    pkgs-unstable.distrobox

    anki
    spotify
    discord
    heroic
    prismlauncher

    # Stuff i need for school
    pkgs-unstable.unityhub
    dotnet-combined # For unity
    python310 # For Unity web builds
  ];

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      ubuntu-classic
      unifont
      font-awesome
      roboto
    ];

    fontconfig = {
      antialias = true;
      defaultFonts = {
        serif = [ "Ubuntu" ];
        sansSerif = [ "Ubuntu" ];
        monospace = [ "Ubuntu Source" ];
      };
    };
  };

  # Remove nano
  programs.nano.enable = false;

  # LD fix (That doesn't work, at least not with udev, alsa-lib and wayland)
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    #
  ];

  # Enable Appimage
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.appimage.package = pkgs.appimage-run.override {
    extraPkgs = pkgs: [
      # missing libraries here, e.g.: `pkgs.libepoxy`
    ];
  };

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # To make distrobox work
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
