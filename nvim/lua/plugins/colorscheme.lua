-- Colorscheme. tokyonight is a clean, well-maintained default.
-- Swap `style` to "storm" / "moon" / "day", or replace the whole plugin
-- with catppuccin / kanagawa / gruvbox-material to taste.
return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000, -- load before everything else
    opts = {
      style = "night",
      transparent = false,
      styles = {
        comments = { italic = true },
        keywords = { italic = false },
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
