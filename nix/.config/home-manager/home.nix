{
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kantum";
  home.homeDirectory = "/Users/kantum";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Allows unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "obsidian"
    ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    stow
    neovim
    tmux
    tree
    git
    git-lfs
    jq
    ripgrep
    fd
    gnupg
    pinentry-curses
    ranger
    direnv
    gitui
    ffmpeg
    fzf
    cmatrix
    # mpv
    convco # conventionnal commits
    # go
    rustup
    xh # better curl (http command)
    ocaml
    ocamlPackages.findlib
    ocamlPackages.batteries
    corepack
    platformio # https://github.com/NixOS/nixpkgs/pull/258358
    imagemagick
    # bitwarden-cli # password manager
    ncdu # disk usage
    openssl
    # mitmproxy # proxy, not working right now, see https://github.com/NixOS/nixpkgs/issues/291753
    dive # docker image explorer
    dbeaver-bin
    # difftastic # better diff, not sure if I want to use it
    awscli2
    texliveFull
    wget
    lexical
    bottom
    htop
    beam.packages.erlang_27.elixir_1_17
    postgresql
    monitorcontrol # Control your display's brightness & volume on your Mac as if it was a native Apple Display.
    obsidian
    watch
    lua
    luarocks
    alejandra # Nix formatter
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    VISUAL = "nvim";
    EDITOR = "nvim";

    # Enable iex history between sessions
    ERL_AFLAGS = "-kernel shell_history enabled";
  };

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
