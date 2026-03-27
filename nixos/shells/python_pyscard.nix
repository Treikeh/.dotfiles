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