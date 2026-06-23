{ config, lib, pkgs, ... }:

{
  imports =
  [ # Include the results of the hardware scan.
    ../yazi.nix
  ];
  
  # Enable niri
  programs.niri.enable = true;
  systemd.user.services.niri.enableDefaultPath = false;

  # Security
  security.polkit.enable = true;              # polkit
  services.gnome.gnome-keyring.enable = true; # secret service
  security.pam.services.swaylock = {};

  # Install additional packages
  environment.systemPackages = with pkgs; [
    foot          # Terminal
    rofi          # App launcher
    btop          # System monitor
    kew           # Music player
    wiremix       # Audio manager
    #impala       # Wifi manager
    bluetui       # Bluetooth manager

    playerctl     # Music control
    brightnessctl # Screen brigthness control
    wl-mirror     # Screen mirroring tool
    wl-clipboard  # Wayland clipboard
    cliphist      # Wayland clipboard
    trash-cli     # Tool to manage the file trash can

    wayle         # Top bar
    awww          # Wallpaper service (Necessary for wayle wallpaper module)
    hypridle      # Idle service
    hyprlock      # Lock service

    nautilus      # GUI file manager
    xwayland-satellite
  ];

  # Device and drive mounting services/tools (Necessary for nautilus drive mounting)
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Battery configuration service (Necessary for wayle battery module)
  services.upower.enable = true;

  # Hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
