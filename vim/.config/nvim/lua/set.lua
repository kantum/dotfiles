-- Ignore case when searching
vim.opt.ignorecase = true
-- Except when using capital letters
vim.opt.smartcase = true
-- Set clipboard to system clipboard
vim.opt.clipboard = "unnamedplus"

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
vim.opt.colorcolumn = "80"

-- Cursor Settings
vim.cmd([[
let &t_SI = "\e[4 q"
let &t_EI = "\e[4 q"

" reset the cursor on start (for older versions of vim, usually not required)
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END
]])

-- Set line numbers
vim.cmd.nnoremap("<leader>n", ":set number! | set relativenumber!<cr>")

-- Set tab width
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Use <Tab> and <S-Tab> to navigate through popup menu
-- vim.api.nvim_set_keymap("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true })
-- vim.api.nvim_set_keymap("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', { expr = true })

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noinsert,noselect"

-- Avoid showing message extra message when using completion
vim.o.shortmess = vim.o.shortmess .. "c"

-- Chain completion list
vim.g.completion_chain_complete_list = {
	default = {
		default = {
			{ complete_items = { "lsp", "snippet" } },
			{ mode = "<c-p>" },
			{ mode = "<c-n>" },
		},
		comment = {},
		string = { { complete_items = { "path" } } },
	},
}

-- Format on save
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})

vim.cmd.nnoremap(
	"<leader>h",
	":vimgrep /\\Vhtml\\!/ % | normal jvi} <Esc>:!prettier --parser html --stdin-filepath<CR>vi}>"
)

vim.g.python3_host_prog = "/opt/homebrew/bin/python3"
