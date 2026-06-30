-- neo-tree: file explorer (replaces NERDTree). F3 keeps your old toggle.
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<F3>", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
      { "<leader>fe", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
      { "<leader>fE", "<cmd>Neotree reveal<cr>", desc = "Reveal current file" },
    },
    opts = {
      close_if_last_window = true,
      popup_border_style = "rounded",
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = { "__pycache__", ".git", "target", "node_modules", ".mypy_cache" },
        },
      },
      window = { width = 30 },
      default_component_configs = {
        indent = { with_expanders = true },
      },
    },
  },
}
