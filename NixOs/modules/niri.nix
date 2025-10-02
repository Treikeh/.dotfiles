{ config, pkgs, ... }:

{
  services.displayManager.ly.enable = true;
  #services.displayManager.lemurs.enable = true; # Have to wait until NixOs channel 25.11 is released

  programs.niri.enable = true;


  # Install additional packages
  environment.systemPackages = with pkgs; [
    mako
    #cliphist
    brightnessctl
    pavucontrol
    playerctl
    #wl-clipboard
    pamixer
    #lm_sensors

    alacritty
    fuzzel
    eww
    swaybg
    swayidle
    swaylock
    networkmanagerapplet

    #imv
    #grim
    #slurp

    #ianny
    #yazi
    #btop
    #cava

    xwayland-satellite
    kdePackages.polkit-kde-agent-1
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


  services.blueman.enable = true; 

  services.pipewire.wireplumber.enable = true;

  # Optional, hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
