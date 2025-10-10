# A shell that allows you to develop with bevy
# This shell assumes that you allready have rustup installed on your system
# Remember to rename this file to "shell.nix"

{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell rec {
  buildInputs = [
    gcc # Not actually necessary since it's automatically added when using the nix-shell command
    pkg-config
    rust-analyzer
    udev

    # For faster compiles, but i don't know if it works
    clang
    mold-wrapped
    llvmPackages.bintools

    alsa-lib-with-plugins
    vulkan-loader
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr # To use the x11 feature
    libxkbcommon wayland # To use the wayland feature
  ];
  LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;
  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
}