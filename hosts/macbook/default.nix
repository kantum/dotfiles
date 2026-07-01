{
  pkgs,
  lib,
  self,
  opencode,
  ...
}: {
  # Let nix-darwin manage nix.
  nix.enable = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    vim
    sox
    curl
    utm
  ];

  users.users.kantum = {
    home = "/Users/kantum";
  };

  users.knownUsers = ["opencode"];
  users.knownGroups = ["opencode"];
  users.users.opencode = {
    packages = [
      opencode.packages.${pkgs.system}.default
    ];
    home = "/Users/opencode";
    createHome = true;
    uid = 510;
    gid = 511;
  };
  users.groups.opencode = {
    gid = 511;
    members = ["opencode"];
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

  system.primaryUser = "kantum";

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Following line should allow us to avoid a logout/login cycle
  system.activationScripts.activateSettings.text = ''
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  # services.karabiner-elements.enable = true; # not working yet, need manual install. https://github.com/nix-darwin/nix-darwin/pull/1595
  launchd = {
    daemons = {
      kanata = {
        command = "${pkgs.kanata-with-cmd}/bin/kanata -c ${self}/kanata.lisp --log-layer-changes";
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

  environment.etc."sudoers.d/opencode".source = pkgs.runCommand "sudoers-opencode" {} ''
    cat <<EOF >"$out"
    kantum ALL=(opencode) NOPASSWD: ALL
    EOF
  '';
}
