local wk = require("which-key")
wk.setup({
  ignore_missing = true,
})

local opts = {
  noremap = true,
  silent = true,
}

local mappings = {
  ["<leader>f"] = {
    name = "+Files",
    f = { "<cmd>Telescope find_files prompt_prefix=🔍<CR>", "Finder" },
    i = { "<cmd>Telescope find_files hidden=true no_ignore=true prompt_prefix=🔍<CR>", "Show Ignore" },
    e = { "<cmd>Telescope file_browser prompt_prefix=🔍<CR>", "Explorer" },
    n = { ":Neotree<CR>", "File Tree" },
    g = { "<cmd>Telescope live_grep prompt_prefix=🔍<CR>", "Grep" },
    h = { "<cmd>Telescope oldfiles prompt_prefix=🔍<CR>", "History" },
    b = { "<cmd>Telescope buffers prompt_prefix=🔍<CR>", "Buffers" },
    p = { ":lua require'telescope'.extensions.project.project{}<CR>", "Projects" },
    v = { ":Telescope env<CR>", "Env Vars" },
    t = { ":TodoTelescope<CR>", "Todo" },
  },
  ["<leader>g"] = {
    name = "+Git",
    s = { "<cmd>lua require'gitsigns'.stage_hunk()<CR>", "Stage hunk" },
    u = { "<cmd>lua require'gitsigns'.undo_stage_hunk()<CR>", "Unstage hunk" },
    r = { "<cmd>lua require'gitsigns'.reset_hunk()<CR>", "Reset hunk" },
    p = { "<cmd>lua require'gitsigns'.preview_hunk()<CR>", "Preview hunk" },
    b = { "<cmd>lua require'gitsigns'.blame_line{full=true}()<CR>", "Blame line" },
    ["h"] = {
      name = "+GitHub",
      i = { "<cmd>lua require('telescope').extensions.gh.issues()<CR>", "Issues" },
      p = { "<cmd>lua require('telescope').extensions.gh.pull_request()<CR>", "PRs" },
      g = { "<cmd>lua require('telescope').extensions.gh.gist()<CR>", "Gists" },
      r = { "<cmd>lua require('telescope').extensions.gh.run()<CR>", "Run" },
    },
  },
  ["<leader>t"] = {
    name = "+ToggleTerm",
    t = { ":ToggleTerm<CR>", "Bottom terminal" },
    a = { ":ToggleTerm direction=tab<CR>", "Tab terminal" },
    f = { ":ToggleTerm direction=float<CR>", "Floating terminal" },
  },
  ["<leader>p"] = {
    name = "+Packer",
    s = { ":PackerSync<CR>", "Sync plugins" },
    i = { ":PackerInstall<CR>", "Install plugins" },
    c = { ":PackerClean<CR>", "Clean plugins" },
    u = { ":PackerUpdate<CR>", "Update plugins" },
  },
  ["<leader>l"] = {
    name = "+LSP",
    i = { ":NullLsInfo<CR>", "View language servers" },
    l = { ":NullLsLog<CR>", "View language servers" },
  },
  ["<leader>o"] = {
    name = "+Trouble",
    d = { "<cmd>Trouble document_diagnostics<CR>", "View diagnostics" },
    w = { "<cmd>Trouble workspace_diagnostics<CR>", "View workspace diagnostics" },
    q = { "<cmd>Trouble quickfix<CR>", "Quick fix diagnostics" },
    l = { "<cmd>Trouble loclist<CR>", "View location list" },
    t = { ":TodoTrouble<CR>", "View todos" },
  },
  ["<leader>n"] = {
    name = "+Flote",
    n = { ":Flote<CR>", "Open project note" },
    g = { ":Flote global<CR>", "Open global note" },
    l = { ":Flote manage<CR>", "View all notes" },
  },
  ["m"] = {
    name = "+Markdown",
    g = { ":Goyo<CR>", "Goyo" },
    p = { ":TogglePencil<CR>", "Toggle Pencil" },
    v = { ":Glow<CR>", "Preview" },
    ["t"] = {
      name = "+Table",
      c = { "<cmd> lua require('tablemd').insertColumn(false)<CR>", "Insert column" },
      d = { "<cmd> lua require('tablemd').deleteColumn()<CR>", "Delete column" },
      f = { "<cmd> lua require('tablemd').format()<CR>", "Format table" },
      r = { "<cmd> lua require('tablemd').insertRow(false)<CR>", "Insert row below" },
      R = { "<cmd> lua require('tablemd').insertRow(true)<CR>", "Insert row above" },
      j = { "<cmd> lua require('tablemd').alignColumn('left')<CR>", "Align column left" },
      k = { "<cmd> lua require('tablemd').alignColumn('center')<CR>", "Align column center" },
      l = { "<cmd> lua require('tablemd').alignColumn('right')<CR>", "Align column right" },
    },
  },
  -- ["<leader>d"] = {
  --   name = "Debug",
  --   R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
  --   E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
  --   C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
  --   U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
  --   b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
  --   c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
  --   d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
  --   e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
  --   g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
  --   h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
  --   S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
  --   i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
  --   o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
  --   p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
  --   q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
  --   r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
  --   s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
  --   t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
  --   x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
  --   u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
  -- },
  ["<leader>i"] = {
    name = "Mason",
    m = { "<cmd>:Mason<cr>", "Mason UI" },
    i = { "<cmd>:MasonInstall ", "Mason Install" },
  },
}

wk.register(mappings, opts)
