require("nvim-lsp-installer").setup()
-- Enable (broadcasting) snippet capability for completion
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require("lspconfig")

local language_servers = {
	sumneko_lua = {
		enabled = false,
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
	pyright = {
		enabled = true,
	},
	jedi_language_server = {
		enabled = false,
	},
	pylsp = {
		enabled = false,
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
		enabled = true,
	},
	prismals = {
		enabled = true,
	},
	angularls = {
		enabled = true,
	},
	tailwindcss = {
		enabled = true,
	},
}

local function get_python_path(workspace)
	-- Use activated virtualenv.
	if vim.env.VIRTUAL_ENV then
		return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
	end
	-- Find and use virtualenv in workspace directory.
	for _, pattern in ipairs({ "*", ".*" }) do
		local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
		if match ~= "" then
			return path.join(path.dirname(match), "bin", "python")
		end
	end
	-- Fallback to system Python.
	return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

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
	buf_set_keymap("n", "<C-f>", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

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

local buf_map = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
		silent = true,
	})
end

-- tserver
lspconfig.tsserver.setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false

		local ts_utils = require("nvim-lsp-ts-utils")
		ts_utils.setup({
			update_imports_on_move = true,
		})
		ts_utils.setup_client(client)

		buf_map(bufnr, "n", "io", ":TSLspOrganize<cr>")
		buf_map(bufnr, "n", "ia", ":TSLspImportAll<cr>")
		vim.cmd("autocmd BufWritePre <buffer> TSLspOrganizeSync")

		on_attach(client, bufnr)
	end,
	handlers = {
		["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			-- Disable virtual_text
			virtual_text = false,
		}),
	},
	capabilities = capabilities,
})

vim.diagnostic.config({ virtual_text = false })

-- pyright
-- lspconfig.pyright.setup({})

-- Emmet
lspconfig.emmet_ls.setup({
	filetypes = { "html", "css", "scss" },
})

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
