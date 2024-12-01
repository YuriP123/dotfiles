return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      -- Open/close UI automatically
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.after.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.after.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Keybindings
      vim.keymap.set("n", "<Leader>dt", function()
        dap.toggle_breakpoint()
      end, { desc = "Toggle DAP breakpoint" })

      vim.keymap.set("n", "<Leader>dc", function()
        dap.continue()
      end, { desc = "continue" })

      vim.keymap.set("n", "<F10>", function()
        dap.step_over()
      end, { desc = "step over" })

      vim.keymap.set("n", "<F11>", function()
        dap.step_into()
      end, { desc = "step into" })

      vim.keymap.set("n", "<F12>", function()
        dap.step_out()
      end, { desc = "step out" })

      vim.keymap.set("n", "<Leader>dr", function()
        dap.repl.open()
      end, { desc = "DAP run" })

      vim.keymap.set("n", "<Leader>dl", function()
        dap.run_last()
      end, { desc = "DAP run last" })
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function(_, opts)
      local path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "debugpy",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
  },
  { "nvim-neotest/nvim-nio" },
}
