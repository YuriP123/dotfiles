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
keymap.set("n", "te", "<cmd>tabnew<cr>", { desc = "New tab" })
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Tab occupies Ctrl-i in many terminals; keep both jumplist directions usable.
keymap.set("n", "[j", "<C-o>", { desc = "Jump back" })
keymap.set("n", "]j", "<C-i>", { desc = "Jump forward" })

--split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

--window travseral
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- =========================================================
-- Molten
-- =========================================================

vim.g.molten_output_is_open = false
vim.g.molten_output_pinned = false

local function hide_molten_output()
  vim.g.molten_output_is_open = false

  if vim.fn.exists(":MoltenHideOutput") == 2 then
    pcall(vim.cmd, "MoltenHideOutput")
  end
end

local function show_molten_output()
  if vim.fn.exists(":MoltenShowOutput") == 2 then
    pcall(vim.cmd, "MoltenShowOutput")
    vim.g.molten_output_is_open = true
  end
end

local function hide_molten_output_if_not_pinned()
  if not vim.g.molten_output_pinned then
    hide_molten_output()
  end
end

-- Init Python kernel
vim.keymap.set("n", "<leader>mi", "<Cmd>MoltenInit python3<CR>", {
  desc = "Molten init Python kernel",
  silent = true,
})

-- Run current line
vim.keymap.set("n", "<leader>ml", function()
  vim.cmd("MoltenEvaluateLine")

  vim.defer_fn(function()
    hide_molten_output_if_not_pinned()
  end, 150)
end, {
  desc = "Molten run line",
  silent = true,
})

-- Run visual selection
vim.keymap.set("v", "<leader>me", ":<C-u>MoltenEvaluateVisual<CR>gv", {
  desc = "Molten run selection",
  silent = true,
})

-- Rerun current Molten cell
vim.keymap.set("n", "<leader>mr", function()
  vim.cmd("MoltenReevaluateCell")

  vim.defer_fn(function()
    hide_molten_output_if_not_pinned()
  end, 150)
end, {
  desc = "Molten rerun cell",
  silent = true,
})

-- Restart kernel
vim.keymap.set("n", "<leader>mR", "<Cmd>MoltenRestart!<CR>", {
  desc = "Molten restart kernel",
  silent = true,
})

-- Delete current cell output
vim.keymap.set("n", "<leader>md", "<Cmd>MoltenDelete<CR>", {
  desc = "Molten delete cell",
  silent = true,
})

-- Delete all cell outputs
vim.keymap.set("n", "<leader>mD", "<Cmd>MoltenDelete!<CR>", {
  desc = "Molten delete all cells",
  silent = true,
})

-- Change kernel
vim.keymap.set("n", "<leader>mk", function()
  pcall(vim.cmd, "MoltenDeinit")
  vim.schedule(function()
    vim.cmd("MoltenInit")
  end)
end, {
  desc = "Molten: Repick Kernel",
})

-- Show output temporarily
vim.keymap.set("n", "<leader>mo", function()
  vim.g.molten_output_pinned = false
  show_molten_output()
end, {
  desc = "Molten show output",
  silent = true,
})

-- Hide output manually
vim.keymap.set("n", "<leader>mh", function()
  vim.g.molten_output_pinned = false
  hide_molten_output()
end, {
  desc = "Molten hide output",
  silent = true,
})

-- Toggle pinned output
vim.keymap.set("n", "<leader>mt", function()
  if vim.g.molten_output_pinned then
    vim.g.molten_output_pinned = false
    hide_molten_output()
    vim.notify("Molten output unpinned")
  else
    vim.g.molten_output_pinned = true
    show_molten_output()
    vim.notify("Molten output pinned")
  end
end, {
  desc = "Molten toggle pinned output",
  silent = true,
})

-- Run current # %% cell
local function molten_run_current_cell()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")

  local start_line = 1
  local end_line = total_lines

  -- Find previous # %% marker
  for line = current_line, 1, -1 do
    local text = vim.fn.getline(line)

    if text:match("^%s*#%s*%%%%") then
      start_line = line + 1
      break
    end
  end

  -- Find next # %% marker
  for line = current_line + 1, total_lines do
    local text = vim.fn.getline(line)

    if text:match("^%s*#%s*%%%%") then
      end_line = line - 1
      break
    end
  end

  if start_line > end_line then
    vim.notify("No code found in this cell", vim.log.levels.WARN)
    return
  end

  vim.fn.MoltenEvaluateRange(start_line, end_line)

  -- Hide output after running unless pinned
  vim.defer_fn(function()
    hide_molten_output_if_not_pinned()
  end, 200)
end

vim.keymap.set("n", "<leader>mc", molten_run_current_cell, {
  desc = "Molten run current cell",
  silent = true,
})

-- Run all # %% cells
local function molten_run_all_cells()
  local total_lines = vim.fn.line("$")
  local ranges = {}
  local start_line = 1

  for line = 1, total_lines do
    local text = vim.fn.getline(line)

    if text:match("^%s*#%s*%%%%") then
      if line > start_line then
        table.insert(ranges, { start_line, line - 1 })
      end

      start_line = line + 1
    end
  end

  if start_line <= total_lines then
    table.insert(ranges, { start_line, total_lines })
  end

  for _, range in ipairs(ranges) do
    local first = range[1]
    local last = range[2]

    if first <= last then
      vim.fn.MoltenEvaluateRange(first, last)
    end
  end

  -- Hide output after running all unless pinned
  vim.defer_fn(function()
    hide_molten_output_if_not_pinned()
  end, 500)
end

vim.keymap.set("n", "<leader>ma", molten_run_all_cells, {
  desc = "Molten run all cells",
  silent = true,
})

-- Automatically hide output when moving unless pinned
local molten_hide_group = vim.api.nvim_create_augroup("MoltenAutoHideOutput", {
  clear = true,
})

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "WinScrolled" }, {
  group = molten_hide_group,
  callback = function()
    hide_molten_output_if_not_pinned()
  end,
})

vim.keymap.set("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>", {
  desc = "Enter Molten output",
  silent = true,
})

vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>", {
  desc = "Hide Molten output",
  silent = true,
})

-- Create new Python notebook cell below
vim.keymap.set("n", "<leader>nc", "o# %%<Esc>o", {
  desc = "New notebook cell below",
  silent = true,
})

-- Create new Python notebook cell above
vim.keymap.set("n", "<leader>nC", "O# %%<Esc>O", {
  desc = "New notebook cell above",
  silent = true,
})

-- clear tag stack
vim.keymap.set("n", "<leader>tc", "<cmd>delmarks!<CR>", { desc = "Delete all marks" })

vim.keymap.set("n", "<leader>ci", function()
  vim.cmd("botright 15split")
  vim.fn.termopen({
    "codex",
    "--sandbox",
    "read-only",
    "--ask-for-approval",
    "never",
  })
  vim.cmd("startinsert")
end, { desc = "Open Codex" })

-- Copy references for the Codex session running in a separate tmux pane.
keymap.set("n", "<leader>ay", function()
  require("yuri.agent_context").copy_path(false)
end, { desc = "Copy repo-relative file path" })

keymap.set("n", "<leader>aY", function()
  require("yuri.agent_context").copy_path(true)
end, { desc = "Copy absolute file path" })

keymap.set("n", "<leader>al", function()
  require("yuri.agent_context").copy_reference(false)
end, { desc = "Copy file:line for agent" })

keymap.set("x", "<leader>al", function()
  require("yuri.agent_context").copy_reference(true)
end, { desc = "Copy file:line-range for agent" })
