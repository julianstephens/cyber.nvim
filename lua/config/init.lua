require("config.settings").load_options()
require("config.mappings").load_defaults()
require("config.plugins")
require("config.lsp")
vim.opt.formatoptions:remove('c');
vim.opt.formatoptions:remove('r');
vim.opt.formatoptions:remove('o');