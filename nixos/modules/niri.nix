{ config, pkgs, pkgs-unstable, ... }:

{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  programs.niri.enable = true;


  # Install additional packages
  environment.systemPackages = with pkgs; [
    mako
    cliphist
    brightnessctl
    pavucontrol
    playerctl
    wl-clipboard
    pamixer
    file-roller

    alacritty
    fuzzel
    eww
    hyprpaper
    hypridle
    hyprlock
    #swayidle
    #swaylock
    networkmanagerapplet

    imv

    ianny
    yazi
    btop
    cava

    xwayland-satellite
    kdePackages.polkit-kde-agent-1

    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
  ];

  # Exclude unwanted packages
  environment.gnome.excludePackages = with pkgs; [
    #
  ];

  # Thunar stuff
  programs.xfconf.enable = true; # Enable saving thunar preferences
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  services.gvfs.enable = true;    # Something about making trash work with thunar
  services.tumbler.enable = true; # File thumbnails


  security.polkit.enable = true; # polkit
  services.gnome.gnome-keyring.enable = true; # secret service
  security.pam.services.swaylock = {};

  services.blueman.enable = true; 

  services.pipewire.wireplumber.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    configPackages = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = "gtk";
  };

  # Optional, hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
