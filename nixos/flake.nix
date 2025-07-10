{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    polykey-cli.url = "github:MatrixAI/Polykey-CLI";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, home-manager, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        username = "sooryas";
      in {
        nixosConfigurations.macnix = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.users.${username} = import ./home.nix;
              users.users.${username}.isNormalUser = true;
              users.users.${username}.extraGroups = [ "wheel" "networkmanager" ];
              users.users.${username}.password = "password"; # CHANGE this!
            }
          ];
          specialArgs = { inherit inputs system username; };
        };

        homeConfigurations.${username} =
          home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
            extraSpecialArgs = { inherit inputs system username; };
            modules = [ ./home.nix ];
          };
      });
}
