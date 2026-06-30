-- ****************
-- Strider's init.lua  (Neovim 0.11+)
-- ****************
--
-- A modern, Lua-based config. Plugin manager: lazy.nvim.
-- Layout:
--   lua/config/   -> options, keymaps, autocmds, lazy bootstrap
--   lua/plugins/  -> one file per concern, each returns a lazy.nvim spec
--
-- Leader is set first (in config.options) so it is correct before any
-- plugin or keymap is registered.

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
