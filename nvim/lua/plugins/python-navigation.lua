return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- Definitions, references, and symbols for Python. LazyVim manages the
      -- server through Mason; Molten continues to manage notebook execution.
      pyright = {},
    },
  },
}
