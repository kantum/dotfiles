{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    highlight = {
      NormalFloat = {
        bg = "NONE";
      };
      Normal = {
        bg = "NONE";
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
      colorcolumn = "80";
      swapfile = false;
      undofile = true;
      laststatus = 3;
    };

    keymaps = import ./keymaps.nix;

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

    plugins = import ./plugins.nix;

    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
      opencode-nvim
    ];
  };
}
