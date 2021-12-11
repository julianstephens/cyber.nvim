require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true -- false will disable the whole extension
    },
    indent = {
        enable = true
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil
    },
    autotag = {
        enable = true
    }
}