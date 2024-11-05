require("trouble").setup({
	modes = {
		preview_diagnostics = {
			mode = "diagnostics",
			preview = {
				type = "split",
				relative = "win",
				position = "right",
				size = 0.3,
			},
			filter = { buf = 0 },
		},
		workspace_diagnostics = {
			mode = "diagnostics",
			filter = {
				any = {
					function(item)
						return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
					end,
				},
			},
		},
	},
	auto_close = true,
	action_keys = {
		close = "<C-q>",
	},
})
