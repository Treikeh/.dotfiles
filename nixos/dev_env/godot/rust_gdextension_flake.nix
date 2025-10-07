# Can't use the rustup crate because i get an error that the 'cc' linker failed because the rustup/nix-support/ld-wrapper.sh wasn't found
{
  description = "Godot Rust flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    naersk = {
      url = "github:nix-community/naersk";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, utils, fenix, naersk, ... }: 
    utils.lib.eachDefaultSystem (system: {
      packages.default = 
        let
          pkgs = nixpkgs.legacyPackages.${system};
          target = "x86_64-pc-windows-gnu";
          #target = "x86_64-unknown-linux-gnu";
          toolchain = with fenix.packages.${system}; combine [
            minimal.cargo
            minimal.rustc
            targets.${target}.latest.rust-std
          ];
        in
        (naersk.lib.${system}.override {
          cargo = toolchain;
          rustc = toolchain;
        }).buildPackage {
          src = ./.;
          CARGO_BUID_TARGET = target;
        };
    });
  #outputs = { self, nixpkgs, utils, fenix, ... }: 
  #  utils.lib.eachDefaultSystem (system:
  #    let
  #      pkgs = import nixpkgs { inherit system; };
  #    in
  #    {
  #      devShells.default = pkgs.mkShell {
  #        nativeBuildInputs =
  #          [
  #            fenix.packages.${system}.default.toolchain
  #          ];
  #      };
  #    }
  #  );
    
    #let
    #  system = "x86_64-linux";
    #  pkgs = import nixpkgs { inherit system; };
    #  rust-toolchain = pkgs.pkgsBuildHost.rust-bin.stable.latest.default.override {
    #    targets = ["x86_64-pc-windows-gnu"];
    #  };
    #in {
    #  devShells.x86_64-linux.default = pkgs.mkShell rec {
    #    nativeBuildInputs = with pkgs; [
    #      rust-toolchain
    #      rustc
    #      cargo
    #      gcc
    #    ];
    #    buildInputs = with pkgs; [
    #      windows.pthreads
    #      rustfmt
    #      clippy
    #      rust-analyzer
    #    ];
    #    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
    #    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    #  };
    #};
}