{
  description = "Configure macOS using nix-darwin with rosetta-builder";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.05";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim = {
      url = "github:nix-community/nixvim";
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
  }: let
    pkgs-stable = import nixpkgs-stable {
      system = "aarch64-darwin";
    };
    configuration = {pkgs, ...}: {
      # Let nix-darwin manage nix.
      nix.enable = false;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
        pkgs.vim
        pkgs.sox
      ];

      users.users.kantum.home = "/Users/kantum";

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

      system.primaryUser = "kantum";

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # Following line should allow us to avoid a logout/login cycle
      system.activationScripts.activateSettings.text = ''
        /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
      '';

      # Allows unfree packages
      nixpkgs.config.allowUnfreePredicate = pkg:
        builtins.elem (pkgs.lib.getName pkg) [
          "obsidian"
          "claude-code"
          "languagetool"
          "firefox-bin-unwrapped"
          "firefox-bin"
          "github-copilot-cli"
        ];

      # services.karabiner-elements.enable = true; # not working yet, need manual install. https://github.com/nix-darwin/nix-darwin/pull/1595
      launchd = {
        daemons = {
          kanata = {
            command = "${pkgs.kanata-with-cmd}/bin/kanata -c ${./kanata.lisp} --log-layer-changes";
            path = [
              "${pkgs.sox}/bin"
            ];
            serviceConfig = {
              KeepAlive = true;
              RunAtLoad = true;
              StandardOutPath = "/tmp/kanata.out.log";
              StandardErrorPath = "/tmp/kanata.err.log";
            };
          };
        };
      };
      environment.etc."sudoers.d/kanata".source = pkgs.runCommand "sudoers-kanata" {} ''
        cat <<EOF >"$out"
        ALL ALL=(ALL) NOPASSWD: ${pkgs.kanata-with-cmd}/bin/kanata
        EOF
      '';
    };
  in {
    darwinConfigurations."kantums-MacBook-Air" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager = {
            extraSpecialArgs = {
              inherit nixvim pkgs-stable;
            };
            users.kantum = import ./home-manager/home.nix;
          };
        }
      ];
    };
  };
}
