{
  description = "Configure macOS using nix-darwin with rosetta-builder";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    #home-config.url = "path:/Users/kantum/.config/home-manager";
    nix-rosetta-builder = {
      url = "github:cpick/nix-rosetta-builder";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    nix-rosetta-builder,
  }: let
    configuration = {pkgs, ...}: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
        pkgs.vim
      ];

      nix.linux-builder = {
        enable = true;
        ephemeral = true;
        maxJobs = 10;
        config = {...}: {
          virtualisation = {
            darwin-builder = {
              diskSize = 40 * 1024;
              memorySize = 8 * 1024;
            };
            cores = 4;
          };
        };
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      nix.settings.trusted-users = ["kantum"];

      # nix.settings.extra-nix-path = "nixpkgs=flake:nixpkgs";
      # nix.settings.extra-platforms = ["x86_64-linux"];

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#kantums-MacBook-Air
    darwinConfigurations."kantums-MacBook-Air" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          #home-manager.users.kantum = import ./home.nix;
          #home-manager.users.kantum = import inputs.home-config;

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }
        # An existing Linux builder is needed to initially bootstrap `nix-rosetta-builder`.
        # If one isn't already available: comment out the `nix-rosetta-builder` module below,
        # uncomment this `linux-builder` module, and run `darwin-rebuild switch`:
        # { nix.linux-builder.enable = true; }
        # Then: uncomment `nix-rosetta-builder`, remove `linux-builder`, and `darwin-rebuild switch`
        # a second time. Subsequently, `nix-rosetta-builder` can rebuild itself.
        nix-rosetta-builder.darwinModules.default
        {
          # see available options in module.nix's `options.nix-rosetta-builder`
          nix-rosetta-builder.onDemand = true;
        }
      ];
    };
  };
}
