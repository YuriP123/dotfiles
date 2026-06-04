return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    lazy = false,
    build = ":UpdateRemotePlugins",
    dependencies = {
      "3rd/image.nvim",
    },
    init = function()
      -- Important: use a border TABLE, not "rounded",
      -- to avoid Molten's border/footer indexing crash.
      vim.g.molten_output_win_border = {
        { "╭", "MoltenOutputBorder" },
        { "─", "MoltenOutputBorder" },
        { "╮", "MoltenOutputBorder" },
        { "│", "MoltenOutputBorder" },
        { "╯", "MoltenOutputBorder" },
        { "─", "MoltenOutputBorder" },
        { "╰", "MoltenOutputBorder" },
        { "│", "MoltenOutputBorder" },
      }

      -- Image/plot rendering
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_image_location = "float"

      -- Notebook-style behavior
      vim.g.molten_auto_open_output = true
      vim.g.molten_virt_text_output = false
      vim.g.molten_output_virt_lines = true
      vim.g.molten_cover_empty_lines = true

      -- Long output behavior
      vim.g.molten_output_win_max_height = 25
      vim.g.molten_output_win_max_width = 120
      vim.g.molten_wrap_output = true
      vim.g.molten_output_show_more = true
      vim.g.molten_floating_window_focus = "bottom"

      -- Raise this if you print very large outputs.
      -- Molten's default is already 1,000,000 chars, but this gives more room.
      vim.g.molten_limit_output_chars = 10000000

      -- UI/debug
      vim.g.molten_output_win_style = "minimal"
      vim.g.molten_show_mimetype_debug = false
    end,
  },

  {
    "3rd/image.nvim",
    opts = {
      backend = "kitty",
      processor = "magick_cli",

      integrations = {},

      max_width = 160,
      max_height = 35,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,

      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = {
        "cmp_menu",
        "cmp_docs",
        "",
      },

      tmux_show_only_in_active_window = true,
    },
  },
}
