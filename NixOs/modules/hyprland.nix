{ config, pkgs, ... }:

{
  services.displayManager.ly.enable = true;
  #services.displayManager.lemurs.enable = true; # Have to wait until NixOs channel 25.11 is released

  # Enable hypr stuff
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;
  programs.hyprland = {
    enable = true;
    #withUWSM = true; # Can't launch hyprland with uwsm while using ly
    xwayland.enable = true;
  };


  # Install additional packages
  environment.systemPackages = with pkgs; [
    dunst
    cliphist
    brightnessctl
    pavucontrol
    playerctl
    wl-clipboard
    pamixer

    kitty
    rofi
    waybar
    eww
    hyprpaper
    hyprpicker
    hyprcursor
    hyprsysteminfo
    hyprpolkitagent

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


  # Thunar stuff
  programs.xfconf.enable = true; # Enable saving thunar preferences
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  services.gvfs.enable = true;    # ?
  services.tumbler.enable = true; # File thumbnails


  services.blueman.enable = true; 

  services.pipewire.wireplumber.enable = true;

  # Optional, hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
