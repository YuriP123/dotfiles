local function leave_debug_zoom()
  local snacks = rawget(_G, "Snacks")
  if snacks and snacks.zen.win and snacks.zen.win:valid() then
    snacks.zen.win:close()
    return true
  end
  return false
end

local function open_debug_ui()
  leave_debug_zoom()
  local dapui = require("dapui")
  -- Closing a single pane can leave stale window IDs in dap-ui's layout.
  if not pcall(dapui.open, { reset = true }) then
    dapui.close()
    dapui.open({ reset = true })
  end
end

local function show_debug_repl(focus)
  open_debug_ui()
  if focus then
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "dap-repl" then
        vim.api.nvim_set_current_win(win)
        return
      end
    end
  end
end

local exception_pauses_enabled = false
local exception_condition = [[!(error && error.code === "ERR_INVALID_ARG_TYPE" && /emitter/.test(error.message))]]

local function set_exception_pauses(enabled, session, quiet)
  session = session or require("dap").session()
  if not session then
    vim.notify("No debugger attached. Attach first with <leader>da.", vim.log.levels.WARN)
    return
  end

  local filters = {}
  if enabled then
    for _, filter in ipairs(session.capabilities.exceptionBreakpointFilters or {}) do
      if filter.filter == "all" or filter.filter == "caught" then
        filters = { filter.filter }
        break
      end
    end
    if #filters == 0 then
      vim.notify("This adapter does not advertise caught-exception pauses.", vim.log.levels.WARN)
      return
    end
  end

  local args = { filters = filters }
  if enabled and session.config.type == "pwa-node" then
    if not session.capabilities.supportsExceptionFilterOptions then
      vim.notify("This adapter does not support conditional exception filters.", vim.log.levels.WARN)
      return
    end
    args = {
      filters = {},
      filterOptions = { { filterId = "all", condition = exception_condition } },
    }
  end
  session:request("setExceptionBreakpoints", args, function(err, response)
    vim.schedule(function()
      if err then
        vim.notify("Could not configure exception pauses: " .. (err.message or vim.inspect(err)), vim.log.levels.ERROR)
        return
      end
      for _, breakpoint in ipairs(response and response.breakpoints or {}) do
        if breakpoint.verified == false then
          vim.notify("Exception pause not verified: " .. (breakpoint.message or "adapter rejected filter"), vim.log.levels.WARN)
          return
        end
      end
      if session.config.type == "pwa-node" then
        exception_pauses_enabled = enabled
      else
        require("dap").defaults[session.config.type].exception_breakpoints = filters
      end
      if not quiet then
        vim.notify(enabled and "Exception pauses enabled (Node emitter noise filtered)."
          or "Exception pauses disabled. Use <leader>dc to resume.", vim.log.levels.INFO)
      end
    end)
  end)
end

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
    },
    keys = {
      {
        "<leader>dR",
        function()
          local dap = require("dap")
          local session = dap.session()
          if session and session.config.request == "attach" then
            local config = vim.deepcopy(session.config)
            dap.disconnect({ terminateDebuggee = false }, function()
              vim.schedule(function()
                dap.run(config)
              end)
            end)
          else
            dap.restart()
          end
        end,
        desc = "Debug: restart session / reattach",
      },
      {
        "<leader>dq",
        function()
          require("dap").disconnect({ terminateDebuggee = false })
        end,
        desc = "Debug: disconnect",
      },
      {
        "<leader>da",
        function()
          for _, config in ipairs(require("dap").configurations[vim.bo.filetype] or {}) do
            if config.name == "Attach to Next.js server (port)" then
              require("dap").run(config)
              return
            end
          end
          vim.notify("Open a JavaScript or TypeScript file first", vim.log.levels.WARN)
        end,
        desc = "Debug: attach to Next.js server",
      },
      {
        "<leader>du",
        function()
          leave_debug_zoom()
          for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local ft = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
            if ft == "dap-repl" or ft:match("^dapui_") then
              require("dapui").close()
              return
            end
          end
          open_debug_ui()
        end,
        desc = "Debug: toggle panels",
      },
      {
        "<leader>dt",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle DAP breakpoint",
      },
      {
        "<leader>de",
        function()
          set_exception_pauses(true)
        end,
        desc = "Debug: pause on caught exceptions",
      },
      {
        "<leader>dE",
        function()
          set_exception_pauses(false)
        end,
        desc = "Debug: disable exception pauses",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Debug: launch / attach / continue",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: step over",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: step over",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: step into",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Debug: step out",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: step into",
      },
      {
        "<F12>",
        function()
          require("dap").step_out()
        end,
        desc = "Debug: step out",
      },
      {
        "<leader>dr",
        function()
          show_debug_repl(true)
        end,
        desc = "Debug: focus REPL panel",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Debug: run last",
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("DebugPanelKeys", { clear = true }),
        pattern = { "dapui_*", "dap-repl" },
        callback = function(event)
          local function close_panel()
            if not leave_debug_zoom() then
              dapui.close()
            end
          end
          for _, key in ipairs({ "zq", "ZQ" }) do
            vim.keymap.set("n", key, close_panel, {
              buffer = event.buf,
              desc = "Debug: leave zoom / close panels",
            })
          end
        end,
      })
      dapui.setup()
      dap.set_log_level("TRACE")
      -- Apply the conditional filter after dap's initial breakpoint configuration.
      dap.defaults["pwa-node"].exception_breakpoints = {}
      dap.listeners.after.configurationDone["exception_filter"] = function(session, err)
        if not err and session.config.type == "pwa-node" then
          set_exception_pauses(exception_pauses_enabled, session, true)
        end
      end

      dap.listeners.after.event_stopped["exception_message"] = function(session, body)
        if body.reason ~= "exception" then
          return
        end
        local function show(message)
          vim.schedule(function()
            local text = "Debugger paused on exception:\n" .. message
            dap.repl.append(text)
            show_debug_repl(false)
            vim.notify(text, vim.log.levels.WARN)
          end)
        end
        local fallback = body.text or body.description or "Inspect the stopped frame for details."
        if not session.capabilities.supportsExceptionInfoRequest or not body.threadId then
          show(fallback)
          return
        end
        session:request("exceptionInfo", { threadId = body.threadId }, function(err, info)
          if err or not info then
            show(fallback)
            return
          end
          show((info.details and info.details.message) or info.description or info.exceptionId or fallback)
        end)
      end

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
          args = { "${port}", "127.0.0.1" },
        },
      }

      for _, language in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to Next.js server (port)",
            address = "127.0.0.1",
            port = function()
              local port = tonumber(vim.fn.input("Node inspector port: ", "9230"))
              assert(port and port >= 1 and port <= 65535, "Enter a valid inspector port")
              return port
            end,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            -- Include async/library throws while diagnosing API failures.
            skipFiles = {},
            smartStep = false,
            trace = true,
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to Node.js process",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
          },
        }
        if language == "javascript" then
          table.insert(dap.configurations[language], {
            type = "pwa-node",
            request = "launch",
            name = "Launch current file (Node.js)",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            console = "integratedTerminal",
            skipFiles = { "<node_internals>/**" },
          })
        end
      end

      -- Keep the output visible after a session ends to inspect errors.
      dap.listeners.after.event_initialized["dapui_config"] = function()
        open_debug_ui()
      end
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
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "debugpy",
        "js-debug-adapter",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
  },
  { "nvim-neotest/nvim-nio" },
}
