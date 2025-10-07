{ config, pkgs, ... }:

{
  # Enable the GNOME Desktop environment
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  # Install additional packages
  environment.systemPackages = with pkgs; [
    gnome-software
    
    gnomeExtensions.dash-to-dock
    gnomeExtensions.system-monitor
  ];
  
  # Exclude unwanted packages
  environment.gnome.excludePackages = with pkgs; [
    #
  ];
}
