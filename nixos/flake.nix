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
    system = "x86_64-linux";

    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      # Name of config
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system;
          inherit pkgs-stable;
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
        };
        # Modules
        modules = [
          ./hosts/server/configuration.nix
        ];
      };
    };
  };
}
