-- Update this path
local extension_path = '~/.vscode-server/extensions/vadimcn.vscode-lldb-1.6.10/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

local opts = {
    -- ... other configs
    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
            codelldb_path, liblldb_path)
    }
}

-- Normal setup
require('rust-tools').setup(opts)

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', 'dp', ":lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.api.nvim_set_keymap('n', 'dr', ":lua require'dap'.continue()<CR>", opts)
vim.api.nvim_set_keymap('n', 'dso', ":lua require'dap'.step_over()<CR>", opts)
vim.api.nvim_set_keymap('n', 'dsi', ":lua require'dap'.step_into()<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>rh', ":lua require'rust-tools.hover_actions'.hover_actions()<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>rj', ":lua require'rust-tools.join_lines'.join_lines()<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>rr', ":lua require'rust-tools.runnables'.runnables()<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>rd', ":lua require'rust-tools.debuggables'.debuggables()<CR>", opts)
