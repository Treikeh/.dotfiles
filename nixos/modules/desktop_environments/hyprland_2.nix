{ config, lib, pkgs, ... }:

{
  imports =
  [
    #../yazi.nix
  ];
  
  # Enable hypr stuff
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true; # Can't launch hyprland with uwsm while using ly
    xwayland.enable = true;
  };


  # Install additional packages
  environment.systemPackages = with pkgs; [
    foot          # Terminal
    kitty
    rofi          # App launcher
    btop          # System monitor
    kew           # Music player
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

    wayle         # Top bar
    awww          # Wallpaper service (Necessary for wayle wallpaper module)
    hypridle      # Idle service
    hyprlock      # Lock service

    nautilus      # GUI file manager
  ];

  # Device and drive mounting services/tools (Necessary for nautilus drive mounting)
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Battery configuration service (Necessary for wayle battery module)
  services.upower.enable = true;

  # Hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
