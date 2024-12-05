require("mason").setup()
require("mason-lspconfig").setup()

-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.tbl_deep_extend(
	"force",
	vim.lsp.protocol.make_client_capabilities(),
	require("cmp_nvim_lsp").default_capabilities()
)
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require("lspconfig")

local language_servers = {
	astro = {
		enabled = true,
	},
	taplo = {
		enabled = true,
	},
	lua_ls = {
		enabled = true,
	},
	bashls = {
		enabled = true,
	},
	cssls = {
		enabled = true,
	},
	html = {
		enabled = true,
	},
	emmet_language_server = {
		enabled = true,
	},
	pyright = {
		enabled = true,
	},
	jedi_language_server = {
		enabled = false,
	},
	pylsp = {
		enabled = false,
	},
	ruff = {
		enabled = true,
	},
	vimls = {
		enabled = true,
	},
	yamlls = {
		enabled = true,
	},
	solargraph = {
		enabled = true,
	},
	vuels = {
		enabled = false,
	},
	phpactor = {
		enabled = false,
	},
	marksman = {
		enabled = true,
	},
	eslint = {
		enabled = false,
	},
	jsonls = {
		enabled = true,
		setup = {
			commands = {
				Format = {
					function()
						vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
					end,
				},
			},
		},
	},
	gopls = {
		enabled = true,
	},
	clangd = {
		enabled = true,
	},
	rust_analyzer = {
		enabled = false,
	},
	prismals = {
		enabled = true,
	},
	angularls = {
		enabled = false,
	},
	tailwindcss = {
		enabled = true,
	},
	svelte = {
		enabled = true,
	},
	ts_ls = {
		enabled = true,
	},
}

-- Use activated virtualenv.
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	client.server_capabilities.document_formatting = false
	client.server_capabilities.document_range_formatting = false

	-- Mappings.
	local opts = {
		noremap = true,
		silent = true,
	}
	buf_set_keymap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua require('telescope.builtin').lsp_implementations<CR>", opts)
	buf_set_keymap("n", "<leader>T", "<cmd>lua require('telescope.builtin').lsp_type_definitions<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)

	-- buf_set_keymap("n", "<leader>tm", "<cmd>TSToolsAddMissingImports<cr>", opts)
	-- buf_set_keymap("n", "<leader>to", "<cmd>TSToolsOrganizeImports<cr>", opts)
	-- buf_set_keymap("n", "<leader>tf", "<cmd>TSToolsFixAll<cr>", opts)

	-- Diagnostics
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>df", "<cmd>lua vim.diagnostic.open_float(nil, { scope = 'line' })<CR>", opts)
	buf_set_keymap("n", "ge", "<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "<C-;>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "grn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "oa", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	-- buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	buf_set_keymap("n", "<C-f>", "<cmd>Format<CR>", opts)

	-- Workspaces
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)

	vim.cmd("autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })")
end

for ls, props in pairs(language_servers) do
	if props.enabled == true then
		lspconfig[ls].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end
end

vim.lsp.commands["editor.action.showReferences"] = function(command, ctx)
	local locations = command.arguments[3]
	local client = vim.lsp.get_client_by_id(ctx.client_id)
	if locations and #locations > 0 then
		local items = vim.lsp.util.locations_to_items(locations, client.offset_encoding)
		vim.fn.setloclist(0, {}, " ", { title = "References", items = items, context = ctx })
		vim.api.nvim_command("lopen")
	end
end

vim.diagnostic.config({ virtual_text = false })

local signs = {
	Error = " ",
	Warn = " ",
	Hint = " ",
	Info = " ",
}
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, {
		text = icon,
		texthl = hl,
		numhl = "",
	})
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if vim.tbl_contains({ "null-ls" }, client.name) then -- blacklist lsp
			return
		end
		require("lsp_signature").on_attach({
			bind = true,
			handler_opts = {
				border = "rounded",
			},
		}, bufnr)
	end,
})
