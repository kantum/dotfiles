{
  # Git
  gitsigns = {
    enable = true;
    settings = {
      current_line_blame = true;
    };
  };
  fugitive.enable = true;
  diffview.enable = true;
  lualine.enable = true;
  lsp-lines.enable = true;
  trouble.enable = true;
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
  copilot-lua = {
    enable = true;
    autoLoad = true;
    settings = {
      filetypes = {
        gitcommit = true;
      };
      suggestion = {
        enabled = true;
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

      elixirls = {
        enable = true;
        settings = {
          activate = true;
        };
      };
    };
  };

  blink-cmp = {
    enable = true;
    setupLspCapabilities = false;
  };
  blink-cmp-git.enable = true;
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
      "<leader>fb" = "buffers";
      "<leader>fc" = "live_grep cwd=~/git/dotfiles/nix/.config/home-manager/nixvim";
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
    };
  };
  treesitter-context.enable = true;
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
    };
  };
}
