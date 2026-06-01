-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
local opts = { noremap = true, silent = true }
vim.g.python3_host_prog = vim.fn.expand("~/.venvs/nvim/bin/python")
