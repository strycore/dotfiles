-- Vim options. Leader MUST be set before lazy/plugins load.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- == User interface
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes" -- avoid layout shift when diagnostics appear
opt.termguicolors = true
opt.showmode = false -- the statusline shows the mode
opt.cmdheight = 1
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.title = true
opt.laststatus = 3 -- single global statusline
opt.colorcolumn = "100"
opt.mouse = "a"
opt.confirm = true -- ask to save instead of erroring
opt.pumheight = 12 -- max items in completion popup

-- Invisible characters (ported from your vimrc)
opt.list = true
opt.listchars = { tab = "→ ", trail = "␣", extends = "…", nbsp = "␣" }
opt.fillchars = { eob = " ", vert = "▕" }

-- == Indentation and tabs (your defaults: 4-space soft tabs)
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.smartindent = true
opt.breakindent = true

-- == Searching
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.inccommand = "split" -- live preview of :substitute

-- == Folding (treesitter-driven, opened by default)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = ""
opt.foldlevel = 99
opt.foldlevelstart = 99

-- == Files / persistence
opt.swapfile = false
opt.backup = false
opt.undofile = true -- persistent undo across sessions
opt.autoread = true

-- == Splits
opt.splitright = true
opt.splitbelow = true

-- == Completion
opt.completeopt = { "menu", "menuone", "noselect" }

-- == Clipboard: integrate with the system clipboard
opt.clipboard = "unnamedplus"

-- == Misc
opt.updatetime = 250
opt.timeoutlen = 400
opt.history = 1000
opt.undolevels = 1000
opt.iskeyword:append("-") -- treat foo-bar as one word
