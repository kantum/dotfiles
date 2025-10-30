{
  config,
  pkgs,
  pkgs-old,
  nixvim,
  ...
}: {
  imports = [
    nixvim.homeModules.nixvim
  ];
  home.username = "kantum";
  home.homeDirectory = "/Users/kantum";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Allows unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "obsidian"
      "claude-code"
      "languagetool"
      "firefox-bin-unwrapped"
      "firefox-bin"
    ];

  home.packages = with pkgs; [
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
    corepack
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
    lexical
    lua
    luarocks
    monitorcontrol # Control your display's brightness & volume on your Mac as if it was a native Apple Display.
    ncdu # disk usage
    neofetch
    # neovim
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
    opencode
    catimg
    # affine # Electron is marked as insecure
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

  programs.nixvim = {
    enable = true;
    # nixpkgs.useGlobalPackages = true;

    defaultEditor = true;
    vimdiffAlias = true;
    globals.mapleader = " ";

    opts = {
      background = "dark";
      number = true;

      relativenumber = true;
      ignorecase = true;
      smartcase = true;
      clipboard = "unnamedplus";
      colorcolumn = "80";
    };

    keymaps = [
      {
        key = "-";
        action = "<CMD>Oil<CR>";
      }
      {
        key = "<leader>c";
        action = ":set cursorline! cursorcolumn!<cr>";
      }
      {
        mode = "n";
        key = "<C-S>";
        action = ":update<CR>";
        options.silent = true;
      }
      {
        mode = "v";
        key = "<C-S>";
        action = "<C-C>:update<CR>";
        options.silent = true;
      }
      {
        mode = "i";
        key = "<C-S>";
        action = "<Esc>:update<CR>";
        options.silent = true;
      }

      # Lsp
      {
        key = "<leader>e";
        mode = "n";
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
      }
      {
        key = "[d";
        mode = "n";
        action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
      }
      {
        key = "]d";
        mode = "n";
        action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
      }
      {
        key = "<leader>q";
        mode = "n";
        action = "<cmd>lua vim.diagnostic.setloclist()<CR>";
      }
    ];

    colorschemes = {
      onedark = {
        enable = true;
        autoLoad = true;
        settings = {
          style = "dark";
          transparent = true;
        };
      };
    };

    plugins = {
      snacks = {
        enable = true;
        settings.input.enabled = true;
      };
      fugitive.enable = true;
      lualine.enable = true;
      oil = {
        enable = true;
        settings = {
          default_file_explorer = true;
        };
      };

      lsp = {
        enable = true;
        servers = {
          lua_ls.enable = true;

          elixirls = {
            enable = true;
            # settings = {
            #   activate = true;
            # };
          };

          # expert = {
          #   enable = true;
          # };
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
      };

      conform-nvim = {
        enable = true;
        autoInstall.enable = true;
        settings = {
          formatters_by_ft = {
            lua = ["stylua"];
            rust = ["rustfmt"];
            nix = ["alejandra"];
            # elixir = ["mix"];
            # heex = ["mix"];
            javascript = ["prettier"];
            typescript = ["prettier"];
            json = ["prettier"];
            mjs = ["prettier"];
            go = ["gofmt" "gofumpt"];
            proto = ["buf"];
            terraform = ["tofu_fmt"];
            bash = [
              "shellcheck"
              "shellharden"
              "shfmt"
            ];
            "_" = [
              "squeeze_blanks"
              "trim_whitespace"
              "trim_newlines"
            ];
          };
          format_on_save = {
            timeout_ms = 500;
            lsp_format = "prefer";
          };
        };
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
        };
      };
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
        };
      };
      mini = {
        enable = true;
        modules = {
          icons.enable = true;
          comment.enable = true;
        };
        mockDevIcons = true;
      };
    };
    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
    ];
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

  programs.zathura = {
    enable = true;
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
    package = pkgs-old.gitui;
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
        if [ -z "$TMUX" ]; then
          exec tmux a || tmux
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
