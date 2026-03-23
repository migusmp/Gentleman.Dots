-- Ensure treesitter parser directory is in runtimepath before any plugin loading
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/site")

-- Configure Node.js before loading plugins
require("config.nodejs").setup({ silent = true })

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0
