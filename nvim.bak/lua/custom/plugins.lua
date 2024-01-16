local plugins = {
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function ()
      require "custom.configs.lint"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed ={
        "typescript-language-server",
        "eslint-lsp",
        "prettier"
      } 
    }
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "plugins.configs.lspconfig"
    end,
  }
}

return plugins
