local wk = require('which-key')
wk.setup({
    ignore_missing = true,
})

local mappings = {
    ["<leader>f"] = {
        name = "+Files",
        f = {"<cmd>Telescope find_files prompt_prefix=🔍<cr>", 'Finder'},
        e = {"<cmd>Telescope file_browser<CR>", 'Explorer'},
        g = {"<cmd>Telescope live_grep<CR>", 'Grep'},
        h = {"<cmd>Telescope oldfiles<CR>", 'History'},
        b = {"<cmd>Telescope buffers<CR>", 'Buffers'},
    },
    ["<leader>g"] = {
        name = "+Theme/Todo",
        c = {"Change theme"},
        g = {"Git todo"},
        t = {"Global todo"},
    },
    ["<leader>t"] = {
        name = "+ToggleTerm",
        t = {":ToggleTerm<cr>", "Bottom terminal"},
        a = {":ToggleTerm direction=tab<cr>", "Tab terminal"},
        f = {":ToggleTerm direction=float<cr>", "Floating terminal"},
    },
    ["<leader>p"] = {
        name = "+Packer",
        s = {":PackerSync<cr>", "Sync plugins"},
        c = {":PackerClean<cr>", "Clean plugins"},
        u = {":PackerUpdate<cr>", "Update plugins"},
    },
    ["<leader>l"] = {
        name = "+LSP",
        i = {":LspInfo<cr>", "View language servers"},
        -- c = {":PackerClean<cr>", "Clean plugins"},
        -- u = {":PackerUpdate<cr>", "Update plugins"},
    },
    ["<leader>o"] = {
        name = "+Trouble",
        t = {"<cmd>Trouble document_diagnostics<cr>", "View diagnostics"},
        w = {"<cmd>Trouble workspace_diagnostics<cr>", "View workspace diagnostics"},
        q = {"<cmd>Trouble quickfix", "Quick fix diagnostics"},
        l = {"<cmd>Trouble loclist<cr>", "View location list"},
    },
}

wk.register(mappings, opts)
