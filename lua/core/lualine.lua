require("lualine").setup({
	theme = "tokyonight",
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
