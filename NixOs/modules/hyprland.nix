c{ config, pkgs, ... }:

{
  services.displayManager.ly.enable = true;

  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;
  
  #programs.uwsm.enable = true;
  #programs.hyprland.withUWSM = true;


  # Install additional packages
  environment.systemPackages = with pkgs; [
    dunst
    cliphist
    brightnessctl
    pavucontrol
    playerctl
    wl-clipboard

    kitty
    rofi
    waybar
    eww
    hyprpaper
    hyprpicker
    hyprcursor
    hyprsysteminfo

    networkmanagerapplet
    imv

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


  services.pipewire.wireplumber.enable = true;

  services.blueman.enable = true;

  programs.xfconf.enable = true; # Enable saving thunar preferences
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # Optional, hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
