local null_ls = require("null-ls")
local helpers = null_ls.helpers
local b = null_ls.builtins
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local null_ls_settings = {
	debug = true,
	sources = {
		b.formatting.black,
		b.formatting.codespell,
		b.formatting.stylua,
		b.formatting.clang_format,
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
				"htmldjango",
				"scss",
				"markdown",
			},
			extra_args = {
				"--prose-wrap",
				"always",
			},
		}),
		b.formatting.standardrb,
		b.formatting.erb_lint,
		b.code_actions.eslint.with({
			filetypes = {
				"typescriptreact",
				"javascriptreact",
			},
		}),
		b.diagnostics.erb_lint,
		b.code_actions.gitsigns,
		b.code_actions.proselint,
		b.hover.dictionary,
		b.diagnostics.eslint.with({
			filetypes = {
				"typescriptreact",
				"javascriptreact",
			},
		}),
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
}

-- Null LS
null_ls.setup(null_ls_settings)
