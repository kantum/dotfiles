-- Map <C-s> to save, on mac add \<C-s> keybinding to iterm2 to use command-s
vim.cmd.noremap("<silent> <C-S>  :update<CR>")
vim.cmd.vnoremap("<silent> <C-S> <C-C>:update<CR>")
vim.cmd.inoremap("<silent> <C-S> <Esc>:update<CR>")

-- Edit init.lua
vim.cmd.nnoremap("<leader>ei", ":vs $MYVIMRC<cr>")
vim.cmd.nnoremap("<leader>si", ":so $MYVIMRC<cr>")

vim.cmd.nnoremap("<leader>ep", ":vs ~/.config/nvim/lua/plugins.lua<cr>")
vim.cmd.nnoremap("<leader>p", ":Lazy<cr>")

