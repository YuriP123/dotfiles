return {
  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
    keys = {
      { "<leader>gD", "<cmd>CodeDiff<cr>", desc = "Review working tree (CodeDiff)" },
      { "<leader>gH", "<cmd>CodeDiff history<cr>", desc = "Review Git history (CodeDiff)" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>a", group = "agent context", mode = { "n", "x" } },
      },
    },
  },
}
