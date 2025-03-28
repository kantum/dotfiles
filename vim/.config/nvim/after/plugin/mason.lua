require("mason").setup()
require("mason-lspconfig").setup({
	automatic_installation = true,
	ensure_installed = {
		"bashls",
		"dockerls",
		"eslint",
		"gopls",
		"pyright",
		"rust_analyzer",
		"sqlls",
		"jsonnet_ls",
		"ts_ls",
		"volar",
		"yamlls",
		"taplo",
	},
	handlers = {
		vim.lsp.default_setup,
	},
})
