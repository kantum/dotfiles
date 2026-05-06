{pkgs, ...}: {
  programs.nixvim.keymaps = [
    {
      key = "-";
      action = "<CMD>Oil<CR>";
    }
    {
      key = "<leader>c";
      action = ":set cursorline! cursorcolumn!<cr>";
    }
    {
      mode = ["n" "i" "v"];
      key = "<C-S>";
      action = "<Esc>:update<CR>";
      options.silent = true;
    }
    {
      mode = ["n" "i" "v"];
      key = "<leader>+w";
      action = "<Esc>:tabc<CR>";
      options.silent = true;
    }
    {
      mode = ["n" "i" "v"];
      key = "<leader>+t";
      action = "<Esc>:tabnew<CR>";
      options.silent = true;
    }
    {
      mode = ["n" "i" "v"];
      key = "<leader>+{";

      action = "<Esc>:tabprevious<CR>";
      options.silent = true;
    }
    {
      mode = ["n" "i" "v"];
      key = "<leader>+}";
      action = "<Esc>:tabnext<CR>";
      options.silent = true;
    }

    # Lsp
    {
      key = "<leader>e";
      mode = "n";
      action.__raw = "vim.diagnostic.open_float";
    }
    {
      key = "[d";
      mode = "n";
      action.__raw = "vim.diagnostic.goto_prev";
    }
    {
      key = "]d";
      mode = "n";
      action.__raw = "vim.diagnostic.goto_next";
    }
    {
      key = "<leader>q";
      mode = "n";
      action.__raw = "vim.diagnostic.setloclist";
    }
    {
      mode = "n";
      key = "gD";
      action.__raw = "vim.lsp.buf.declaration";
    }
    {
      mode = "n";
      key = "gd";
      action.__raw = "vim.lsp.buf.definition";
    }
    {
      mode = "n";
      key = "K";
      action.__raw = "vim.lsp.buf.hover";
    }
    {
      mode = "n";
      key = "gi";
      action.__raw = "vim.lsp.buf.implementation";
    }
    {
      mode = "n";
      key = "<C-k>";
      action.__raw = "vim.lsp.buf.signature_help";
    }
    {
      mode = "n";
      key = "<leader>wa";
      action.__raw = "vim.lsp.buf.add_workspace_folder";
    }
    {
      mode = "n";
      key = "<leader>wr";
      action.__raw = "vim.lsp.buf.remove_workspace_folder";
    }
    {
      mode = "n";
      key = "<leader>wl";
      action.__raw = ''
        function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end
      '';
    }
    {
      mode = "n";
      key = "<leader>D";
      action.__raw = "vim.lsp.buf.type_definition";
    }
    {
      mode = "n";
      key = "<leader>rn";
      action.__raw = "vim.lsp.buf.rename";
    }
    {
      mode = ["n" "v"];
      key = "<leader>ca";
      action.__raw = "vim.lsp.buf.code_action";
    }
    {
      mode = "n";
      key = "gr";
      action.__raw = "vim.lsp.buf.references";
    }
    {
      mode = "n";
      key = "<leader>f";
      action.__raw = ''
        function()
          vim.lsp.buf.format({ async = true })
        end
      '';
    }

    # Git
    {
      mode = "n";
      key = "<leader>gd";
      action.__raw = ''
        function()
          vim.g.diffview_enabled = not vim.g.diffview_enabled
          if vim.g.diffview_enabled then
            vim.cmd('DiffviewClose')
          else
            vim.cmd('DiffviewOpen')
          end
        end
      '';
      options = {
        desc = "Git Diff toggle";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>gh";
      action = "<CMD>DiffviewFileHistory %<CR>";
    }
    {
      mode = "n";
      key = "<leader>gc";
      action = "<CMD>Git commit --verbose<CR>";
    }
    {
      mode = "n";
      key = "<leader>gb";
      action = "<CMD>Git blame<CR>";
    }
    # Neotest
    {
      mode = "n";
      key = "<leader>tn";
      action = "<CMD>lua require('neotest').run.run()<CR>";
    }
    {
      mode = "n";
      key = "<leader>tf";
      action = "<CMD>lua require('neotest').run.run(vim.fn.expand('%'))<CR>";
    }
    {
      mode = "n";
      key = "<leader>ts";
      action = "<CMD>lua require('neotest').summary.toggle()<CR>";
    }
    {
      mode = "n";
      key = "<leader>to";
      action = "<CMD>lua require('neotest').output.open({ enter = true })<CR>";
    }
    {
      mode = "n";
      key = "<leader>tw";
      action = "<CMD>lua require('neotest').watch.toggle(vim.fn.expand('%'))<CR>";
    }
    # Trouble
    {
      key = "<leader>xx";
      action = "<cmd>Trouble diagnostics toggle<cr>";
      options = {
        desc = "Diagnostics (Trouble)";
      };
    }
    {
      key = "<leader>xX";
      action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
      options = {
        desc = "Buffer Diagnostics (Trouble)";
      };
    }
    {
      key = "<leader>cs";
      action = "<cmd>Trouble symbols toggle focus=false<cr>";
      options = {
        desc = "Symbols (Trouble)";
      };
    }
    {
      key = "<leader>cl";
      action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
      options = {
        desc = "LSP Definitions / references / ... (Trouble)";
      };
    }
    {
      key = "<leader>xL";
      action = "<cmd>Trouble loclist toggle<cr>";
      options = {
        desc = "Location List (Trouble)";
      };
    }
    {
      key = "<leader>xQ";
      action = "<cmd>Trouble qflist toggle<cr>";
      options = {
        desc = "Quickfix List (Trouble)";
      };
    }
    # Multiple Cursors
    {
      mode = "n";
      key = "<leader>m";
      action = "<CMD>MCfind<CR>";
    }
    {
      mode = "v";
      key = "<leader>m";
      action = "<CMD>MCfind<CR>";
    }
    # Zen Mode
    {
      mode = "n";
      key = "<leader>zz";
      action = "<CMD>ZenMode<CR>";
    }
    # Folds
    {
      mode = "n";
      key = "<CR>";
      action = "za";
      options = {
        desc = "Toggle folds in current buffer";
        buffer = true;
      };
    }
    # Neotree
    {
      mode = "n";
      key = "<leader>l";
      action = "<CMD>Neotree toggle<CR>";
    }
  ];
}
