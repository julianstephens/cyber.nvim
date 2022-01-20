local null_ls = require("null-ls")
local b = null_ls.builtins

local null_ls_settings = {
	sources = {
		b.formatting.black,
		b.formatting.codespell,
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
				"markdown",
			},
		}),
		b.code_actions.gitsigns,
		-- b.completion.spell,
	},
	on_attach = function(client, bufnr)
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	end,
}

-- Null LS
null_ls.setup(null_ls_settings)
