local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = " "

-- Do not create swapfiles
vim.cmd(':set noswapfile')

vim.opt.rtp:prepend(lazypath)

-- Lazy nvim
require("lazy").setup(require('plugins'), {})

-- Colorscheme
vim.cmd('colorscheme onedark')

-- Legacy vimrc
vim.cmd([[
source ~/.vimrc
]])

-- Telescope
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      hidden = true,                   -- show hidden files
    }
  }
}
require('telescope').load_extension 'fzf'
require("telescope").load_extension "file_browser"


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { --hidden=true
  noremap = true,
  silent = true
})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Devicons
-- require'nvim-web-devicons'.setup {
--  -- your personnal icons can go here (to override)
--  -- you can specify color or cterm_color instead of specifying both of them
--  -- DevIcon will be appended to `name`
--  override = {
--   zsh = {
--     icon = "",
--     color = "#428850",
--     cterm_color = "65",
--     name = "Zsh"
--   }
--  };
--  -- globally enable different highlight colors per icon (default to true)
--  -- if set to false all icons will have the default icon's color
--  color_icons = true;
--  -- globally enable default icons (default to false)
--  -- will get overriden by `get_icons` option
--  default = true;
--  -- globally enable "strict" selection of icons - icon will be looked up in
--  -- different tables, first by filename, and if not found by extension; this
--  -- prevents cases when file doesn't have any extension but still gets some icon
--  -- because its name happened to match some extension (default to false)
--  strict = true;
--  -- same as `override` but specifically for overrides by filename
--  -- takes effect when `strict` is true
--  override_by_filename = {
--   [".gitignore"] = {
--     icon = "",
--     color = "#f1502f",
--     name = "Gitignore"
--   }
--  };
--  -- same as `override` but specifically for overrides by extension
--  -- takes effect when `strict` is true
--  override_by_extension = {
--   ["log"] = {
--     icon = "",
--     color = "#81e043",
--     name = "Log"
--   }
--  };
-- }
