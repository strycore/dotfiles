-- Autocommands.
local function augroup(name)
  return vim.api.nvim_create_augroup("config_" .. name, { clear = true })
end

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Trim trailing whitespace on save (ported). Skip markdown (trailing
-- spaces are meaningful) and let formatters own filetypes they handle.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("trim_whitespace"),
  callback = function()
    if vim.bo.filetype == "markdown" then
      return
    end
    local view = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- 2-space indentation for web / config filetypes (ported from your vimrc)
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("indent_two_spaces"),
  pattern = {
    "yaml", "html", "htmldjango", "css", "scss", "less",
    "javascript", "typescript", "typescriptreact", "vue",
    "json", "jsonc", "lua", "ruby",
  },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
  end,
})

-- Makefiles require real tabs
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("makefile_tabs"),
  pattern = "make",
  callback = function()
    vim.bo.expandtab = false
    vim.bo.tabstop = 8
    vim.bo.shiftwidth = 8
  end,
})

-- Restore cursor to last edit position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    if vim.bo[event.buf].filetype == "gitcommit" then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(event.buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close utility buffers with q
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = { "help", "qf", "man", "lspinfo", "checkhealth", "trouble", "fugitive" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
