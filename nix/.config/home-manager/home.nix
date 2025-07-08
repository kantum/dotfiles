{
  config,
  pkgs,
  ...
}: {
  home.username = "kantum";
  home.homeDirectory = "/Users/kantum";

  home.stateVersion = "24.05";

  # Allows unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "obsidian"
    ];

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
    gitui
    protobuf
    grpcurl
    portaudio
    pkg-config
    cmatrix
    nodejs_23
    convco # conventionnal commits
    go
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
    btop
    elixir_1_18
    postgresql
    monitorcontrol # Control your display's brightness & volume on your Mac as if it was a native Apple Display.
    obsidian
    watch
    lua
    luarocks
    alejandra # Nix formatter
    neofetch
    flyctl
    yt-dlp
    vlc-bin
    gh
    ollama
    shellcheck
    zstd # compression
    geany
    duf # disk usage
    dust # disk usage
    nh # Nix helper
  ];

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

    GPG_TTY = "$(tty)";

    AWS_DEFAULT_PROFILE = "";

    # Enable iex history between sessions
    ERL_AFLAGS = "-kernel shell_history enabled";
  };

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };

  # programs.ghostty = {
  #   enable = true;
  #   settings = {
  #     font-size = 11;
  #     font-family = "JetBrainsMono Nerd Font";
  #
  #     # Some macOS settings
  #     window-theme = "dark";
  #     macos-option-as-alt = true;
  #
  #     # Disables ligatures
  #     font-feature = ["-liga" "-dlig" "-calt"];
  #
  #     # cmd-s is ctr-s
  #     keybind = "super+s=text:\\x13";
  #   };
  # };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    autosuggestion.enable = true;
    enableCompletion = true;
    shellAliases = {
      ls = "ls --color";
      hs = "home-manager switch";
      top = "btm";
      vim = "nvim";
      ":q" = "exit";
      pgrep = "pgrep -f";
      pkill = "pkill -f";
      ytmp3 = "yt-dlp --extract-audio --audio-format mp3 --audio-quality 0";
      gc = "git commit --verbose";
      gp = "git push";
      "gc!" = "git commit --verbose --amend";
    };
    plugins = with pkgs; [
      {
        name = "zsh-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.8.0";
          sha256 = "1yl8zdip1z9inp280sfa5byjbf2vqh2iazsycar987khjsi5d5w8";
        };
      }
    ];

    initExtra = ''
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      PROMPT='%F{099}[%1~]%f '
      bindkey -e
      autoload -U edit-command-line
      zle -N edit-command-line
      bindkey '^x^e' edit-command-line
      bindkey \^U backward-kill-line
      PATH=$HOME/go/bin:$PATH
      [ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local
    '';

    history = {
      expireDuplicatesFirst = true;
      save = 1000000000;
      size = 1000000000;
    };
  };

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    flags = ["--disable-up-arrow"];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.ranger = {
    enable = true;
  };

  programs.lf = {
    enable = true;
    keybindings = {
      enter = "open";
    };
    previewer = {
      keybinding = "i";
      source = "${pkgs.pistol}/bin/pistol";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
