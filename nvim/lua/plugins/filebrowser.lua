return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  {
    "zchown/nvim-ipynb",
    ft = { "ipynb", "python" },
    config = function()
      require("ipynb").setup()
    end,
  },
}
