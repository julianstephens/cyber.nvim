local icons = require("config.icons")

vim.g.dashboard_custom_header = {
	[[            _                                 _        ]],
	[[           | |                               | |       ]],
	[[  ___ _   _| |__   ___ _ __ _ __  _   _ _ __ | | __    ]],
	[[ / __| | | | '_ \ / _ \ '__| '_ \| | | | '_ \| |/ /    ]],
	[[| (__| |_| | |_) |  __/ |  | |_) | |_| | | | |   <     ]],
	[[ \___|\__, |_.__/ \___|_|  | .__/ \__,_|_| |_|_|\_\    ]],
	[[       __/ |               | |                         ]],
	[[      |___/                |_|                         ]],
}
vim.g.dashboard_default_executive = "telescope"
vim.g.dashboard_custom_section = {
  a = {description = {icons.fileNoBg ..     'Find File          '}, command = 'Telescope find_files'},
  b = {description = {icons.timer ..        'Recents            '}, command = 'Telescope oldfiles'},
  c = {description = {icons.t ..            'Find Word          '}, command = 'Telescope live_grep'},
  e = {description = {icons.container ..    'Sync Plugins       '}, command = 'PackerSync'},
  f = {description = {icons.container ..    'Install Plugins    '}, command = 'PackerInstall'},
  h = {description = {icons.container ..    'Exit               '}, command = 'exit'},
}
vim.g.dashboard_custom_footer = { "To make sense of something, we turn away from it and seek something else." }
