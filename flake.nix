{
  description = "A very basic flake";

  inputs = {
    # Current stable channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
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
  in
  {
    nixosConfigurations = {
      # Name of config
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system;
          
          # Add the option to add unstable packages
          # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/downgrade-or-upgrade-packages
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        };
        # Modules this host uses
        modules = [
          ./NixOs/configuration.nix
        ];
      };
    };
  };
}
