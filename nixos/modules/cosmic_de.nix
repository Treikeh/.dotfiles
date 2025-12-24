{ config, pkgs, ... }:

{
  # Enable the COSMIC login manager
  services.displayManager.cosmic-greeter.enable = true;

  # Enable the COSMIC desktop environment
  services.desktopManager.cosmic.enable = true;
  
  # Install additional packages
  environment.systemPackages = with pkgs; [
    #
  ];
  
  # Exclude unwanted packages
  environment.gnome.excludePackages = with pkgs; [
    #
  ];
}
