require("lualine").setup({
	options = {
		theme = "nightfly",
	},
	sections = {
		lualine_a = {
			{
				"datetime",
				-- options: default, us, uk, iso, or your own format string ("%H:%M", etc..)
				style = "%c",
			},
		},
	},
})
