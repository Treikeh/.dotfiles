{ config, pkgs, ... }:

{
  services.displayManager.ly.enable = true;

  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;
  programs.hyprland.withUWSM = true;


  # Install additional packages
  environment.systemPackages = with pkgs; [
    kitty
    dunst # Notefication daemon
    waybar
    rofi
    cliphist
    hyprpaper

    qt6-wayland # Wayland support for QT windows
    networkmanagerapplet
  ];


  # Exclude unwanted packages
  environment.gnome.excludePackages = with pkgs; [
  ];


  services.pipewire.wireplumber.enable = true;

  # Optional, hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
