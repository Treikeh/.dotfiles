# Don't forget to rename this file to flake.nix
# Can't use the rustup crate because i get an error that the 'cc' linker failed because the rustup/nix-support/ld-wrapper.sh wasn't found
# 
{
  description = "Godot Rust flake";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.x86_64-linux.default = pkgs.mkShell rec {
        nativeBuildInputs = with pkgs; [
          rustc
          cargo
          gcc
        ];
        buildInputs = with pkgs; [
          rustfmt
          clippy
          rust-analyzer
        ];
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
        RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
      };
    };
}