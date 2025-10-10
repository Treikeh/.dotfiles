# A simple shell to allow you to start development with c/c++ while using cmake
# Have to use gcc with cmake, because for some reason it doesn't work with clang. Something about -lgcc and crtbeginS.o not being found
# Remember to rename this file to "shell.nix"

{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell rec {
  buildInputs = [
    gcc # Not actually necessary since it's automatically added when using the nix-shell command
    
    pkg-config
    cmake
    gdb
  ];
  LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;
}