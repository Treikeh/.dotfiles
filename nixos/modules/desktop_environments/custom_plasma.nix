{ config, pkgs, pkgs-unstable, ... }:

{
  # Enable the KDE Plasma Desktop environment
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Install additional packages
  environment.systemPackages = with pkgs; [
    kdePackages.kcalc
    kdePackages.filelight
    kdePackages.partitionmanager

    # App launcher
    pkgs-unstable.fuzzel

    # Kwin scripts
    kdePackages.dynamic-workspaces

    kdePackages.kdialog
    kdePackages.isoimagewriter
  ];

  # Exclude unwanted packages
  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.kate
    kdePackages.kwrited
    kdePackages.okular
    kdePackages.elisa
  ];
}
