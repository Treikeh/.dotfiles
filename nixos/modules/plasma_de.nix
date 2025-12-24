{ config, pkgs, pkgs-unstable, ... }:

{
  # Enable the KDE Plasma Desktop environment
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable kde connect
  programs.kdeconnect.enable = true;
  
  # Install additional packages
  environment.systemPackages = with pkgs; [
    kdePackages.kcalc
    kdePackages.filelight
    kdePackages.partitionmanager
    
    #pkgs-unstable.rofi
    pkgs-unstable.fuzzel
    
    #pkgs-unstable.kdePackages.krohnkite
    #pkgs-unstable.kdePackages.dynamic-workspaces
  ];
  
  # Exclude unwanted packages
  environment.gnome.excludePackages = with pkgs; [
    kdePackages.kate
    kdePackages.kwrited
    kdePackages.okular
  ];
}
