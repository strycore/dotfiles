# Neovim config

A modern, Lua-based Neovim configuration (requires **Neovim 0.11+**).
Symlinked to `~/.config/nvim` by `install.sh`.

## Layout

```
nvim/
├── init.lua                 entrypoint
└── lua/
    ├── config/
    │   ├── options.lua       vim options (leader is set here first)
    │   ├── keymaps.lua       global keymaps
    │   ├── autocmds.lua      autocommands
    │   └── lazy.lua          lazy.nvim bootstrap + setup
    └── plugins/              one file per concern, each returns a lazy spec
        ├── colorscheme.lua   tokyonight
        ├── treesitter.lua    highlighting / indent / folds / text objects
        ├── lsp.lua           mason + native LSP (lua, python, bash, toml, json, yaml)
        ├── rust.lua          rustaceanvim (rust-analyzer + clippy)
        ├── completion.lua    blink.cmp
        ├── format.lua        conform.nvim (format on save)
        ├── telescope.lua     fuzzy finder
        ├── explorer.lua      neo-tree
        ├── git.lua           gitsigns + fugitive
        ├── statusline.lua    lualine
        └── editor.lua        which-key, mini.surround/pairs/ai, ibl, trouble, flash, todo
```

## First launch

1. `nvim` — lazy.nvim bootstraps itself, then installs all plugins.
2. mason auto-installs the language servers/formatters listed in `plugins/lsp.lua`.
3. `:checkhealth` to confirm everything is wired up.

## External dependencies

Already present on this machine: `git`, `ripgrep` (rg), `node`, `npm`, `python3`.

Install for full functionality:

```sh
# Rust toolchain + analyzer (rustaceanvim needs rust-analyzer on PATH)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rust-analyzer clippy rustfmt

# fd: faster file finding for telescope (optional but recommended)
sudo dnf install fd-find

# A Nerd Font for icons (set your terminal to use it), e.g.
sudo dnf install fira-code-fonts   # or install a Nerd Font build
```

mason handles the rest (basedpyright, ruff, lua-language-server, prettierd, stylua, shfmt, …).

## Key bindings (leader = `<space>`)

| Keys | Action |
|------|--------|
| `<C-p>` / `<leader>ff` | find files |
| `<C-f>` / `<leader>fg` | live grep |
| `<leader>fb` / `<leader>fr` | buffers / recent files |
| `<F3>` / `<leader>fe` | toggle file tree |
| `<F2>` | delete buffer |
| `<F5>` / `<F6>` / `<S-h>` / `<S-l>` | prev / next buffer |
| `grd` `grr` `grn` `gra` `K` | LSP: definition, references, rename, code action, hover |
| `[d` / `]d` | prev / next diagnostic |
| `<leader>f` | format buffer (also formats on save) |
| `<leader>xx` | diagnostics list (Trouble) |
| `<leader>h…` | git hunk actions (stage/reset/preview/blame) |
| `<leader>gs` | git status (fugitive) |
| `<leader>r…` | rust: runnables, debuggables, expand macro |
| `<leader>uh` | toggle inlay hints |
| `s` / `S` | flash jump / treesitter jump |
| `<leader>/` | clear search highlight |
| `:w!!` | save with sudo |

Press `<space>` and pause to see the which-key popup with everything else.

## Notes / migration from the old vimrc

- The old `~/.vimrc` / `~/.vim` are untouched — plain `vim` still uses them.
- Dropped from the old setup (superseded): YouCompleteMe → native LSP + blink.cmp,
  CtrlP/ag.vim → telescope, NERDTree → neo-tree, airline → lualine,
  gitgutter → gitsigns, polyglot/semantic-highlight → treesitter, ALE → conform + LSP,
  vim-surround/delimitMate → mini.nvim.
- The Python-2 virtualenv hacks and the GUI/`guifont` blocks were not ported (obsolete).
