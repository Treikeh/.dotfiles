# A shell to allow you to develop a rust GDExtension for Godot
# This shell will allow you to compile to windows using the "cargo build --target=x86_64-pc-windows-gnu" command
# This shell assumes that you allready have rustup installed on your system and that you have added x86_64-pc-windows-gnu as a rustup target
# Remember to rename this file to "shell.nix"

{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
  buildInputs = [
    gcc # Not actually necessary since it's automatically added when using the nix-shell command

    # Packages needed to compile to windows
    pkgsCross.mingwW64.stdenv.cc
    pkgsCross.mingwW64.windows.pthreads
  ];
}