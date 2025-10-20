-- Setup language servers.
require("mason").setup()

-- local mason_registry = require("mason-registry")
-- local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
-- 	.. "/node_modules/@vue/language-server"

local lspconfig = vim.lsp.config

local util = lspconfig.util

-- Function to get TypeScript server path
local function get_typescript_server_path(root_dir)
	local global_ts = vim.fn.expand("$HOME/.npm/lib/node_modules/typescript/lib")
	local found_ts = ""
	local function check_dir(path)
		found_ts = util.path.join(path, "node_modules", "typescript", "lib")
		if util.path.exists(found_ts) then
			return path
		end
	end
	if util.search_ancestors(root_dir, check_dir) then
		return found_ts
	else
		return global_ts
	end
end

vim.lsp.enable("pyright")

-- TypeScript configuration
vim.lsp.config("ts_ls", {
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
	root_dir = function(bufnr, on_dir)
		on_dir(vim.lsp.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")(buf_get_name(bufnr)))
	end,
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vim.fn.expand(
					"$HOME/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server"
				),
				languages = { "vue" },
			},
		},
	},
})
vim.lsp.enable("ts_ls")

vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {},
	},
})
vim.lsp.enable("rust_analyzer")

vim.lsp.enable("vue_ls")

vim.lsp.config("gopls", {
	settings = {
		gopls = {
			buildFlags = { "-tags=integration" },
		},
	},
})
vim.lsp.enable("gopls")

vim.lsp.enable("sqlls")
vim.lsp.enable("taplo")
vim.lsp.enable("dockerls")
vim.lsp.enable("yamlls")
vim.lsp.enable("bashls")

-- ESLint configuration
vim.lsp.config("eslint", {
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
})
vim.lsp.enable("eslint")

vim.lsp.config("html", {
	filetypes = { "html", "heex" },
})
vim.lsp.enable("html")

vim.lsp.config("tailwindcss", {
	init_options = {
		userLanguages = {
			elixir = "html-eex",
			eelixir = "html-eex",
			heex = "html-eex",
		},
	},
})
vim.lsp.enable("tailwindcss")

vim.lsp.config("jsonnet_ls", {
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
vim.lsp.enable("jsonnet_ls")

vim.lsp.config("golangci_lint_ls", {
	init_options = {
		command = { "golangci-lint", "run", "--show-stats=false", "--output.json.path", "stdout" },
	},
})
vim.lsp.enable("golangci_lint_ls")

vim.lsp.config("zls", {
	cmd = { "zls" },
	filetypes = { "zig" },
})
vim.lsp.enable("zls")

local configs = vim.lsp.config._configs
local lexical_config = {
	filetypes = { "elixir", "eelixir", "heex" },
	cmd = { "lexical" },
	settings = {},
}

vim.lsp.enable("lexical")

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
--
-- lspconfig.lexical.setup({})

local util = lspconfig.util

-- lspconfig.vacuum.setup({
vim.lsp.config("vacuum", {
	cmd = { "vacuum", "language-server" },
	filetypes = { "yaml.openapi", "json.openapi" },
	root_dir = function(bufnr, on_dir)
		on_dir(vim.lsp.util.util.find_git_ancestor)(buf_get_name(bufnr))
	end,

	single_file_support = true,
})
vim.lsp.enable("vacuum")

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

-- Disable diagnostics in .env files
local group = vim.api.nvim_create_augroup("__env", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.env",
	group = group,
	callback = function(args)
		vim.diagnostic.disable(args.buf)
	end,
})

-- Use LspAttach autocommand to only map the following keys
-- Server-specific settings. See `:help lspconfig-setup`
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
