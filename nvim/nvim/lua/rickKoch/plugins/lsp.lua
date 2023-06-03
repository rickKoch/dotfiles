local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lspstatus = require("lsp-status")

lspstatus.config({
  status_symbol = "⬤ ",
  current_function = true,
  diagnostics = false,
  kind_labels = require("lspkind").presets["default"],
})
lspstatus.register_progress()

local capabilities = vim.tbl_extend(
  "keep",
  cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()) or {},
  lspstatus.capabilities
)
capabilities.textDocument.completion.completionItem = {
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

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  lspstatus.on_attach(client, bufnr)

  -- Mappings.
  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap("n", "<C-j>", "<cmd>Telescope lsp_document_symbols<CR>", opts)
  buf_set_keymap("n", "<C-h>", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "<leader>D", "<cmd>Telescope lsp_type_definitions<CR>", opts)
  buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "]s", "<cmd>lua vim.diagnostic.show()<CR>", opts)
  buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

  if client.server_capabilities.document_formatting and client.name ~= "sumneko_lua" then
    vim.cmd([[
			augroup lsp_formatting
				autocmd! * <buffer>
				autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
			augroup END
		]] )
  end

  -- If the organizeImports codeAction runs for lua files, depending on
  -- where the cursor is, it'll reorder the args and break stuff.
  -- This took me way too long to figure out.
  if client.name ~= "null-ls" and client.name ~= "sumneko_lua" then
    vim.cmd([[
			augroup lsp_organize_imports
				autocmd! * <buffer>
				autocmd BufWritePre <buffer> lua OrganizeImports(150)
			augroup END
		]] )
  end


  if client.server_capabilities.document_highlight then
    vim.cmd([[
			augroup lsp_document_highlight
				autocmd! * <buffer>
				autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
		]] )
  end
end

require("mason").setup()
require("mason-lspconfig").setup({
  automatic_installation = true,
})

local opts = {
  -- rust-tools options
  tools = {
    autoSetHints = true,
    hover_with_actions = true,
    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
  -- https://rust-analyzer.github.io/manual.html#features
  server = {
    on_attach = on_attach,
    settings = {
      ["rust-analyzer"] = {
        assist = {
          importEnforceGranularity = true,
          importPrefix = "crate"
        },
        cargo = {
          allFeatures = true
        },
        checkOnSave = {
          -- default: `cargo check`
          command = "clippy"
        },
      },
      inlayHints = {
        lifetimeElisionHints = {
          enable = true,
          useParameterNames = true
        },
      },
    }
  },
}
require('rust-tools').setup(opts)

local lspconfig = require("lspconfig")

local eslint = {
  lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
  lintFormats = { "%f(%l,%c): %tarning %m", "%f(%l,%c): %trror %m" },
  lintStdin = true,
  lintIgnoreExitCode = true,
  lintSource = "eslint",
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename ${INPUT}",
  formatStdin = true
}

local shellcheck = {
  lintCommand = "shellcheck -f gcc -x -",
  lintStdin = true,
  lintFormats = {
    "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m"
  },
  lintSource = "shellcheck"
}

local prettier = {
  formatCommand = 'prettierd "${INPUT}"',
  formatStdin = true
}

local jq = {
  lintCommand = "jq .",
  lintFormats = { "parse %trror: %m at line %l, column %c" },
  lintSource = "jq"
}

local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  if vim.fn.filereadable("package.json") then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
      return true
    end
  end

  return false
end

lspconfig.efm.setup {
  on_attach = on_attach,
  root_dir = function()
    if not eslint_config_exists() then
      return nil
    end
    return vim.fn.getcwd()
  end,
  settings = {
    languages = {
      css = { prettier },
      html = { prettier },
      javascript = { prettier, eslint },
      javascriptreact = { prettier, eslint },
      json = { prettier, jq },
      markdown = { prettier },
      pandoc = { prettier },
      sh = { shellcheck },
      typescript = { prettier, eslint },
      typescriptreact = { prettier, eslint },
      yaml = { prettier },
      ["javascript.jsx"] = { eslint },
      ["typescript.tsx"] = { eslint },
    }
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescript.tsx",
    "typescriptreact"
  },
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = { usePlaceholders = true }
}

--lspconfig.diagnosticls.setup {
--filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact", "css"},
--init_options = {
--filetypes = {
--javascript = "eslint",
--typescript = "eslint",
--javascriptreact = "eslint",
--typescriptreact = "eslint"
--},
--linters = {
--eslint = {
--sourceName = "eslint",
--command = "./node_modules/.bin/eslint",
--rootPatterns = {
--".eslitrc.js",
--"package.json"
--},
--debounce = 100,
--args = {
--"--cache",
--"--stdin",
--"--stdin-filename",
--"%filepath",
--"--format",
--"json"
--},
--parseJson = {
--errorsRoot = "[0].messages",
--line = "line",
--column = "column",
--endLine = "endLine",
--endColumn = "endColumn",
--message = "${message} [${ruleId}]",
--security = "severity"
--},
--securities = {
--[2] = "error",
--[1] = "warning"
--}
--}
--}
--}
--}

require("formatter").setup(
  {
    logging = true,
    filetype = {
      typescriptreact = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
            stdin = true
          }
        end
      },
      typescript = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
            stdin = true
          }
        end
        -- linter
        -- function()
        --   return {
        --     exe = "eslint",
        --     args = {
        --       "--stdin-filename",
        --       vim.api.nvim_buf_get_name(0),
        --       "--fix",
        --       "--cache"
        --     },
        --     stdin = false
        --   }
        -- end
      },
      javascript = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
            stdin = true
          }
        end
      },
      javascriptreact = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
            stdin = true
          }
        end
      },
      json = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
            stdin = true
          }
        end
      },
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = { "--indent-count", 2, "--stdin" },
            stdin = true
          }
        end
      }
    }
  }
)

