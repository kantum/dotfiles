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

-- Use <Tab> and <S-Tab> to navigate through popup menu
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})

-- Set completeopt to have a better completion experience
vim.o.completeopt="menuone,noinsert,noselect"

-- Avoid showing message extra message when using completion
vim.o.shortmess = vim.o.shortmess .. "c"

-- Chain completion list
vim.g.completion_chain_complete_list = {
	default = {
		default = {
			{ complete_items = { 'lsp', 'snippet' }},
			{ mode = '<c-p>'},
			{ mode = '<c-n>'}
		},
		comment = {},
		string = { { complete_items = { 'path' } } }
	}
}

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
vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>lua _float_toggle()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _gitui_toggle()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>td", "<cmd>lua _lazydocker_toggle()<CR>", {noremap = true, silent = true})

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {
	noremap = true,
	silent = true,
})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {
	noremap = true,
	silent = true,
})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.api.nvim_set_keymap('n', '<space>fb', ':Telescope file_browser<CR>', { noremap = true })

-- Legacy vimrc
-- vim.cmd([[
-- source ~/.vimrc
-- ]])

--------------------------------------------------------------------------------
-- Telescope                                                           Plugin --
--------------------------------------------------------------------------------
require('telescope').load_extension 'fzf'
require("telescope").load_extension "file_browser"
require("telescope").load_extension("undo")

-- Add toggle preview
local action_layout = require("telescope.actions.layout")
require("telescope").setup{
  defaults = {
    mappings = {
      n = {
        ["<M-p>"] = action_layout.toggle_preview
      },
      i = {
        ["<M-p>"] = action_layout.toggle_preview,
		['<C-u>'] = false,
		['<C-d>'] = false,
      },
    },
	pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			-- find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "-u" },
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			hidden = true,                   -- show hidden files
		},
		undo = {},
	},
  }
}

--------------------------------------------------------------------------------
-- Mason                                                               Plugin --
--------------------------------------------------------------------------------
require("mason").setup()

--------------------------------------------------------------------------------
-- LSP                                                                 Plugin --
--------------------------------------------------------------------------------
local lspconfig = require('lspconfig')
require'lspconfig'.gopls.setup{}
require'lspconfig'.golangci_lint_ls.setup{}

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
		-- TODO <space> conflicts with <leader>
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

-- Lua
require'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
		checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require('lspconfig').yamlls.setup {
  settings = {
    yaml = {
      schemas = {
      },
    },
  }
}

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

-- TODO this is not real toggles
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit",hidden = true, direction = "float" })
local gitui = Terminal:new({ cmd = "gitui",hidden = true, direction = "float" })

function _lazygit_toggle()
  lazygit:toggle()
end

function _gitui_toggle()
  gitui:toggle()
end

local float = Terminal:new({ hidden = true, direction = "float" })

function _float_toggle()
  float:toggle()
end

local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float" })

function _lazydocker_toggle()
  lazydocker:toggle()
end

--------------------------------------------------------------------------------
-- Gitsigns                                                            Plugin --
--------------------------------------------------------------------------------
require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
    delay = 100,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}

--------------------------------------------------------------------------------
-- Nvim-cmp                                                            Plugin --
--------------------------------------------------------------------------------
local cmp = require'cmp'
local luasnip = require'luasnip'

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		-- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		['<Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end,
		['<S-Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end,
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' }, -- For luasnip users.
	}, {
		{ name = 'buffer' },
	})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
