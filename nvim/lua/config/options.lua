-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

--Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Use one picker and one project root for files, grep, and the explorer.
vim.g.lazyvim_picker = "telescope"
vim.g.root_spec = { ".git", { "package.json", "pyproject.toml", "Cargo.toml", "go.mod", "Makefile" }, "lsp", "cwd" }
-- Put Copilot in Blink's completion menu, without inline ghost text.
vim.g.ai_cmp = true
