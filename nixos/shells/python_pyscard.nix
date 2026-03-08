# Shell to allow you to start developing with opengl in c++ while using cmake
# Have to use gcc with cmake, because for some reason it doesn't work with clang. Something about -lgcc and crtbeginS.o not being found
# Remember to rename this file to "shell.nix"

{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell rec {
    buildInputs = [
        python313
        python313Packages.pyscard
    ];
    LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;
}