local saga = require 'lspsaga'
saga.init_lsp_saga()


-- LSP Mappings
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', 'gh', ':Lspsaga lsp_finder<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>oa', ':Lspsaga code_action<CR>', opts)
vim.api.nvim_set_keymap('v', '<leader>oa', ':<C-U>Lspsaga range_code_action<CR>', opts)
vim.api.nvim_set_keymap('n', 'gs', ':Lspsaga signature_help<CR>', opts)
vim.api.nvim_set_keymap('n', 'K', ':Lspsaga hover_doc<CR>', opts)
vim.api.nvim_set_keymap('n', '<TAB>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)', opts)
vim.api.nvim_set_keymap('n', '<S-TAB>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)', opts)
vim.api.nvim_set_keymap('n', 'gd', ':Lspsaga preview_definitions<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr', ':Lspsaga rename<CR>', opts)
vim.api.nvim_set_keymap('n', 'gR', '<cmd>Trouble lsp_references<CR>', opts)