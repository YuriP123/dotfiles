-- LazyVim's Telescope extra owns setup, native sorting, and LSP navigation.
-- Extend its options so default integrations and keymaps stay intact.
return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function(_, opts)
    local excludes = {}
    for _, dir in ipairs({ ".git", "node_modules", ".venv", "venv", "__pycache__", ".next" }) do
      vim.list_extend(excludes, { "--glob", "!**/" .. dir .. "/**" })
    end

    opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
      path_display = { "truncate" },
      prompt_prefix = "> ",
      selection_caret = " ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",
    })
    -- Include dotfiles while respecting .gitignore. Match directory boundaries
    -- so names such as src/venv_utils.py are not accidentally filtered out.
    opts.defaults.vimgrep_arguments = vim.list_extend({
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
    }, excludes)

    opts.pickers = vim.tbl_deep_extend("force", opts.pickers or {}, {
      find_files = {
        hidden = true,
        find_command = function()
          return vim.list_extend({ "rg", "--files", "--color", "never" }, excludes)
        end,
      },
      buffers = { sort_mru = true, sort_lastused = true, ignore_current_buffer = true },
    })
    opts.extensions = vim.tbl_deep_extend("force", opts.extensions or {}, {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    })
  end,
  keys = {
    { ";f", LazyVim.pick("files"), desc = "Find files (project)" },
    { ";r", LazyVim.pick("live_grep"), desc = "Search text (project)" },
    { ";;", "<cmd>Telescope resume<cr>", desc = "Resume last search" },
    { "\\\\", "<cmd>Telescope buffers<cr>", desc = "Switch buffer (recent first)" },
    { ";e", "<cmd>Telescope diagnostics<cr>", desc = "Find diagnostics" },
    { ";s", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Find symbol in file" },
    { ";S", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Find workspace symbol" },
    -- Preserve the existing search aliases.
    { "<leader>fs", LazyVim.pick("live_grep"), desc = "Search text (project)" },
    { "<leader>flg", LazyVim.pick("live_grep"), desc = "Search text (project)" },
    { "<leader>fc", LazyVim.pick("grep_string"), desc = "Find word (project)" },
    { "<leader>fc", LazyVim.pick("grep_string"), mode = "x", desc = "Find selection (project)" },
    { "<leader>fC", LazyVim.pick.config_files(), desc = "Find Neovim config file" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    {
      "<leader>fP",
      function()
        require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
      end,
      desc = "Find plugin file",
    },
  },
}
