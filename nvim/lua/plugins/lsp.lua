-- LSP: native Neovim 0.11 client (vim.lsp.config / vim.lsp.enable).
--   * mason.nvim          installs language servers & tools
--   * mason-tool-installer keeps that list in sync on startup
--   * nvim-lspconfig      ships the per-server `lsp/*.lua` definitions
--   * blink.cmp           provides completion capabilities
--
-- Rust is intentionally NOT configured here; rustaceanvim owns it (see rust.lua).
return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonLog" },
    opts = { ui = { border = "rounded" } },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      run_on_start = true,
      ensure_installed = {
        -- language servers
        "lua-language-server",
        "basedpyright",
        "ruff",
        "bash-language-server",
        "taplo", -- TOML
        "json-lsp",
        "yaml-language-server",
        -- formatters
        "stylua",
        "prettierd",
        "shfmt",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      -- Diagnostics presentation
      vim.diagnostic.config({
        virtual_text = { prefix = "●", spacing = 2 },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = true },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.HINT] = "⚑",
            [vim.diagnostic.severity.INFO] = "»",
          },
        },
      })

      -- Buffer-local keymaps once a server attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("config_lsp_attach", { clear = true }),
        callback = function(event)
          local map = function(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          map("grd", vim.lsp.buf.definition, "Goto definition")
          map("grD", vim.lsp.buf.declaration, "Goto declaration")
          map("gri", vim.lsp.buf.implementation, "Goto implementation")
          map("grt", vim.lsp.buf.type_definition, "Goto type definition")
          map("grr", vim.lsp.buf.references, "References")
          map("grn", vim.lsp.buf.rename, "Rename symbol")
          map("gra", vim.lsp.buf.code_action, "Code action")
          map("K", function() vim.lsp.buf.hover({ border = "rounded" }) end, "Hover docs")
          map("gK", function() vim.lsp.buf.signature_help({ border = "rounded" }) end, "Signature help")

          -- Inlay hints on by default, with a toggle
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
            map("<leader>uh", function()
              local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
              vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
            end, "Toggle inlay hints")
          end
        end,
      })

      -- Completion capabilities for every server
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      -- Per-server tweaks (merged on top of nvim-lspconfig defaults)
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = { checkThirdParty = false },
            diagnostics = { globals = { "vim" } },
            hint = { enable = true },
            telemetry = { enable = false },
          },
        },
      })

      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "standard",
              autoImportCompletions = true,
              diagnosticMode = "openFilesOnly",
            },
          },
        },
      })

      -- ruff handles linting + import sorting; defer hover to basedpyright
      vim.lsp.config("ruff", {
        on_attach = function(client)
          client.server_capabilities.hoverProvider = false
        end,
      })

      vim.lsp.enable({
        "lua_ls",
        "basedpyright",
        "ruff",
        "bashls",
        "taplo",
        "jsonls",
        "yamlls",
      })
    end,
  },
}
