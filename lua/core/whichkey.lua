local wk = require("which-key")
wk.setup({
	ignore_missing = true,
})

local mappings = {
	["<leader>f"] = {
		name = "+Files",
		f = { "<cmd>Telescope find_files prompt_prefix=🔍<cr>", "Finder" },
		i = { "<cmd>Telescope find_files hidden=true no_ignore=true prompt_prefix=🔍<cr>", "Show Ignore" },
		e = { "<cmd>Telescope file_browser prompt_prefix=🔍<CR>", "Explorer" },
		n = { ":Neotree<CR>", "File Tree" },
		g = { "<cmd>Telescope live_grep prompt_prefix=🔍<CR>", "Grep" },
		r = { "<cmd>lua require('telescope').extensions.frecency.frecency()<CR>", "Recent" },
		h = { "<cmd>Telescope oldfiles prompt_prefix=🔍<CR>", "History" },
		b = { "<cmd>Telescope buffers prompt_prefix=🔍<CR>", "Buffers" },
		p = { ":lua require'telescope'.extensions.project.project{}<CR>", "Projects" },
		v = { ":Telescope env<CR>", "Env Vars" },
		t = { ":TodoTelescope<CR>", "Todo" },
	},
	["<leader>g"] = {
		name = "+Git",
		s = { "<cmd>lua require'gitsigns'.stage_hunk()<CR>", "Stage hunk" },
		u = { "<cmd>lua require'gitsigns'.undo_stage_hunk()<CR>", "Unstage hunk" },
		r = { "<cmd>lua require'gitsigns'.reset_hunk()<CR>", "Reset hunk" },
		p = { "<cmd>lua require'gitsigns'.preview_hunk()<CR>", "Preview hunk" },
		b = { "<cmd>lua require'gitsigns'.blame_line{full=true}()<CR>", "Blame line" },
	},
	["<leader>t"] = {
		name = "+ToggleTerm",
		t = { ":ToggleTerm<cr>", "Bottom terminal" },
		a = { ":ToggleTerm direction=tab<cr>", "Tab terminal" },
		f = { ":ToggleTerm direction=float<cr>", "Floating terminal" },
	},
	["<leader>p"] = {
		name = "+Packer",
		s = { ":PackerSync<cr>", "Sync plugins" },
		i = { ":PackerInstall<cr>", "Install plugins" },
		c = { ":PackerClean<cr>", "Clean plugins" },
		u = { ":PackerUpdate<cr>", "Update plugins" },
	},
	["<leader>l"] = {
		name = "+LSP",
		i = { ":NullLsInfo<cr>", "View language servers" },
		l = { ":NullLsLog<cr>", "View language servers" },
	},
	["<leader>o"] = {
		name = "+Trouble",
		d = { "<cmd>Trouble document_diagnostics<cr>", "View diagnostics" },
		w = { "<cmd>Trouble workspace_diagnostics<cr>", "View workspace diagnostics" },
		q = { "<cmd>Trouble quickfix<cr>", "Quick fix diagnostics" },
		l = { "<cmd>Trouble loclist<cr>", "View location list" },
		t = { ":TodoTrouble<cr>", "View todos" },
	},
}

wk.register(mappings, opts)
