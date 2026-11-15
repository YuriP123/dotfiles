return {
  -- LazyVim's Copilot extra feeds Blink's completion menu. Disable the legacy
  -- Vimscript and nvim-cmp adapters so only one Copilot client is active.
  { "github/copilot.vim", enabled = false },
  { "zbirenbaum/copilot-cmp", enabled = false },
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        ghost_text = { enabled = false },
      },
    },
  },
}
