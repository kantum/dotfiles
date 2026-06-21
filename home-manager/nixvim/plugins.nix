{
  pkgs,
  opencode,
  ...
}: {
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
          haskell = ["ormolu"];
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
        "<leader>fb" = "buffers";
        "<leader>fc" = "live_grep cwd=~/git/dotfiles/";
      };
      luaConfig.post = ''
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local make_entry = require("telescope.make_entry")
        local conf = require("telescope.config").values

        local live_multigrep = function(opts)
          opts = opts or {}
          opts.cwd = opts.cwd or vim.uv.cwd()

          local finder = finders.new_async_job {
            command_generator = function(prompt)
              if not prompt or prompt == "" then
                return nil
              end

              local pieces = vim.split(prompt, "  ")
              local args = { "rg" }
              if pieces[1] then
                table.insert(args, "-e")
                table.insert(args, pieces[1])
              end

              if pieces[2] then
                table.insert(args, "-g")
                table.insert(args, pieces[2])
              end

              ---@diagnostic disable-next-line: deprecated
              return vim.tbl_flatten {
                args,
                { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
              }
            end,
            entry_maker = make_entry.gen_from_vimgrep(opts),
            cwd = opts.cwd,
          }

          pickers.new(opts, {
            debounce = 100,
            prompt_title = "Multi Grep",
            finder = finder,
            previewer = conf.grep_previewer(opts),
            sorter = require("telescope.sorters").empty(),
          }):find()
        end

        -- Set the keymap locally inside telescope's lifecycle
        vim.keymap.set("n", "<leader>fg", live_multigrep, { desc = "Telescope Live Multi-Grep" })
      '';
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
          mode = ["n" "t"];
          action = "left";
          key = "<M-h>";
          options = {
            silent = true;
            desc = "Navigate left";
          };
        }
        {
          mode = ["n" "t"];
          action = "down";
          key = "<M-j>";
          options = {
            silent = true;
            desc = "Navigate down";
          };
        }
        {
          mode = ["n" "t"];
          action = "up";
          key = "<M-k>";
          options = {
            silent = true;
            desc = "Navigate up";
          };
        }
        {
          mode = ["n" "t"];
          action = "right";
          key = "<M-l>";
          options = {
            silent = true;
            desc = "Navigate right";
          };
        }
      ];
    };
    snacks = {
      enable = true;
      settings = {
        settings.input.enabled = true;
      };
    };

    opencode = {
      enable = true;
      autoLoad = true;
    };

    codecompanion = {
      enable = true;
      settings = {
        adapters = {
          acp = {
            opencode = {
              __raw = ''
                function()
                  return require("codecompanion.adapters").extend("opencode", {})
                  end
              '';
            };
          };
        };
        strategies = {
          chat = {
            adapter = "opencode";
          };
        };
      };
    };
  };
}
