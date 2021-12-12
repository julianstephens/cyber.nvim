local null_ls = require("null-ls")
local b = null_ls.builtins

vim.env.PRETTIERD_DEFAULT_CONFIG = vim.fn.stdpath("config") .. "/.prettierrc"

null_ls.config({
	debounce = 150,
	sources = {
		b.formatting.black,
		b.formatting.codespell,
		b.formatting.eslint_d,
		b.formatting.json_tool,
		b.formatting.prettier,
		b.formatting.stylelint,
		b.formatting.stylua,
		b.diagnostics.codespell,
		-- b.diagnostics.eslint_d,
  	-- b.diagnostics.luacheck,
		-- b.diagnostics.stylelint,
		-- b.diagnostics.vint,
		b.code_actions.eslint_d,
		b.code_actions.gitsigns,
		b.completion.spell,
		b.completion.vsnip,
		-- b.formatting.prettier.with {
		--   filetypes = {
		--     "typescriptreact",
		--     "typescript",
		--     "javascriptreact",
		--     "javascript",
		--     "svelte",
		--     "json",
		--     "jsonc",
		--     "css",
		--     "html",
		--   },
		-- },
	},
})
