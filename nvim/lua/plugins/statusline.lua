-- lualine: statusline (replaces vim-airline).
return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "tokyonight",
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_b = { "branch", "diff" },
        lualine_c = { { "filename", path = 1 } }, -- relative path
        lualine_x = {
          "diagnostics",
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
      },
    },
  },
}
