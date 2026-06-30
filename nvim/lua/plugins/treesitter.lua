-- Treesitter: syntax-aware highlighting, indentation, folding, text objects.
-- Replaces vim-polyglot and semantic-highlight.vim from the old setup.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- Pin the stable master API. nvim-treesitter's default branch is now the
    -- `main` rewrite, whose highlight/indent/textobjects are still experimental
    -- and use a different API than the opts below.
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "master" },
    },
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "rust", "python", "lua", "luadoc", "bash", "c", "toml",
        "yaml", "json", "json5", "jsonc", "markdown", "markdown_inline",
        "html", "css", "scss", "javascript", "typescript", "tsx", "vue",
        "vimdoc", "query", "regex", "diff", "git_rebase", "gitcommit",
        "dockerfile", "ninja", "rst", "ssh_config",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
        },
      },
    },
  },
}
