# Learning resources
# https://www.youtube.com/watch?v=rEovNpg7J0M
# https://nixos-and-flakes.thiscute.world/nixos-with-flakes/downgrade-or-upgrade-packages
{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
  }:
  let
    user = "treikeh";
    system = "x86_64-linux";

    # Allow unfree in unstable pkgs
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    # Allow unfree in stable pkgs
    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      # Name of config
      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit pkgs;
        specialArgs = {
          inherit user;
          inherit pkgs-stable;
        };
        # Modules
        modules = [
          ./hosts/laptop/configuration.nix
        ];
      };

      # Name of config
      server = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit pkgs;
        specialArgs = {
          inherit user;
          inherit pkgs-stable;
        };
        # Modules
        modules = [
          ./hosts/server/configuration.nix
        ];
      };
    };
  };
}
