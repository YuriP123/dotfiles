return {
  -------------- startup logo ------------------
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
                                                                              
      _/_/_/  _/                                                      _/      
   _/        _/    _/_/      _/_/    _/_/_/    _/_/_/      _/_/    _/_/_/_/   
    _/_/    _/  _/_/_/_/  _/_/_/_/  _/    _/  _/    _/  _/_/_/_/    _/        
       _/  _/  _/        _/        _/    _/  _/    _/  _/          _/         
_/_/_/    _/    _/_/_/    _/_/_/  _/_/_/    _/    _/    _/_/_/      _/_/      
                                 _/                                           
                                _/                                            
      ]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },
  --------------------- incline -------------------
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = function()
      require("incline").setup({
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = { cursorline = true },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim.buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+]" .. filename
          end
        end,
      })
    end,
  },
}
