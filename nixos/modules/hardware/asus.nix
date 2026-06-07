{ config, lib, pkgs, ... }:

{
  # Enable Asusd and supergfxd
  services.asusd = {
      enable = true;
      #enableUserService = true;
  };
  services.supergfxd.enable = lib.mkDefault true;

  # Install additional packages
  environment.systemPackages = with pkgs; [
    supergfxctl-plasmoid
  ];
}
