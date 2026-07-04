-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = false,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        clipboard = "",
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["<TAB>"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["<S-TAB>"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        ["pq"] = "<cmd>bp|bd #<CR>",

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        ["<Leader>w"] = "<cmd>w!<CR>",
        ["<Leader>q"] = "<cmd>q<CR>",
        ["<leader>qq"] = "<cmd>q!<CR>",
        ["vs"] = "<cmd>vs<CR>",
        ["sp"] = "<cmd>sp<CR>",
        -- ["<Leader>hh"] = "<cmd>nohl<CR>",
        ["<C-h>"] = "<C-w>h",
        ["<C-j>"] = "<C-w>j",
        ["<C-k>"] = "<C-w>k",
        ["<C-l>"] = "<C-w>l",
        ["mw"] = "<cmd>HopWord<CR>",
        ["ml"] = "<cmd>HopLine<CR>",
        ["<Leader>gi"] = { function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
        ["<Leader>gI"] = { function() Snacks.picker.gh_issue { state = "all" } end, desc = "GitHub Issues (all)" },
        ["<Leader>gP"] = { function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },

        ["K"] = { "<cmd>Lspsaga hover_doc<CR>", desc = "Show LSP hover and line diagnostics" },
        ["<Leader>Ta"] = {
          function() require("neotest").run.run { suite = false, extra_args = {}, vim.fn.getcwd() } end,
          desc = "Run all project tests",
        },

        -- ["K"] = {
        --   function()
        --     -- 1. Get the current line number (0-indexed)
        --     local line = vim.api.nvim_win_get_cursor(0)[1] - 1
        --
        --     -- 2. Fetch all diagnostics for the current line
        --     local opts = { winnr = 0 }
        --     local diagnostics = vim.diagnostic.get(0, { lnum = line })
        --
        --     -- 3. If there are diagnostics, open the float
        --     if #diagnostics > 0 then vim.diagnostic.open_float(nil, { focus = false }) end
        --
        --     -- 4. Trigger the standard LSP hover
        --     vim.lsp.buf.hover()
        --   end,
        --   desc = "Show LSP hover and line diagnostics",
        -- },
        --
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
  },
}
