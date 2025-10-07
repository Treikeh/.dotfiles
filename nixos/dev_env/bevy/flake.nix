{
  description = "Bevy flake";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.x86_64-linux.default = pkgs.mkShell rec {
        #nativeBuildInputs = [
        #  pkg-config
        #  rustup
        #  gcc
        #];
        buildInputs = with pkgs; [
          rustup
          rust-analyzer
          pkg-config
          llvmPackages.bintools
          udev
          gcc
          clang
          mold-wrapped
          alsa-lib-with-plugins
          vulkan-loader
          xorg.libX11
          xorg.libXcursor
          xorg.libXi
          xorg.libXrandr # To use the x11 feature
          libxkbcommon wayland # To use the wayland feature
        ];
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
        RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
      };
    };
}