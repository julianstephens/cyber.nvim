-- local function apply_defaults(configs, defaults)
--   configs = configs or {}
--   return vim.tbl_deep_extend("keep", configs, defaults)
-- end

-- Load settings
require("config.settings").load_options()

-- Load key mappings
require("config.mappings").load_defaults()

-- require("core.builtins")

-- require("plugins")
require("config.plugins")

-- local lsp_config = require('lsp.config')
-- lsp.apply_defaults(lsp, vim.deepcopy(lsp_config))

-- require("../lsp").setup()
