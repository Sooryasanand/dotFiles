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

