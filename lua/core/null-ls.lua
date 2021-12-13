local null_ls = require("null-ls")
local b = null_ls.builtins

null_ls.config({
    sources = {
        b.formatting.black,
        b.formatting.codespell,
        b.formatting.eslint_d,
        b.formatting.stylelint,
        b.formatting.stylua,
        b.diagnostics.codespell,
        b.formatting.prettier.with({
            filetypes = {
                "typescriptreact",
                "typescript",
                "javascriptreact",
                "javascript",
                "svelte",
                "json",
                "jsonc",
                "css",
                "html",
                "scss",
            },
        }),
        b.code_actions.gitsigns,
        b.completion.spell
    }
})
