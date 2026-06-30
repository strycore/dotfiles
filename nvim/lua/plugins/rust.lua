-- rustaceanvim: batteries-included Rust support on top of rust-analyzer.
-- Self-configuring — do NOT also start rust-analyzer via lspconfig.
-- Requires rust-analyzer on PATH (see nvim/README.md: `rustup component add rust-analyzer`).
return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false, -- the plugin lazy-loads itself on the rust filetype
    init = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(_, bufnr)
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

            local map = function(keys, fn, desc)
              vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = "Rust: " .. desc })
            end
            -- RustLsp adds Rust-specific actions on top of the standard LSP maps
            map("gra", function() vim.cmd.RustLsp("codeAction") end, "Code action")
            map("K", function() vim.cmd.RustLsp({ "hover", "actions" }) end, "Hover actions")
            map("<leader>rr", function() vim.cmd.RustLsp("runnables") end, "Runnables")
            map("<leader>rd", function() vim.cmd.RustLsp("debuggables") end, "Debuggables")
            map("<leader>rm", function() vim.cmd.RustLsp("expandMacro") end, "Expand macro")
            map("<leader>rc", function() vim.cmd.RustLsp("openCargo") end, "Open Cargo.toml")
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true, loadOutDirsFromCheck = true, buildScripts = { enable = true } },
              check = { command = "clippy" }, -- lint with clippy on save
              procMacro = { enable = true },
              inlayHints = {
                bindingModeHints = { enable = false },
                closureReturnTypeHints = { enable = "with_block" },
                lifetimeElisionHints = { enable = "skip_trivial" },
              },
            },
          },
        },
      }
    end,
  },
}
