{
  description = "NixOS configuration for kantum's machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.05";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
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
  }: let
    unfree = {pkgs, ...}: {
      nixpkgs.config.allowUnfreePredicate = pkg:
        builtins.elem (pkgs.lib.getName pkg) [
          "obsidian"
          "claude-code"
          "firefox-bin-unwrapped"
          "firefox-bin"
          "github-copilot-cli"
          "calibre"
        ];
    };
  in {
    vm = self.nixosConfigurations.linux-vm.config.system.build.vm;

    darwinConfigurations."kantums-MacBook-Air" = nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit self;
      };
      modules = [
        ./hosts/macbook
        home-manager.darwinModules.home-manager
        unfree
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager = {
            extraSpecialArgs = {
              inherit self nixvim opencode;
              pkgs-stable = import nixpkgs-stable {system = "aarch64-darwin";};
            };
            users.kantum = {...}: {
              imports = [
                ./home-manager/home.nix
                ./hosts/macbook/home.nix
              ];
            };
          };
        }
        {
          nix.linux-builder = {
            enable = true;
            maxJobs = 8;
            config = {
              virtualisation = {
                darwin-builder = {
                  diskSize = 40 * 1024;
                  memorySize = 8 * 1024;
                };
                cores = 8;
              };
            };
          };
        }
      ];
    };
    nixosConfigurations."linux-vm" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./hosts/linux-vm
        home-manager.nixosModules.home-manager
        unfree
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          environment.pathsToLink = ["/share/applications" "/share/xdg-desktop-portal"];

          home-manager = {
            extraSpecialArgs = {
              inherit self nixvim opencode;
              pkgs-stable = import nixpkgs-stable {system = "aarch64-linux";};
            };
            users.kantum = {...}: {
              imports = [
                ./home-manager/home.nix
                ./hosts/linux-vm/home.nix
              ];
            };
          };
        }
        {
          virtualisation.host.pkgs = nixpkgs.legacyPackages."aarch64-darwin";
        }
      ];
      specialArgs = {inherit self;};
    };
  };
}
