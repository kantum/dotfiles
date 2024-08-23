-- Setup language servers.
require("mason").setup()
require("mason-lspconfig").setup({
	automatic_installation = true,
})

local mason_registry = require("mason-registry")
local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
	.. "/node_modules/@vue/language-server"

local lspconfig = require("lspconfig")
lspconfig.pyright.setup({})
lspconfig.tsserver.setup({
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vue_language_server_path,
				languages = { "vue" },
			},
		},
	},
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})
lspconfig.rust_analyzer.setup({
	-- Server-specific settings. See `:help lspconfig-setup`
	settings = {
		["rust-analyzer"] = {},
	},
})

lspconfig.volar.setup({
	on_init = function(client)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentFormattingRangeProvider = false
	end,
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
})

-- lspconfig.volar.setup({})
lspconfig.gopls.setup({
	settings = { gopls = {
		buildFlags = { "-tags=integration" },
	} },
})

lspconfig.sqlls.setup({})
lspconfig.taplo.setup({})
lspconfig.dockerls.setup({})
lspconfig.yamlls.setup({})
lspconfig.bashls.setup({})
lspconfig.eslint.setup({})

lspconfig.html.setup({
	filetypes = { "html", "heex" },
})

lspconfig.tailwindcss.setup({
	init_options = {
		userLanguages = {
			elixir = "html-eex",
			eelixir = "html-eex",
			heex = "html-eex",
		},
	},
})

lspconfig.jsonnet_ls.setup({
	settings = {
		ext_vars = {
			foo = "bar",
		},
		formatting = {
			-- default values
			Indent = 2,
			MaxBlankLines = 2,
			StringStyle = "single",
			CommentStyle = "slash",
			PrettyFieldNames = true,
			PadArrays = false,
			PadObjects = true,
			SortImports = true,
			UseImplicitPlus = true,
			StripEverything = false,
			StripComments = false,
			StripAllButComments = false,
		},
	},
})
lspconfig.golangci_lint_ls.setup({})
lspconfig.zls.setup({
	cmd = { "zls" },
	filetypes = { "zig" },
	root_dir = lspconfig.util.root_pattern("build.zig", ".git"),
})

local configs = require("lspconfig.configs")
local lexical_config = {
	filetypes = { "elixir", "eelixir", "heex" },
	cmd = { "lexical" },
	settings = {},
}

if not configs.lexical then
	configs.lexical = {
		default_config = {
			filetypes = lexical_config.filetypes,
			cmd = lexical_config.cmd,
			root_dir = function(fname)
				return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir()
			end,
			-- optional settings
			settings = lexical_config.settings,
		},
	}
end

-- lspconfig.lexical.setup({})

local util = require("lspconfig.util")

lspconfig.vacuum.setup({
	cmd = { "vacuum", "language-server" },
	filetypes = { "yaml.openapi", "json.openapi" },
	root_dir = util.find_git_ancestor,
	single_file_support = true,
})

vim.filetype.add({
	pattern = {
		["openapi.*%.ya?ml"] = "yaml.openapi",
		["openapi.*%.json"] = "json.openapi",
	},
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	-- Disable virtual text, override spacing to 4
	virtual_text = false,
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})
