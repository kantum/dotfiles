require("nvim-tree").setup()

vim.cmd.nnoremap("<leader>l", ":NvimTreeToggle<cr>")

vim.cmd.nnoremap("<leader>n", ":set number! | set relativenumber!<cr>")
