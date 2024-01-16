-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

---- Nvim discipline ----
local discipline = require("yuri.discipline")
discipline.cowboy()

---- Basic Keymaps ---
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

--delete word backwards
keymap.set("n", "dw", "vb_d")

--select all
keymap.set("n", "<C-a>", "gg<S-v>G")

--new tab
keymap.set("n", "te", "tabedit", opts)
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

--split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

--window travseral
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

--diagnostics
keymap.set("n", "C-j", function()
  vim.diagnostic.goto_next()
end, opts)

--live_grep
keymap.set("n", "<leader>flg", ":Telescope live_grep<Return>", opts)
