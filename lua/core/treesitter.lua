local filetypes = {
	"html",
	"htmldjango",
	"javascript",
	"javascriptreact",
	"typescriptreact",
	"svelte",
	"vue",
}
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true, -- false will disable the whole extension
	},
	indent = {
		enable = true,
		disable = { "python" },
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},
	autotag = {
		enable = true,
		filetypes = filetypes,
	},
	textobjects = {
		lsp_interop = {
			enable = true,
			border = "none",
			peek_definition_code = {
				["gf"] = "@function.outer",
				["gf"] = "@class.outer",
			},
		},
	},
	context_commentstring = {
		enable = true,
	},
})
