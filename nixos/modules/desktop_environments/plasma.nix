{ config, pkgs, ... }:

{
  # Enable the KDE Plasma Desktop environment
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
