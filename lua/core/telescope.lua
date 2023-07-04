local previewers = require("telescope.previewers")

require("telescope").setup({
	prompt_prefix = " 🔍 ",
	file_previewer = previewers.vim_buffer_cat.new,
	grep_previewer = previewers.vim_buffer_vimgrep.new,
	qflist_previewer = previewers.vim_buffer_qflist.new,
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_cursor(),
		},
		file_browser = {
			theme = "dropdown",
		},
	},
	defaults = {
		file_ignore_patterns = {
			"node_modules",
			"dist",
			"*.spec.ts",
		},
	},
})

require("telescope").load_extension("ui-select")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("project")
require("telescope").load_extension("gh")

local M = {}

M.lsp_code_actions = function()
	require("telescope.builtin").lsp_code_actions(require("telescope.themes").get_cursor())
end

return M
