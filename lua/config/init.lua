vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require("config.lazy")
require("config.settings").load_options()
require("config.mappings").load_defaults()
require("config.lsp")
vim.opt.formatoptions:remove("c")
vim.opt.formatoptions:remove("r")
vim.opt.formatoptions:remove("o")
