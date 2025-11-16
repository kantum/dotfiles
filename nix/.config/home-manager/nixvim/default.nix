{pkgs, ...}: {
  imports = [
    ./plugins.nix
    ./keymaps.nix
  ];
  programs.nixvim = {
    enable = true;
    highlight = {
      NormalFloat = {
        bg = "NONE";
      };
      Normal = {
        bg = "NONE";
      };
      CursoroLine = {
        bg = "gray";
        blend = 20;
      };
      ColorColumn = {
        link = "CursorLine";
      };
    };
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
      autoread = true;
      clipboard = "unnamedplus";
      swapfile = false;
      undofile = true;
      laststatus = 3;
      scrolloff = 8;
      foldlevel = 99;
      foldlevelstart = 99;
    };

    colorschemes = {
      onedark = {
        enable = true;
        autoLoad = true;
        settings = {
          style = "dark";
          transparent = true;
          lualine = {
            transparent = true;
          };
        };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
      opencode-nvim
    ];
  };
}
