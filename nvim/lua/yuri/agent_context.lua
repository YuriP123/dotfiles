local M = {}

-- Use the repository root so references also work in the separate agent pane.
local function file_path(absolute)
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" or vim.bo.buftype ~= "" then
    vim.notify("Open a file before copying agent context", vim.log.levels.WARN)
    return
  end

  local path = vim.fs.normalize(name)
  if absolute then
    return path
  end

  local root = vim.fs.root(path, ".git") or vim.fn.getcwd()
  local prefix = vim.fs.normalize(root):gsub("/$", "") .. "/"
  return path:sub(1, #prefix) == prefix and path:sub(#prefix + 1) or path
end

local function copy(text)
  if not text then
    return
  end
  vim.fn.setreg('"', text)
  local ok = pcall(vim.fn.setreg, "+", text)
  vim.notify(ok and ("Copied: " .. text) or "Copied to the unnamed register; system clipboard unavailable")
end

function M.copy_path(absolute)
  copy(file_path(absolute))
end

function M.copy_reference(visual)
  local path = file_path(false)
  if not path then
    return
  end

  local first = vim.fn.line(".")
  local last = visual and vim.fn.line("v") or first
  first, last = math.min(first, last), math.max(first, last)
  local lines = first == last and tostring(first) or (first .. "-" .. last)
  copy(path .. ":" .. lines)
end

return M
