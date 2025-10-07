{ config, lib, pkgs, ... }:

{
  # Enable Asusd and supergfxd
  services = {
    asusd = {
      enable = lib.mkDefault true;
      enableUserService = lib.mkDefault true;
    };
    supergfxd.enable = lib.mkDefault true;
  };
  

  # Install additional packages
  environment.systemPackages = with pkgs; [
    supergfxctl-plasmoid
  ];
  
  # Exclude unwanted packages
  environment.gnome.excludePackages = with pkgs; [
    #
  ];
}
