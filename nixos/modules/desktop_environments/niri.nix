{ config, lib, pkgs, ... }:

{
  imports =
  [
    #../yazi.nix
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
    fsel          # Terminal app launcher
    btop          # System monitor
    kew           # Music player
    cliamp        # Music player
    wiremix       # Audio manager
    impala        # Wifi manager
    bluetui       # Bluetooth manager
    superfile     # Terminal file manager

    playerctl     # Music control
    brightnessctl # Screen brigthness control
    wl-mirror     # Screen mirroring tool
    wl-clipboard  # Wayland clipboard
    cliphist      # Wayland clipboard
    trash-cli     # Tool to manage the file trash can
    # lf            # Terminal file manager
    # chafa         # Image preview tool, needed for image previews in lf
    # file          # Don't know what it is, but it is needed in order to get image previews with chafa in lf

    wayle         # Top bar
    awww          # Wallpaper service (Necessary for wayle wallpaper module)
    quickshell    # Desktop shell toolkit
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