lspconfig.gopls.setup({
  cmd = {'gopls'},
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      gofumpt = true,
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      experimentalPostfixCompletions = true,
      staticcheck = true,
      usePlaceholders = true,
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
})

local schemas = {}
schemas["https://goreleaser.com/static/schema-pro.json"] = ".goreleaser.yaml"

lspconfig.yamlls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    yaml = {
      schemaStore = {
        url = "https://www.schemastore.org/api/json/catalog.json",
        enable = true,
      },
      schemas = schemas,
    },
  },
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

lspconfig.sumneko_lua.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  select_symbol = function(cursor_pos, symbol)
    -- fixes for lsp-status so it shows the function in its status bar
    if symbol.valueRange then
      local value_range = {
        ["start"] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[1]),
        },
        ["end"] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[2]),
        },
      }

      return require("lsp-status.util").in_range(cursor_pos, value_range)
    end
  end,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "require", "pcall", "pairs" },
      },
    },
  },
})

--lspconfig.rust_analyzer.setup({
--capabilities = capabilities,
--on_attach = on_attach,
--})

lspconfig.prosemd_lsp.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- organize imports
-- https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-902680058
function OrganizeImports(timeoutms)
  vim.notify("will organize imports")
  local clients = vim.lsp.buf_get_clients()
  for _, client in pairs(clients) do
    local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
    params.context = { only = { "source.organizeImports" } }

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeoutms)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end
end

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
  },
  capabilities = capabilities,
  on_attach = on_attach,
})

-- setup diagnostics
vim.diagnostic.config({ virtual_text = false })
-- vim.api.nvim_create_autocmd({ "CursorHold" }, {
-- 	callback = function()
-- 		if vim.lsp.buf.server_ready() then
-- 			vim.diagnostic.open_float()
-- 		end
-- 	end,
-- })

-- set up LSP signs
for type, icon in pairs({
  Error = "",
  Warn = "",
  Hint = "",
  Info = "",
}) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
