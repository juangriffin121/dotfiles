local config = require("plugins.configs.lspconfig")

local capabilities = config.capabilities

vim.lsp.config("pyright", {
  capabilities = capabilities,
})

vim.lsp.enable("pyright")

vim.lsp.config("ruff", {
  capabilities = capabilities,
})

vim.lsp.enable("ruff")

vim.lsp.config("rust_analyzer", {
  capabilities = capabilities,
  root_markers = { "Cargo.toml", "rust-project.json", ".git" },
  settings = {
    ["rust-analyzer"] = {
      cargo = {},
      lens = {
        enable = false,
      },
    },
  },
})

vim.lsp.enable("rust_analyzer")
