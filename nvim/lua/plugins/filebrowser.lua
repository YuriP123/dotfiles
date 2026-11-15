return {
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    keys = {
      {
        "sf",
        function()
          local file = vim.api.nvim_buf_get_name(0)
          local path = vim.bo.buftype == "" and file ~= "" and vim.fs.dirname(file) or vim.fn.getcwd()
          require("telescope").extensions.file_browser.file_browser({
            path = path,
            cwd = LazyVim.root(),
            select_buffer = true,
            hidden = true,
            respect_gitignore = true,
          })
        end,
        desc = "Browse files beside current file",
      },
    },
    config = function()
      require("telescope").load_extension("file_browser")
    end,
  },
  {
    "zchown/nvim-ipynb",
    ft = { "ipynb", "python" },
    config = function()
      require("ipynb").setup()
    end,
  },
}
