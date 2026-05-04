# A shell that allows you to develop with macroquad
# This shell assumes that you allready have rustup installed on your system

{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell rec {
  buildInputs = [
    rust-analyzer
    pkg-config
    #udev

    #llvmPackages.bintools
    libGL

    alsa-lib-with-plugins
    #vulkan-loader
    xorg.libX11
    #xorg.libXcursor
    xorg.libXi
    #xorg.libXrandr # To use the x11 feature
    #wayland
    libxkbcommon 
    pkgsCross.mingwW64.stdenv.cc
    pkgsCross.mingwW64.windows.pthreads
    #pkgsCross.mingwW64.buildPackages.gcc
  ];
  LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;
  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  shellHook = ''
    codium .
  '';
}