{pkgs, ...}: {
  programs.nixvim.plugins = {
    # Git
    gitsigns = {
      enable = true;
    };
    fugitive.enable = true;
    diffview.enable = true;
    lualine = {
      enable = true;
      settings = {
        options = {
          theme = "onedark";
        };
      };
    };
    lsp-lines.enable = true;
    trouble.enable = true;
    zen-mode = {
      enable = true;
      settings = {
        window = {
          width = 0.5;
        };
      };
    };
    origami = {
      enable = true;
      settings = {
        autoFold = {
          enabled = false;
        };
      };
    };
    markdown-preview = {
      enable = true;
    };
    multicursors.enable = true;
    oil = {
      enable = true;
      settings = {
        default_file_explorer = true;
        watch_for_changes = true;
        win_options = {
          signcolumn = "yes:2";
        };
      };
    };
    oil-git-status.enable = true;
    neo-tree.enable = true;
    copilot-lua = {
      enable = true;
      autoLoad = true;
      settings = {
        filetypes = {
          gitcommit = true;
        };
        suggestion = {
          enabled = false;
          auto_trigger = true;
          debounce = 75;
          hide_during_completion = false;
          keymap = {
            accept = "<C-y>";
            accept_line = false;
            accept_word = false;
            next = "<M-]>";
            prev = "<M-[>";
            dismiss = "<C-]>";
          };
        };
      };
    };

    lsp = {
      enable = true;
      servers = {
        lua_ls.enable = true;
        expert = {
          enable = true;
          package = pkgs.beam28Packages.expert;
        };
      };
    };

    blink-cmp = {
      enable = true;
      settings.sources.providers = {
        copilot = {
          async = true;
          module = "blink-copilot";
          name = "copilot";
          score_offset = 100;
          # Optional configurations
          opts = {
            max_completions = 3;
            max_attempts = 4;
            kind = "Copilot";
            auto_refresh = {
              backward = true;
              forward = true;
            };
          };
        };
        git = {
          module = "blink-cmp-git";
          name = "git";
          score_offset = 100;
          opts = {
            commit = {};
            git_centers = {git_hub = {};};
          };
        };
      };
      settings.sources = {
        default = [
          "lsp"
          "path"
          "snippets"
          "buffer"
          "copilot"
          "git"
        ];
      };
    };
    blink-cmp-git.enable = true;
    blink-copilot = {
      enable = true;
    };
    which-key = {
      enable = true;
      settings = {
        win = {
          no_overlap = true;
          width = 1;
          height = {
            min = 4;
            max = 25;
          };
        };
      };
    };
    conform-nvim = {
      enable = true;
      autoInstall.enable = true;
      settings = {
        formatters_by_ft = {
          lua = ["stylua"];
          rust = ["rustfmt"];
          nix = ["alejandra"];
          tex = ["latexindent"];
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
        "<leader>fb" = "buffers";
        "<leader>fc" = "live_grep cwd=~/git/dotfiles/nix/.config/nix-darwin/home-manager/nixvim";
      };
      settings = {
        defaults = {
          mappings = {
            i = {
              "<C-u>" = false;
              "<C-d>" = false;
            };
          };
        };
      };
    };
    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        auto_install = true;
      };
    };
    treesitter-context = {
      enable = true;
      settings = {
        mode = "topline";
        multiwindow = true;
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

    avante = {
      enable = true;
      settings = {
        provider = "copilot";
        insert_mode = false;
        mappings = {
          submit = {
            normal = "<CR>";
            insert = "<C-CR>";
          };
        };
        windows = {
          edit = {
            start_insert = false;
          };
          ask = {
            start_insert = false;
          };
        };
        layout = {
          files = {
            position = "top";
          };
        };
      };
    };
    neotest = {
      enable = true;
      adapters = {
        elixir = {
          enable = true;
        };
      };
      settings = {
        output = {
          enabled = true;
          open_on_run = true;
        };
        output_panel = {
          enabled = true;
          open = "botleft split | resize 15";
        };
        quickfix = {
          enabled = false;
        };
      };
    };
    tmux-navigator = {
      enable = true;
      settings = {
        no_mappings = 1;
      };
      keymaps = [
        {
          action = "left";
          key = "<M-h>";
          options = {
            silent = true;
            desc = "Navigate left";
          };
        }
        {
          action = "down";
          key = "<M-j>";
          options = {
            silent = true;
            desc = "Navigate down";
          };
        }
        {
          action = "up";
          key = "<M-k>";
          options = {
            silent = true;
            desc = "Navigate up";
          };
        }
        {
          action = "right";
          key = "<M-l>";
          options = {
            silent = true;
            desc = "Navigate right";
          };
        }
      ];
    };
  };
}
