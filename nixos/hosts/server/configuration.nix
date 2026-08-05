# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      ../../modules/yazi.nix
    ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos_server"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "no";
    variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "no";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.treikeh = {
    isNormalUser = true;
    description = "treikeh";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };

  # Autologin user
  services.getty.autologinUser = "treikeh";

  # Install firefox.
  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    #vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    evil-helix
    #wget

    btop

    docker-compose

    #jellyfin
    #jellyfin-web
    #jellyfin-ffmpeg
  ];

  environment = {
    variables = {
      EDITOR = "hx";
      SYSTEMD_EDITOR = "hx";
      VISUAL = "hx";
    };

    # Aliases
    shellAliases = {
      update-flake-boot = "sudo nixos-rebuild boot --flake ~/.dotfiles/nixos/#server";
      update-flake-switch = "sudo nixos-rebuild switch --flake ~/.dotfiles/nixos/#server";
      update-flake = "sudo nix flake update nixpkgs --flake ~/.dotfiles/nixos";
      delete-free = "sudo nix-collect-garbage -d";
      delete-old = "sudo nix-collect-garbage --delete-older-than 14d";
      vim = "hx";
    };
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable Tailscale
  services.tailscale.enable = true;
  # Fix tailscale exit nodes not working
  networking.firewall.checkReversePath = "loose";

  # Enable Docker
  virtualisation.docker.enable = true;

  # # Enable Pi-Hole
  # services.pihole-ftl = {
  #   enable = false;
  #   settings = {
  #     # Public Mullvad dns server
  #     dns.upstreams = ["194.242.2.2"];
  #     dns.listeningMode = "ALL";
  #   };
  # };

  # # Enable Pi-Hole web interface
  # services.pihole-web = {
  #   enable = false;
  #   ports = ["8002"];
  # };
  
  # Enable Uptime Kuma
  # services.uptime-kuma.enable = true;
  
  # Enable Syncthing
  # services.syncthing = {
  #   enable = true;
  #   openDefaultPorts = true;
  #   user = "treikeh";
  #   configDir = "/home/treikeh/.config/syncthing"
  #   settings = {
  #     devices = {
  #       "phone" = { id = "<DEVICE-ID"; };
  #     };
  #     folders = {
  #       "Syncthing" = {
  #         path = "/home/treikeh/Syncthing";
  #       };
  #     };
  #   };

  #   guiAddress = "0.0.0.0:8384";
  # };
  
  # Enable Jellyfin
  #services.jellyfin = {
  #  enable = true;
  #  openFirewall = true;
  #  user = "treikeh";
  #  dataDir = "/home/treikeh/Jellyfin/.data";
  #};

  # Enable Searxng
  #services.searx = {
  #  enable = true;
  #  environmentFile = "/home/treikeh/.searxng.env";
  #  redisCreateLocally = true;
  #  settings = {
  #    server = {
  #      port = 8080;
  #      bind_address = "0.0.0.0";
  #      secret_key = "$SEARX_SECRET_KEY";
  #    };
  #  };
  #};

  # Enable Vaultwarden
  #services.vaultwarden = {
  #  enable = true;
  #  backupDir = "/home/treikeh/Vaultwarden/backup";
  #  environmentFile = "/home/treikeh/.vaultwarden.env";
  #  config = {
  #    
  #  }
  #}

  # Allow the server to be active when the lid is closed (if the server is a laptop) 
  services.logind.settings.Login.HandleLidSwitch = "ignore";

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
  system.stateVersion = "25.11"; # Did you read the comment?
}
