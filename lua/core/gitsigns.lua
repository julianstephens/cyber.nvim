require("gitsigns").setup({
	signcolumn = true,
	numhl = false,
	linehl = false,
	watch_gitdir = {
		interval = 1000,
	},
	sign_priority = 6,
	update_debounce = 200,
	status_formatter = nil,
})
