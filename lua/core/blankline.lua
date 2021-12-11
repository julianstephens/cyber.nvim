local enable_rainbow_colors = true

local function get_char_highlights()
    if enable_rainbow_colors then
        vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 blend=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B blend=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 blend=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 blend=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF blend=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD blend=nocombine]]
        return {"IndentBlanklineIndent1", "IndentBlanklineIndent2", "IndentBlanklineIndent3", "IndentBlanklineIndent4",
                "IndentBlanklineIndent5", "IndentBlanklineIndent6"}
    else
        return {}
    end
end
require("indent_blankline").setup {
    filetype_exclude = {"dashboard", "packer", "NvimTree"},
    buftype_exclude = {"terminal"},
    char_highlight_list = get_char_highlights(),
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    show_current_context = not enable_rainbow_colors,
    context_patterns = {"class", "return", "function", "method", "^if", "^while", "jsx_element", "^for", "^object",
                        "^table", "block", "arguments", "if_statement", "else_clause", "jsx_element",
                        "jsx_self_closing_element", "try_statement", "catch_clause", "import_statement",
                        "operation_type"}
}
