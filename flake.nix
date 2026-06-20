{
  description = "Configure macOS using nix-darwin with rosetta-builder";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.05";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-rosetta-builder = {
      url = "github:cpick/nix-rosetta-builder";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    opencode = {
      # url = "github:anomalyco/opencode";
      url = "github:gigamonster256/opencode"; # Wait for https://github.com/anomalyco/opencode/pull/28479
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    nixvim,
    opencode,
    nix-rosetta-builder,
  }: let
    pkgs-stable = import nixpkgs-stable {
      system = "aarch64-darwin";
    };
  in {
    darwinConfigurations."kantums-MacBook-Air" = nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit self;
      };
      modules = [
        ./hosts/macbook
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager = {
            extraSpecialArgs = {
              inherit nixvim pkgs-stable opencode;
            };
            users.kantum = import ./home-manager/home.nix;
          };
          #home-manager.users.kantum = import inputs.home-config;

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }
        # An existing Linux builder is needed to initially bootstrap `nix-rosetta-builder`.
        # If one isn't already available: comment out the `nix-rosetta-builder` module below,
        # uncomment this `linux-builder` module, and run `darwin-rebuild switch`:
        #{nix.linux-builder.enable = true;}
        # Then: uncomment `nix-rosetta-builder`, remove `linux-builder`, and `darwin-rebuild switch`
        # a second time. Subsequently, `nix-rosetta-builder` can rebuild itself.
        # nix-rosetta-builder.darwinModules.default.
        # {
        #   # see available options in module.nix's `options.nix-rosetta-builder`
        #   nix-rosetta-builder.onDemand = true;
        # }
      ];
    };
  };
}
