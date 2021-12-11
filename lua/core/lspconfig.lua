--Enable (broadcasting) snippet capability for completion
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require('lspconfig')

local language_servers = {
  sumneko_lua = {enabled = false},
  bashls = {enabled = true},
  cssls = {enabled = true},
  html = {enabled = true},
  emmet = {enabled = true},
  tsserver = {enabled = true},
  pyright = {enabled = true},
  jedi_language_server = {enabled = false},
  pylsp = {enabled = false},
  vimls = {enabled = true},
  yamlls = {enabled = true},
  solargraph = {enabled = false},
  vuels = {enabled = false},
  phpactor = {
    enabled = false,
  },
  jsonls = {
    enabled = true,
    setup = {
      commands = {
        Format = {
          function()
            vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0})
          end
        }
      }
    }
  },
  gopls = {enabled = false, setup = {cmd = {"gopls", "serve"}, settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}}}}
}

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>oa', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>df', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<C-f>', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

for ls, props in pairs(language_servers) do 
  if props.enabled == true then
    lspconfig[ls].setup({
      on_attach = on_attach,
      capabilities = capabilities
    })
  end
end

-- Diagnostics
lspconfig.diagnosticls.setup {
    filetypes = {"javascript", "javascriptreact", "typescript", "typscriptreact", "css", "scss"},
      init_options = {
    filetypes = {
      javascript = "eslint",
      typescript = "eslint",
      javascriptreact = "eslint",
      typescriptreact = "eslint"
    },
    linters = {
      eslint = {
        sourceName = "eslint",
        command = "./node_modules/.bin/eslint",
        rootPatterns = {
          ".eslitrc.js",
          "package.json"
        },
        debounce = 100,
        args = {
          "--cache",
          "--stdin",
          "--stdin-filename",
          "%filepath",
          "--format",
          "json"
        },
        parseJson = {
          errorsRoot = "[0].messages",
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "${message} [${ruleId}]",
          security = "severity"
        },
        securities = {
          [2] = "error",
          [1] = "warning"
        }
      }
    }
  }
}

-- Emmet
lspconfig.emmet_ls.setup {
  filetypes = {"html", "css", "scss"}
}

-- -- Bash
-- require'lspconfig'.bashls.setup {}

-- -- CSS/SCSS/Less
-- require'lspconfig'.ccls.setup {
--     capabilities = capabilities,
-- }



-- -- HTML
-- require'lspconfig'.html.setup {
--   capabilities = capabilities,
-- }

-- -- JSON
-- require'lspconfig'.jsonls.setup {
--     capabilities = capabilities,
-- }

-- -- Typescript
-- require'lspconfig'.tsserver.setup{}

-- -- Vim
-- require'lspconfig'.vimls.setup{}
