# dotfiles

Configs for my nvim environment :)

### Theme: [solarized-osaka](https://github.com/craftzdog/solarized-osaka.nvim) (transparent)

### Framework: [LazyVim](https://github.com/LazyVim/LazyVim) + [lazy.nvim](https://github.com/folke/lazy.nvim)

## Homebrew Plugins

- cmatrix: Console Matrix
- commitizen: Defines a standard way of committing rules and communicating it
- eza: Modern, maintained replacement for ls
- git: Distributed revision control system
- graphicsmagick: Image processing tools collection
- lazygit: Simple terminal UI for git commands
- neovim: Ambitious Vim-fork focused on extensibility and agility
- node: Platform built on V8 to build network applications
- nvm: Manage multiple Node.js versions
- pnpm: Fast, disk space efficient package manager
- pyenv: Python version management
- ripgrep: Search tool like grep and The Silver Searcher
- starship: Cross-shell prompt for astronauts
- vips: Image processing library
- wget: Internet file retriever

## Nvim Plugins

| Plugin | Purpose |
|--------|---------|
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder (files, grep, buffers, diagnostics) |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | Native FZF sorter for Telescope |
| [telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim) | File browser inside Telescope |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | Tree-style file explorer |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion engine |
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | GitHub Copilot integration |
| [copilot-cmp](https://github.com/zbirenbaum/copilot-cmp) | Copilot as a completion source |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting & indentation |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Pretty diagnostics list |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug Adapter Protocol client |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | DAP UI panels |
| [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) | Python debug adapter |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | LSP/linter/formatter/debugger installer |
| [incline.nvim](https://github.com/b0o/incline.nvim) | Floating filename statuslines |
| [git-blame-line.nvim](https://github.com/kessejones/git-blame-line.nvim) | Inline git blame |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File type icons |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [lspkind.nvim](https://github.com/onsails/lspkind.nvim) | VS Code-like pictograms in completion |

## LazyVim Extras

- `lang.typescript` — TypeScript/tsserver LSP
- `lang.tailwind` — Tailwind CSS LSP
- `lang.json` — jsonls + SchemaStore
- `formatting.prettier` — Prettier formatter
- `linting.eslint` — ESLint linter
- `util.mini-hipatterns` — Highlight patterns (color codes, etc.)

## LSP / Formatters / Linters

- **LSP**: tsserver, tailwindcss, jsonls, eslint, lua_ls
- **Formatters**: Prettier, StyLua, shfmt
- **Linters**: ESLint, shellcheck, flake8
- **Debuggers**: debugpy (Python)
