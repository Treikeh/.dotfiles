# Shell to allow you to start developing with opengl in c++ while using cmake
# Have to use gcc with cmake, because for some reason it doesn't work with clang. Something about -lgcc and crtbeginS.o not being found
# Remember to rename this file to "shell.nix"

{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell rec {
  buildInputs = [
    pkg-config
    
    # Dev tools
    gcc # Not actually necessary since it's automatically added when using the nix-shell command
    gdb
    cmake

    # Libs
    glfw
    libGL


    # To use x11
    #xorg.xorgproto # Not sure what this does, but it might be usefull to have
    #xorg.libX11
    #xorg.libXcursor
    #xorg.libXi
    #xorg.libXrandr

    # To use wayland
    libxkbcommon
    wayland
  ];
  LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;
}