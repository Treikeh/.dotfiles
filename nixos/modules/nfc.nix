# This file was taken from the nixos-harware repo: https://github.com/NixOS/nixos-hardware/tree/master
{ config, pkgs, lib, ... }:

{
  # https://wiki.archlinux.org/title/NFC
  environment.systemPackages = with pkgs; [
    ccid
    acsccid
    #libnfc # Not working as expected
    pcsclite
    pcsc-tools
  ];

  # Daemon service to make readers work
  services.pcscd.enable = true;

  #services.neard.enable = true;
}


# Command to blacklist necessary drivers
#printf 'blacklist pn533\nblacklist pn533_usb\nblacklist nfc\n' | sudo tee /etc/modprobe.d/blacklist-pn533.conf
# Rmove blacklist
# sudo rm /etc/modprobe.d/blacklist-pn533.conf
