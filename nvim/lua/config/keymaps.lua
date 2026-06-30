-- Global keymaps. Plugin-specific maps live with their plugin spec.
local map = vim.keymap.set

-- Clear search highlight (your <leader>/)
map("n", "<leader>/", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Move by visual line when no count is given
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Buffers (F5/F6 ported from your vimrc, plus S-h/S-l)
map("n", "<F5>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<F6>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<F2>", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Move lines up/down
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Keep cursor centered on big jumps / search
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Keep selection when indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Save with sudo (your :w!!)
map("c", "w!!", "w !sudo tee % > /dev/null", {})

-- Edit / reload config
map("n", "<leader>e", "<cmd>edit $MYVIMRC<cr>", { desc = "Edit config" })

-- Diagnostics (0.11 API)
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Prev diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })

-- Toggle a few options
map("n", "<leader>uw", "<cmd>set wrap!<cr>", { desc = "Toggle wrap" })
map("n", "<leader>ul", "<cmd>set list!<cr>", { desc = "Toggle invisible chars" })
map("n", "<leader>us", "<cmd>set spell!<cr>", { desc = "Toggle spell" })
