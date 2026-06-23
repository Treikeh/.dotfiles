# This file was taken from the nixos-harware repo: https://github.com/NixOS/nixos-hardware/tree/master
{ config, lib, ... }:

{
  # Load nvidia driver for Xorg and Wayland

  # Load video drivers for Xorg and Wayland.
  services.xserver.videoDrivers = lib.mkOverride 990 [ "modesetting" "nvidia" ];

  # Enable OpenGL
  hardware.graphics = {
      enable = lib.mkDefault true;
      enable32Bit = lib.mkDefault true;
  };

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = lib.mkDefault true;

    # Enable prime
    prime = {
      offload = {
        enable = lib.mkOverride 990 true;
        enableOffloadCmd = lib.mkIf config.hardware.nvidia.prime.offload.enable true; # Provides `nvidia-offload` command.
      };
      # Make sure to use the correct Bus ID values for your system!
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:66:0:0"; # For AMD GPU
    };

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = true;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = lib.mkDefault true;
    #open = lib.mkDefault 990 (nvidiaPackage ? open && nvidiaPackage ? firmware);

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = lib.mkDefault true;

    # Disable dynamic boost
    dynamicBoost.enable = lib.mkDefault false;
  };
}
