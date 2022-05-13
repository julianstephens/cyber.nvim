local icons = require("config.icons")
local alpha = require("alpha")
local dashboard = require "alpha.themes.dashboard"


dashboard.section.header.val = {
    [[             _                          _                  ]],
    [[            | |                        (_)                 ]],
    [[   ___ _   _| |__   ___ _ __ _ ____   ___ _ __ ___         ]],
    [[  / __| | | | '_ \ / _ \ '__| '_ \ \ / / | '_ ` _ \        ]],
    [[ | (__| |_| | |_) |  __/ |  | | | \ V /| | | | | | |       ]],
    [[  \___|\__, |_.__/ \___|_|  |_| |_|\_/ |_|_| |_| |_|       ]], 
    [[        __/ |                                              ]],
    [[       |___/                                               ]]
}


vim.g.dashboard_default_executive = "telescope"


dashboard.section.buttons.val = {
  dashboard.button("e", icons.pencil ..       'New File           ', ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", icons.fileNoBg ..     'Find File          ', ":Telescope find_files<CR>"),
  dashboard.button("r", icons.timer ..        'Recents            ', ":Telescope oldfiles<CR>"),
  dashboard.button("g", icons.t ..            'Find Word          ', ":Telescope live_grep<CR>"),
  dashboard.button("s", icons.container ..    'Sync Plugins       ', ":PackerSync<CR>"),
  dashboard.button("c", icons.info ..         'Checkhealth        ', ":checkhealth<CR>"),
  dashboard.button("x", icons.terminal ..     'Exit               ', ":qa<CR>"),
}


dashboard.section.footer.val = { "To make sense of something, we turn away from it and seek something else." }

alpha.setup(dashboard.opts)
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
