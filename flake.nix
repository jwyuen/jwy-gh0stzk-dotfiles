{
  # TODO: add nix cache server? https://nixos-and-flakes.thiscute.world/nixos-with-flakes/add-custom-cache-servers

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/23.11";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    # non-flakes
    xqp.url = "github:baskerville/xqp";
    xqp.flake = false;
  };

  #outputs = inputs@{ self, nixpkgs, utils, home-manager, ... }: utils.lib.eachDefaultSystem (system:
  outputs = inputs@{ nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    inherit (import ./options.nix) username hostname;

    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      "${hostname}" = nixpkgs.lib.nixosSystem {
        specialArgs = { 
          inherit system; inherit inputs; 
          inherit username; inherit hostname;
        };
        modules = [ 
          ./system.nix
          home-manager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = {
              inherit username; inherit inputs;
              inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.${username} = import ./home.nix;
          }
        ];
      };
    };
  };
}
