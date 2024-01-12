require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"bashls",
		"dockerls",
		"eslint",
		"gopls",
		"pyright",
		"rust_analyzer",
		"sqlls",
		"tsserver",
		"volar",
		"yamlls",
		"taplo",
	},
	handlers = {
		vim.lsp.default_setup,
	},
})
