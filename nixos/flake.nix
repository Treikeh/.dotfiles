# Learning resources
# https://www.youtube.com/watch?v=rEovNpg7J0M
# https://nixos-and-flakes.thiscute.world/nixos-with-flakes/downgrade-or-upgrade-packages
{
  description = "A very basic flake";

  inputs = {
    # Current stable channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    # Unstable channel
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    #home-manager = {
    #  url = "github:nix-community/home-manager";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable
  }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

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
          #inherit pkgs;
          inherit pkgs-unstable;
        };
        # Modules this host uses
        modules = [
          # This is to have this flake manage the allowUnfree variable. inherit pkgs; in specialArgs works, but gives an error and this doesn't
          { nixpkgs.pkgs = pkgs; }
          ./laptop.nix
        ];
      };
    };
  };
}
