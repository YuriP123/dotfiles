return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "python",
        "javascript",
        "typescript",
        "html",
        "css",
        "json",
        "markdown",
        "markdown_inline",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
    end,
  },
}
