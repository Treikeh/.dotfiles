{ config, pkgs, ... }:

{
  #services.displayManager.ly.enable = true;
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;
  #services.displayManager.sddm.enable = true;
  #services.displayManager.sddm.wayland.enable = true;
  #services.displayManager.lemurs.enable = true; # Have to wait until NixOs channel 25.11 is released

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
    dunst
    cliphist
    pamixer
    pavucontrol
    playerctl
    brightnessctl
    wl-clipboard
    wl-mirror
    file-roller # Gnome zip and extract archives tool

    kitty
    fuzzel
    eww
    quickshell
    hyprpaper
    hyprpicker
    hyprcursor
    hyprsysteminfo
    hyprpolkitagent
    networkmanagerapplet

    imv

    # Screen shot tools
    grim
    slurp

    ianny
    yazi
    btop
    cava
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
    thunar-media-tags-plugin
  ];

  services.gvfs.enable = true;    # Something about making trash work with thunar
  services.tumbler.enable = true; # File thumbnails

  services.blueman.enable = true; 

  services.pipewire.wireplumber.enable = true;

  # Optional, hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
