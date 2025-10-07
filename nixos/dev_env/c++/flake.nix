{
  description = "c++ flake";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.x86_64-linux.default = pkgs.mkShell.override { stdenv = pkgs.gcc13Stdenv; } rec {
        packages = with pkgs; [
          gdb
          gcc
        ];
        buildInputs = with pkgs; [
          #
        ];
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
      };
    };
}