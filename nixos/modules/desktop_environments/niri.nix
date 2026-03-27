{ config, pkgs, pkgs-unstable, ... }:

{
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;
  #services.displayManager.sddm.enable = true;
  #services.displayManager.sddm.wayland.enable = true;
  #services.displayManager.ly.enable = true;

  programs.niri.enable = true;


  # Install additional packages
  environment.systemPackages = with pkgs; [
    mako # Notification daemon
    cliphist # Clipboard tool
    pamixer # Audio thing
    pavucontrol # Audio control panel
    playerctl # Music control
    brightnessctl # Brightness control
    wl-clipboard # Also clipboard tool, both are needed
    wl-mirror # Screen share
    file-roller # Gnome zip and extract archives tool

    alacritty
    fuzzel
    eww
    hyprpaper
    hypridle
    hyprlock
    networkmanagerapplet

    imv # Image view

    ianny # Break remainder
    yazi
    btop
    cava

    pkgs-unstable.xwayland-satellite

    polkit_gnome
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
  ];

  # Exclude unwanted gnome packages
  #environment.gnome.excludePackages = with pkgs; [
  #  #
  #];

  # Thunar stuff
  programs.xfconf.enable = true; # Enable saving thunar preferences
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-volman # To see volumes
    thunar-archive-plugin # To be able to extract and archive archive (zip, rar) files
    thunar-media-tags-plugin
  ];

  services.gvfs.enable = true;    # Something about making trash work with thunar
  services.udisks2.enable = true;
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
    #config.common.default = "kde";
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };
  };

  # Optional, hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
