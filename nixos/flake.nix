# Learning resources
# https://www.youtube.com/watch?v=rEovNpg7J0M
# https://nixos-and-flakes.thiscute.world/nixos-with-flakes/downgrade-or-upgrade-packages
{
  description = "A very basic flake";

  inputs = {
    # Default channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    # Unstable channel
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
  }:
  let
    system = "x86_64-linux";

    #pkgs = import nixpkgs {
    #  inherit system;
    #  config.allowUnfree = true;
    #};

    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  
  in {
    nixosConfigurations = {
      # Name of config
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system;
          inherit pkgs-unstable;
        };
        # Modules
        modules = [
          ./hosts/laptop/configuration.nix
        ];
      };

      # Name of config
      server = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system;
          inherit pkgs-unstable;
        };
        # Modules
        modules = [
          ./hosts/server/configuration.nix
        ];
      };
    };
  };
}
