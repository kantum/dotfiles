{
  config,
  pkgs,
  nixvim,
  pkgs-stable,
  opencode,
  ...
}: {
  imports = [
    nixvim.homeModules.nixvim
    ./nixvim
  ];
  home.username = "kantum";
  home.homeDirectory = "/Users/kantum";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs;
    [
      android-tools
      python312Packages.flask
      pipenv
      scrcpy
      awscli2
      ext4fuse
      bottom
      btop
      cmatrix
      convco # conventionnal commits
      dbeaver-bin
      dive # docker image explorer
      duf # disk usage
      dust # disk usage
      elixir_1_18
      fd
      # flyctl
      geany
      gh
      git
      git-lfs
      git-filter-repo
      glab
      gnupg
      go
      grpcurl
      htop
      imagemagick
      jq
      lua
      luarocks
      monitorcontrol # Control your display's brightness & volume on your Mac as if it was a native Apple Display.
      ncdu # disk usage
      fastfetch
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
      lnav
      rustup
      beam28Packages.expert
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
      claude-code-router
      # opencode
      catimg
      affine
      github-copilot-cli
      libreoffice-bin
      uv
      opencode.packages.${pkgs.system}.default
      # penpot-desktop
    ]
    ++ [
      pkgs-stable.libation
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
    SOPS_EDITOR = "nvim --clean";

    GPG_TTY = "$(tty)";

    AWS_DEFAULT_PROFILE = "";

    # Enable iex history between sessions
    ERL_AFLAGS = "-kernel shell_history enabled";
    FLYCTL_INSTALL = "/Users/kantum/.fly";
    PATH = "$FLYCTL_INSTALL/bin:$PATH";
  };

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };

  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    settings = {
      font-size = 11;
      font-family = "Hack Nerd Font";
      theme = "dark:Catppuccin Mocha,light:Catppuccin Latte";
      window-theme = "auto";
      window-decoration = "none";
      bell-features = "system,attention,audio,title";
      fullscreen = true;
      macos-option-as-alt = true;

      # Disables ligatures
      font-feature = ["-liga" "-dlig" "-calt"];

      keybind = [
        # cmd-s is ctr-s
        "super+s=text:\\x13"
        # cmd-w is space,+,w
        "super+w=text: +w"
        # cmd-t is space,+,t
        "super+t=text: +t"
        # cmd-{ is space,+,{
        "super+shift+[=text: +{"
        # cmd-} is space,+,}
        "super+shift+]=text: +}"
      ];
    };
  };

  programs.zathura = {
    enable = false; # Not building anymore
    extraConfig = ''
      set recolor true
      set recolor-darkcolor "#dcdccc"
      set recolor-lightcolor "#282c34"
      set default-bg "#222D32"

      # copy selection to system clipboard
      set selection-clipboard clipboard

      map f toggle_fullscreen
      set window-height 30000
      set window-width 30000
    '';
  };

  programs.gitui = {
    enable = true;
    package = pkgs-stable.gitui;
    keyConfig = ''
      (
      move_left: Some(( code: Char('h'), modifiers: "")),
      move_right: Some(( code: Char('l'), modifiers: "")),
      move_up: Some(( code: Char('k'), modifiers: "")),
      move_down: Some(( code: Char('j'), modifiers: "")),

      stash_open: Some(( code: Char('l'), modifiers: "")),
      open_help: Some(( code: F(1), modifiers: "")),

      status_reset_item: Some(( code: Char('U'), modifiers: "SHIFT")),
      )
    '';
  };

  programs.git = {
    enable = true;
    extraConfig = {
      diff.tool = "nvimdiff";
      merge.tool = "nvimdiff";
      difftool.prompt = false;
    };
  };

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
    syntaxHighlighting.enable = false;

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
      if command -v tmux >/dev/null 2>&1; then
        if [ -z "$TMUX" ] && [ "$TERM_PROGRAM" != "vscode" ]; then
          tmux a || tmux || printf "tmux failed to launch\n"
        fi
      fi
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
    focusEvents = true;

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = pain-control;
      }
    ];

    extraConfig = ''
      # fix ctrl-a not going to the start of the line
      bind C-a send-prefix

      # Status bar customization
      set -g status off

      # Set XTerm key bindings
      setw -g xterm-keys on

      set -g mode-style "fg=white,bg=color099"
      set -g message-command-style "fg=white,bg=color099"
      set -g message-style "fg=white,bg=color099"

      set -g pane-border-style fg=black
      set -g pane-active-border-style "bg=default fg=color099"

      # Smart pane switching with awareness of Vim splits.
      # See: https://github.com/christoomey/vim-tmux-navigator
      vim_pattern='(\S+/)?g?\.?(view|l?n?vim?x?|fzf)(diff)?(-wrapped)?'
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +''${vim_pattern}$'"
      bind-key -n 'M-h' if-shell "$is_vim" 'send-keys M-h'  'select-pane -L'
      bind-key -n 'M-j' if-shell "$is_vim" 'send-keys M-j'  'select-pane -D'
      bind-key -n 'M-k' if-shell "$is_vim" 'send-keys M-k'  'select-pane -U'
      bind-key -n 'M-l' if-shell "$is_vim" 'send-keys M-l'  'select-pane -R'
      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'M-\\' if-shell \"$is_vim\" 'send-keys M-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'M-\\' if-shell \"$is_vim\" 'send-keys M-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'M-h' select-pane -L
      bind-key -T copy-mode-vi 'M-j' select-pane -D
      bind-key -T copy-mode-vi 'M-k' select-pane -U
      bind-key -T copy-mode-vi 'M-l' select-pane -R
      bind-key -T copy-mode-vi 'M-\' select-pane -l

      bind-key -n 'M-n' next-window
      bind-key -n 'M-p' previous-window
      bind-key -n 'M-z' resize-pane -Z
      bind-key -n 'M-c' new-window
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

  programs.aerospace = {
    enable = true;
    launchd.enable = true;
    settings = {
      gaps = {
        inner.horizontal = 4;
        inner.vertical = 4;
        outer.left = 4;
        outer.bottom = 4;
        outer.top = 4;
        outer.right = 4;
      };
      start-at-login = true;
      mode.main.binding = {
        cmd-alt-slash = "layout tiles horizontal vertical";
        cmd-alt-comma = "layout accordion horizontal vertical";

        cmd-alt-j = "focus left";
        cmd-alt-k = "focus down";
        cmd-alt-l = "focus up";
        cmd-alt-semicolon = "focus right";

        cmd-alt-shift-j = "move left";
        cmd-alt-shift-k = "move down";
        cmd-alt-shift-l = "move up";
        cmd-alt-shift-semicolon = "move right";

        cmd-alt-a = "workspace 1";
        cmd-alt-s = "workspace 2";
        cmd-alt-d = "workspace 3";
        cmd-alt-f = "workspace 4";
        cmd-alt-g = "workspace 5";
        cmd-alt-z = "workspace 6";
        cmd-alt-x = "workspace 7";
        cmd-alt-c = "workspace 8";
        cmd-alt-v = "workspace 9";
        cmd-alt-b = "workspace 10";

        cmd-alt-shift-a = "move-node-to-workspace 1";
        cmd-alt-shift-s = "move-node-to-workspace 2";
        cmd-alt-shift-d = "move-node-to-workspace 3";
        cmd-alt-shift-f = "move-node-to-workspace 4";
        cmd-alt-shift-g = "move-node-to-workspace 5";
        cmd-alt-shift-z = "move-node-to-workspace 6";
        cmd-alt-shift-x = "move-node-to-workspace 7";
        cmd-alt-shift-c = "move-node-to-workspace 8";
        cmd-alt-shift-v = "move-node-to-workspace 9";
        cmd-alt-shift-b = "move-node-to-workspace 10";
      };

      on-window-detected = [
        {
          "if" = {
            app-id = "com.mitchellh.ghostty";
          };
          run = "move-node-to-workspace 1";
        }
        {
          "if" = {
            app-id = "org.mozilla.firefox";
          };
          run = "move-node-to-workspace 2";
        }
        {
          "if" = {
            app-id = "com.openai.chat";
          };
          run = "move-node-to-workspace 3";
        }
        {
          "if" = {
            app-id = "com.hnc.Discord";
          };
          run = "move-node-to-workspace 4";
        }
        {
          "if" = {
            app-id = "com.apple.MobileSMS";
          };
          run = "move-node-to-workspace 4";
        }
        {
          "if" = {
            app-id = "com.spotify.client";
          };
          run = "move-node-to-workspace 5";
        }
      ];
    };
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
