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
    kdePackages.kdialog
    kdePackages.isoimagewriter
  ];
}
