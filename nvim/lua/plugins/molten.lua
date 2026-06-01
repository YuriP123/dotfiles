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
      vim.g.molten_image_provider = "image.nvim"

      vim.g.molten_auto_open_output = true
      vim.g.molten_virt_text_output = false

      vim.g.molten_image_location = "float"
      vim.g.molten_output_win_max_height = 30
      vim.g.molten_output_win_max_width = 120
      vim.g.molten_wrap_output = true

      -- Keep this while testing
      vim.g.molten_show_mimetype_debug = true

      -- Avoid border/footer bugs for now
      vim.g.molten_output_show_more = false
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
