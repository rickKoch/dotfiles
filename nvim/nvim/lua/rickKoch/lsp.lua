local capabilities = require("cmp_nvim_lsp").default_capabilities()
local inlay_hints = require("lsp-inlayhints")
local autocmds = require("lsp_autocommands")
local keymaps = require("lsp_keymaps")
local util = require("lspconfig/util")

require("symbols-outline").setup({
  width = 25,
})
vim.keymap.set("n", "<leader>smb", vim.cmd.SymbolsOutline, {
  noremap = true,
  silent = true,
  desc = "Symbols Outline",
})

inlay_hints.setup({})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  inlay_hints.on_attach(client, bufnr)
  autocmds.on_attach(client, bufnr)
  keymaps.on_attach(bufnr)
end

local lspconfig = require("lspconfig")
lspconfig.gopls.setup({
  filetypes = { "go", "gomod" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- workaround for gopls not supporting semanticTokensProvider
    -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
    if not client.server_capabilities.semanticTokensProvider then
      local semanticTokens = client.config.capabilities.textDocument.semanticTokens
      client.server_capabilities.semanticTokensProvider = {
        full = true,
        legend = {
          -- tokenTypes = semanticTokens.tokenTypes,
          -- tokenModifiers = semanticTokens.tokenModifiers,
        },
        range = true,
      }
    end
    on_attach(client, bufnr)
  end,
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        -- fieldalignment = true,
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      -- usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = { "-.git", "-node_modules" },
      semanticTokens = true,
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
})

lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.marksman.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.yamlls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    yaml = {
      schemaStore = {
        url = "https://www.schemastore.org/api/json/catalog.json",
        enable = true,
      },
    },
  },
})

lspconfig.nil_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.html.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.jsonls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.bashls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.golangci_lint_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.terraformls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.tflint.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.dockerls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.clangd.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";", {})
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      telemetry = { enable = false },
      hint = {
        enable = true,
      },
    },
  },
})

lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.taplo.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.fish_indent,
    null_ls.builtins.formatting.nixfmt,
    null_ls.builtins.formatting.prettier,
    -- null_ls.builtins.code_actions.gitsigns,
    -- null_ls.builtins.formatting.shfmt,
  },
  capabilities = capabilities,
  on_attach = on_attach,
})

local float_config = {
  focusable = false,
  style = "minimal",
  border = "rounded",
  source = "always",
  header = "",
  prefix = "",
}

-- setup diagnostics
vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "●" },
  severity_sort = true,
  float = float_config,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float_config)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float_config)

-- set up diagnostic signs
for name, icon in pairs(require("rickKoch.icons").diagnostics) do
  name = "DiagnosticSign" .. name
  vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
end

-- change documentation to be rouded and non-focusable...
-- any time I focus into one of these, is by accident, and it always take me
-- a couple of seconds to figure out what I did.
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
  focusable = false,
})
