local null_ls = require("null-ls")
local b = null_ls.builtins

vim.env.PRETTIERD_DEFAULT_CONFIG = vim.fn.stdpath("config") .. "/.prettierrc"

null_ls.config({
    debounce = 150,
    sources = {b.formatting.black, b.formatting.codespell, b.formatting.eslint_d, b.formatting.stylelint,
               b.formatting.stylua, b.diagnostics.codespell, b.formatting.prettier.with {
        filetypes = {"typescriptreact", "typescript", "javascriptreact", "javascript", "svelte", "json", "jsonc", "css",
                     "html"},
        b.code_actions.gitsigns,
        b.completion.spell
    }}
})
