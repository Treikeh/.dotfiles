{ config, pkgs, ... }:

{
  # Install additional packages
  environment.systemPackages = with pkgs; [
    unityhub
    dotnet-sdk
    python315 # For web builds
  ];
}