# dotfiles

Configs for my nvim environment :)

### Framework: [LazyVim](https://github.com/LazyVim/LazyVim) + [lazy.nvim](https://github.com/folke/lazy.nvim)

Leader is `<Space>`, local leader is `,`.

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
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | Tree-style file explorer (dotfiles shown, gitignored hidden) |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion engine |
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | GitHub Copilot integration |
| [copilot-cmp](https://github.com/zbirenbaum/copilot-cmp) | Copilot as a completion source |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting & indentation |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Add/change/delete surrounding pairs |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Pretty diagnostics list |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug Adapter Protocol client |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | DAP UI panels |
| [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) | Python debug adapter |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | LSP/linter/formatter/debugger installer |
| [incline.nvim](https://github.com/b0o/incline.nvim) | Floating filename statuslines |
| [mini.animate](https://github.com/nvim-mini/mini.animate) | Animations (scroll disabled) |
| [git-blame-line.nvim](https://github.com/kessejones/git-blame-line.nvim) | Inline git blame |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File type icons |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [lspkind.nvim](https://github.com/onsails/lspkind.nvim) | VS Code-like pictograms in completion |
| [molten-nvim](https://github.com/benlubas/molten-nvim) | Jupyter kernel integration for in-editor code execution |
| [image.nvim](https://github.com/3rd/image.nvim) | Renders plots/images inline (kitty backend, `magick_cli`) |
| [nvim-ipynb](https://github.com/zchown/nvim-ipynb) | Open and edit `.ipynb` notebooks |

> Molten requires a Python provider with `pynvim` and `jupyter` installed, plus a
> terminal with image support (e.g. kitty). Run `:UpdateRemotePlugins` after install.

### Disabled

- `flash.nvim` — disabled
- `fzf-lua` — disabled (Telescope is used instead)

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

## Keymaps

### General

| Key | Action |
|-----|--------|
| `dw` | Delete word backwards |
| `<C-a>` | Select all |
| `te` | New tab |
| `<Tab>` / `<S-Tab>` | Next / previous tab |
| `ss` / `sv` | Horizontal / vertical split |
| `sh` `sj` `sk` `sl` | Move between windows |

### Telescope

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files in cwd |
| `<leader>fr` | Recent files |
| `<leader>fs` / `;r` | Live grep |
| `<leader>fc` | Grep string under cursor |
| `;f` | Find files (incl. hidden) |
| `;e` | Diagnostics |
| `;s` | Treesitter symbols |
| `\\` | Buffers |

### Molten (Jupyter)

| Key | Action |
|-----|--------|
| `<leader>mi` | Init Python kernel |
| `<leader>ml` | Run current line |
| `<leader>me` (visual) | Run selection |
| `<leader>mc` | Run current `# %%` cell |
| `<leader>ma` | Run all `# %%` cells |
| `<leader>mr` | Rerun cell |
| `<leader>mR` | Restart kernel |
| `<leader>md` / `<leader>mD` | Delete cell / all cell outputs |
| `<leader>mo` / `<leader>mh` | Show / hide output |
| `<leader>mt` | Toggle pinned output |
| `<leader>nc` / `<leader>nC` | New `# %%` cell below / above |
| `<localleader>os` | Enter Molten output window |

### Debug (DAP)

| Key | Action |
|-----|--------|
| `<leader>dt` | Toggle breakpoint |
| `<leader>dc` | Continue |
| `<leader>dr` | Open REPL |
| `<leader>dl` | Run last |
| `<F10>` / `<F11>` / `<F12>` | Step over / into / out |
