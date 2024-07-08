{
  # TODO: add nix cache server? https://nixos-and-flakes.thiscute.world/nixos-with-flakes/add-custom-cache-servers

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, lanzaboote, ... }:
  let
    system = "x86_64-linux";
    host = "nix-deskstar";
    inherit (import ./nix-config/hosts/${host}/options.nix) username hostname;
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      # default config
      "${hostname}" = nixpkgs.lib.nixosSystem {
        specialArgs = { 
          inherit system; inherit inputs; 
          inherit username; inherit hostname;
          inherit host;
        };
        modules = [ 
          ./system.nix
          lanzaboote.nixosModules.lanzaboote
          home-manager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = {
              inherit username; 
              inherit inputs;
              inherit host;
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
