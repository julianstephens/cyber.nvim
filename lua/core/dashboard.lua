vim.g.dashboard_custom_header = {
[[            _                                 _        ]],
[[           | |                               | |       ]],
[[  ___ _   _| |__   ___ _ __ _ __  _   _ _ __ | | __    ]],
[[ / __| | | | '_ \ / _ \ '__| '_ \| | | | '_ \| |/ /    ]],
[[| (__| |_| | |_) |  __/ |  | |_) | |_| | | | |   <     ]],
[[ \___|\__, |_.__/ \___|_|  | .__/ \__,_|_| |_|_|\_\    ]],
[[       __/ |               | |                         ]],
[[      |___/                |_|                         ]]
}
vim.g.dashboard_default_executive = 'telescope'
vim.g.dashboard_custom_section = {
    a = {description = {'  Find File          '}, command = 'Telescope find_files'},
    b = {description = {'  Recent Files       '}, command = 'Telescope oldfiles'},
    c = {description = {'📁 Explorer           '}, command = 'Telescope file_browser'},
    d = {description = {'  Search Text        '}, command = 'Telescope live_grep'},
    e = {description = {'  Config             '}, command = 'edit ~/.config/nvim/init.lua'},
}
vim.g.dashboard_custom_footer = {'To make sense of something, we turn away from it and seek something else.'}
