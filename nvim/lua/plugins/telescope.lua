return {
  "nvim-telescope/telescope.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",

    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },

  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        path_display = { shorten = 3 },

        prompt_prefix = "> ",
        selection_caret = " ",
        entry_prefix = "  ",

        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",

        file_ignore_patterns = {
          "node_modules",
          ".venv",
          "venv",
          "__pycache__",
          ".git/",
        },
      },

      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    pcall(telescope.load_extension, "fzf")
  end,

  keys = {
    {
      "<leader>ff",
      function()
        local root = vim.fs.root(0, {
          ".git",
          "pyproject.toml",
          "package.json",
          "Cargo.toml",
          "go.mod",
        }) or vim.fn.getcwd()

        require("telescope.builtin").find_files({
          cwd = root,
        })
      end,
      desc = "Find Files",
    },

    {
      "<leader>flg",
      function()
        local root = vim.fs.root(0, {
          ".git",
          "pyproject.toml",
          "package.json",
          "Cargo.toml",
          "go.mod",
        }) or vim.fn.getcwd()

        require("telescope.builtin").live_grep({
          cwd = root,

          additional_args = function()
            return {
              "--glob",
              "!.venv/**",
              "--glob",
              "!venv/**",
              "--glob",
              "!node_modules/**",
              "--glob",
              "!__pycache__/**",
            }
          end,
        })
      end,
      desc = "Live Grep",
    },

    {
      "<leader>fb",
      "<cmd>Telescope buffers<cr>",
      desc = "Buffers",
    },

    {
      "<leader>fh",
      "<cmd>Telescope help_tags<cr>",
      desc = "Help Tags",
    },
  },
}
