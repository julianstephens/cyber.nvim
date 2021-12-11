-- local npairs = Vapour.utils.plugins.packadd('nvim-autopairs', true)

-- if remap == nil then return end

require("nvim-autopairs").setup({break_line_filetype = nil, check_ts = true})

local remap = vim.api.nvim_set_keymap
_G.MUtils = {}

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())