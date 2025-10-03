# This file was taken from the nixos-harware repo: https://github.com/NixOS/nixos-hardware/tree/master
{ config, lib, ... }:

{
  #imports = [ ../24.05-compat.nix ];

  # Load video drivers for Xorg and Wayland
  services.xserver.videoDrivers = lib.mkDefault [ "modesetting" ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Enable OpenGL
  hardware.graphics = {
      enable = lib.mkDefault true;
      enable32Bit = lib.mkDefault true;
  };

  hardware.amdgpu.initrd.enable = lib.mkDefault true;
}
