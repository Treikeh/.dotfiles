# This file was taken from the nixos-harware repo: https://github.com/NixOS/nixos-hardware/tree/master
{ config, lib, ... }:

{
  # https://wiki.archlinux.org/title/NFC
  environment.systemPackages = with pkgs; [
    ccid
    acsccid
    libnfc
    pcsc-tools
    pcsclite
  ];
}
