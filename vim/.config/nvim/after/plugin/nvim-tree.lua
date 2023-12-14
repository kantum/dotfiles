require("nvim-tree").setup()

vim.cmd.nnoremap("<leader>l", ":NvimTreeToggle<cr>")

vim.api.nvim_create_autocmd("User", {
	pattern = "NeogitStatusRefreshed",
	command = "NvimTreeRefresh",
})
