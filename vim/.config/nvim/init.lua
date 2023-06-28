--------------------------------------------------------------------------------
-- Install lazy.nvim                                                          --
--------------------------------------------------------------------------------
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

--------------------------------------------------------------------------------
-- Pre lazy config                                                            --
--------------------------------------------------------------------------------

-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = " "

-- Avoid creating swap files in case lazy fails to load
vim.cmd(':set noswapfile')

-- Add lazy to runtimepath
vim.opt.rtp:prepend(lazypath)

-- Lazy nvim
require("lazy").setup(require('plugins'), {})

--------------------------------------------------------------------------------
-- Global Configuration                                                       --
--------------------------------------------------------------------------------

-- Ignore case when searching
vim.cmd.ignorecase = true
-- Except when using capital letters
vim.cmd.smartcase = true
-- Set clipboard to system clipboard
vim.opt.clipboard = "unnamedplus"

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Set tab width
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4


--------------------------------------------------------------------------------
-- Style                                                                      --
--------------------------------------------------------------------------------

-- Colorscheme
require("onedarkpro").setup({
  options = {
    transparency = true
  }
})

vim.cmd.colorscheme('onedark')

--------------------------------------------------------------------------------
-- Keybindings                                                                --
--------------------------------------------------------------------------------

-- Map <C-s> to save, on mac add \<C-s> keybinding to iterm2 to use command-s
vim.cmd.noremap('<silent> <C-S>  :update<CR>')
vim.cmd.vnoremap('<silent> <C-S> <C-C>:update<CR>')
vim.cmd.inoremap('<silent> <C-S> <Esc>:update<CR>')

-- Edit init.lua
vim.cmd.nnoremap('<leader>ei', ':vs $MYVIMRC<cr>')
vim.cmd.nnoremap('<leader>si', ':so $MYVIMRC<cr>')

vim.cmd.nnoremap('<leader>ep', ':vs ~/.config/nvim/lua/plugins.lua<cr>')
vim.cmd.nnoremap('<leader>p', ':Lazy<cr>')

-- NvimTree
vim.cmd.nnoremap('<leader>l', ':NvimTreeToggle<cr>')

-- Telescope Undo
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")

-- ToggleTerm
-- vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm direction=float<cr>")

-- Legacy vimrc
-- vim.cmd([[
-- source ~/.vimrc
-- ]])

--------------------------------------------------------------------------------
-- Telescope                                                           Plugin --
--------------------------------------------------------------------------------
require('telescope').setup {
	mappings = {
		i = {
			["<C-u>"] = true
		},
	},
	defaults = {
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
	},
	pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			hidden = true,                   -- show hidden files
		}
	}
}
require('telescope').load_extension 'fzf'
require("telescope").load_extension "file_browser"

-- Add Mappings for telescope
local actions = require("telescope.actions")
require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false
      },
    },
  }
}

-- Add toggle preview
local action_layout = require("telescope.actions.layout")
require("telescope").setup{
  defaults = {
    mappings = {
      n = {
        ["<M-p>"] = action_layout.toggle_preview
      },
      i = {
        ["<M-p>"] = action_layout.toggle_preview
      },
    },
  }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {
	noremap = true,
	silent = true,
})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.api.nvim_set_keymap('n', '<space>fb', ':Telescope file_browser<CR>', { noremap = true })

--------------------------------------------------------------------------------
-- Mason                                                               Plugin --
--------------------------------------------------------------------------------
require("mason").setup()

--------------------------------------------------------------------------------
-- LSP                                                                 Plugin --
--------------------------------------------------------------------------------
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
lspconfig.rust_analyzer.setup {
	-- Server-specific settings. See `:help lspconfig-setup`
	settings = {
		['rust-analyzer'] = {},
	},
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float) -- TODO will not work
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist) -- TODO will not work

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<space>f', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})

--------------------------------------------------------------------------------
-- Devicons                                                            Plugin --
--------------------------------------------------------------------------------
require'nvim-web-devicons'.setup { }

--------------------------------------------------------------------------------
-- Nvim Tree                                                           Plugin --
--------------------------------------------------------------------------------
require("nvim-tree").setup()

--------------------------------------------------------------------------------
-- ToggleTerm                                                          Plugin --
--------------------------------------------------------------------------------
require("toggleterm").setup{}

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
