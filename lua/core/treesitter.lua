local filetypes = {
  "html",
  "htmldjango",
  "javascript",
  "javascriptreact",
  "typescriptreact",
  "tsx",
  "jsx",
  "svelte",
  "vue",
  "eruby",
  "erb",
  "html.erb",
}

vim.g.skip_ts_context_commentstring_module = true

require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  indent = {
    enable = false,
    disable = { "python", "typescript" },
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
  autotag = {
    enable = true,
    filetypes = filetypes,
  },
  textobjects = {
    lsp_interop = {
      enable = true,
      border = "none",
      peek_definition_code = {
        ["gf"] = "@function.outer",
      },
    },
  },
})

require("ufo").setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { "treesitter", "indent" }
  end,
})
