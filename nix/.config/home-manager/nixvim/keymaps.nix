[
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
    action = "vim.diagnostic.open_float";
    lua = true;
  }
  {
    key = "[d";
    mode = "n";
    action = "vim.diagnostic.goto_prev";
    lua = true;
  }
  {
    key = "]d";
    mode = "n";
    action = "vim.diagnostic.goto_next";
    lua = true;
  }
  {
    key = "<leader>q";
    mode = "n";
    action = "vim.diagnostic.setloclist";
    lua = true;
  }
  {
    mode = "n";
    key = "gD";
    action = "vim.lsp.buf.declaration";
    lua = true;
  }
  {
    mode = "n";
    key = "gd";
    action = "vim.lsp.buf.definition";
    lua = true;
  }
  {
    mode = "n";
    key = "K";
    action = "vim.lsp.buf.hover";
    lua = true;
  }
  {
    mode = "n";
    key = "gi";
    action = "vim.lsp.buf.implementation";
    lua = true;
  }
  {
    mode = "n";
    key = "<C-k>";
    action = "vim.lsp.buf.signature_help";
    lua = true;
  }
  {
    mode = "n";
    key = "<leader>wa";
    action = "vim.lsp.buf.add_workspace_folder";
    lua = true;
  }
  {
    mode = "n";
    key = "<leader>wr";
    action = "vim.lsp.buf.remove_workspace_folder";
    lua = true;
  }
  {
    mode = "n";
    key = "<leader>wl";
    action = ''
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end
    '';
    lua = true;
  }
  {
    mode = "n";
    key = "<leader>D";
    action = "vim.lsp.buf.type_definition";
    lua = true;
  }
  {
    mode = "n";
    key = "<leader>rn";
    action = "vim.lsp.buf.rename";
    lua = true;
  }
  {
    mode = ["n" "v"];
    key = "<leader>ca";
    action = "vim.lsp.buf.code_action";
    lua = true;
  }
  {
    mode = "n";
    key = "gr";
    action = "vim.lsp.buf.references";
    lua = true;
  }
  {
    mode = "n";
    key = "<leader>f";
    action = ''
      function()
        vim.lsp.buf.format({ async = true })
      end
    '';
    lua = true;
  }

  # Git
  {
    mode = "n";
    key = "<leader>gd";
    action = "<CMD>DiffviewOpen<CR>";
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
]
