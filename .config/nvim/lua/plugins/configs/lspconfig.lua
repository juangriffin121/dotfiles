dofile(vim.g.base46_cache .. "lsp")

local M = {}
local utils = require "core.utils"
local lsp_windows = require "lspconfig.ui.windows"

local function lsp_symbol(name, icon)
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lsp_symbol("Error", "E")
lsp_symbol("Info", "I")
lsp_symbol("Hint", "H")
lsp_symbol("Warn", "W")

vim.diagnostic.config {
  virtual_text = {
    prefix = ">",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
}

local hover_handler = vim.lsp.handlers.hover
local signature_handler = vim.lsp.handlers.signature_help

vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
  local opts = vim.tbl_deep_extend("force", config or {}, { border = "single" })
  return hover_handler(err, result, ctx, opts)
end

vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
  local opts = vim.tbl_deep_extend("force", config or {}, {
    border = "single",
    focusable = false,
    relative = "cursor",
  })
  return signature_handler(err, result, ctx, opts)
end

local default_window_opts = lsp_windows.default_opts

lsp_windows.default_opts = function(options)
  local opts = default_window_opts(options)
  opts.border = "single"
  return opts
end

local lsp_attach_group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_attach_group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    if not client then
      return
    end

    -- Apply buffer-local LSP mappings whenever a client attaches.
    utils.load_mappings("lspconfig", { buffer = bufnr })

    if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

-- export capabilities for custom lspconfigs
M.on_attach = function()
  -- Kept for compatibility with any custom config that still imports it.
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

vim.lsp.config("*", {
  capabilities = M.capabilities,
})

vim.lsp.config("lua_ls", {
  capabilities = M.capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})

vim.lsp.enable("lua_ls")

return M
