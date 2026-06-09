{ config, lib, pkgs, pkgs-unstable, ... }:

{
  # Display manager
  services.displayManager.ly.enable = true;

  # Enable niri
  programs.niri.enable = true;
  systemd.user.services.niri.enableDefaultPath = false;

  security.polkit.enable = true;              # polkit
  services.gnome.gnome-keyring.enable = true; # secret service
  security.pam.services.swaylock = {};

  # To get the wayle battery module working
  services.upower.enable = true;

  # Install additional packages
  environment.systemPackages = with pkgs; [
    ghostty       # Terminal
    rofi          # App launcher

    wayle         # Shell stuff (Top bar, Wifi, Bluetooth, Notifications)
    awww          # For wallpapers

    #yazi          # File manager
    btop          # System monitor
    kew           # Music player
    wiremix       # Audio manager
    #impala       # Wifi manager
    #bluetui      # Bluetooth manager

    # Utility tools
    playerctl     # Music control
    brightnessctl # Screen brigthness control
    wl-mirror     # Screen mirroring tool
    wl-clipboard  # Wayland clipboard
    cliphist      # Wayland clipboard
    trash-cli     # Tool to manage the file trash

    hypridle      # Idle service
    hyprlock      # Lock service

    nautilus
    pkgs-unstable.xwayland-satellite
  ];

  # Yazi file manager
  programs.yazi = {
    enable = true;
    plugins = {
      inherit (pkgs.yaziPlugins) mount;
      inherit (pkgs.yaziPlugins) wl-clipboard;
    };
    settings = {
      keymap = lib.importTOML ../../../.config/yazi/keymap.toml;
    };
  };

  services.gvfs.enable = true;
  # Mount tool
  services.udisks2.enable = true;

  # Optional, hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
