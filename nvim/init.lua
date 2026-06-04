-- bootstrap lazy.nvim, LazyVim and your plugins
vim.g.maplocalleader = ","
require("config.lazy")
local opts = { noremap = true, silent = true }
vim.g.python3_host_prog = vim.fn.expand("~/.venvs/nvim/bin/python")

-- Stop Neovim from auto-continuing comments
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
})
