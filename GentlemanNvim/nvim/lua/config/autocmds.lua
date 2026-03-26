-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- nvim-treesitter doesn't auto-enable highlight for Go in Neovim 0.11.
-- Force-start the native treesitter highlighter on every Go buffer.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
