{
  description = "Home Manager configuration of kantum";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/master";
    nixpkgs-old.url = "github:NixOS/nixpkgs/c9bd50a653957ee895ff8b6936864b7ece0a7fb6";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-old,
    home-manager,
    nixvim,
    ...
  }: let
    system = "aarch64-darwin";
    pkgs = import nixpkgs {
      inherit system;
    };

    pkgs-old = nixpkgs-old.legacyPackages.${system};
  in {
    homeConfigurations."kantum" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit nixvim pkgs-old;
      };
      modules = [
        ./home.nix
      ];
      # Specify your home configuration modules here, for example,
      # the path to your home.nix.

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
  };
}
