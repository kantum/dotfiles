{
  config,
  pkgs,
  ...
}: {
  home.username = "kantum";
  home.homeDirectory = "/Users/kantum";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Allows unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "obsidian"
      "claude-code"
    ];

  home.packages = with pkgs; [
    android-tools
    python312Packages.flask
    pipenv
    scrcpy
    alejandra # Nix formatter
    awscli2
    ext4fuse
    bottom
    btop
    cmatrix
    convco # conventionnal commits
    corepack
    dbeaver-bin
    dive # docker image explorer
    duf # disk usage
    dust # disk usage
    elixir_1_18
    fd
    flyctl
    geany
    gh
    git
    git-lfs
    git-filter-repo
    gitui
    glab
    gnupg
    go
    grpcurl
    htop
    imagemagick
    jq
    lexical
    lua
    luarocks
    monitorcontrol # Control your display's brightness & volume on your Mac as if it was a native Apple Display.
    ncdu # disk usage
    neofetch
    neovim
    nh # Nix helper
    nixos-shell
    nmap
    nodejs_24
    obsidian
    ocaml
    ocamlPackages.batteries
    ocamlPackages.findlib
    ollama
    openssl
    pinentry-curses
    pkg-config
    platformio # https://github.com/NixOS/nixpkgs/pull/258358
    portaudio
    postgresql
    qemu # Emulator
    ripgrep
    rustup
    shellcheck
    stow
    texliveFull
    tree
    tui-journal
    vlc-bin
    watch
    wget
    xh # better curl (http command)
    yt-dlp
    zstd # compression
    claude-code
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
    dotDir = config.xdg.configHome + "zsh";
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

    initContent = ''
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

  # programs.atuin = {
  #   enable = true;
  #   enableZshIntegration = true;
  #   flags = ["--disable-up-arrow"];
  # };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    clock24 = true;
    baseIndex = 1;
    prefix = "C-a";
    keyMode = "vi";
    escapeTime = 10;
    mouse = true;
    historyLimit = 50000;

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = pain-control;
      }
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '5'
        '';
      }
    ];

    extraConfig = ''
      # Status bar customization
      set -g status off

      # Set XTerm key bindings
      setw -g xterm-keys on

      set -g mode-style "fg=white,bg=color099"
      set -g message-command-style "fg=white,bg=color099"
      set -g message-style "fg=white,bg=color099"

      set -g pane-border-style fg=black
      set -g pane-active-border-style "bg=default fg=color099"

    '';
  };

  programs.ranger = {
    enable = true;
  };

  programs.lf = {
    enable = true;
    keybindings = {
      enter = "open";
      dD = "delete";
    };
    previewer = {
      keybinding = "i";
      source = "${pkgs.pistol}/bin/pistol";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
