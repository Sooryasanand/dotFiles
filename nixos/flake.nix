{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    polykey-cli.url = "github:MatrixAI/Polykey-CLI";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
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
    };
}
