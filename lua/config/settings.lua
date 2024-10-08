local o = vim.opt
local cmd = vim.cmd

local M = {}

M.load_options = function()
	local default_options = {
		background = "dark",
		backup = false, -- creates a backup file
		-- clipboard = "unnamedplus", -- allows neovim to access the system clipboard
		cmdheight = 2, -- more space in the neovim command line for displaying messages
		colorcolumn = "99999", -- fixes indentline for now
		completeopt = { "menuone", "noselect" },
		conceallevel = 0, -- so that `` is visible in markdown files
		fileencoding = "utf-8", -- the encoding written to a file
		foldmethod = "manual", -- folding, set to "expr" for treesitter based folding
		foldexpr = "", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
		foldcolumn = "1",
		foldlevel = 99,
		foldlevelstart = 99,
		foldenable = true,
		guifont = "monospace:h17", -- the font used in graphical neovim applications
		hidden = true, -- required to keep multiple buffers and open multiple buffers
		hlsearch = true, -- highlight all matches on previous search pattern
		ignorecase = true, -- ignore case in search patterns
		mouse = "a", -- allow the mouse to be used in neovim
		pumheight = 10, -- pop up menu height
		showmode = false, -- we don't need to see things like -- INSERT -- anymore
		showtabline = 2, -- always show tabs
		smartcase = true, -- smart case
		autoindent = true,
		smartindent = false, -- make indenting smarter again
		splitbelow = true, -- force all horizontal splits to go below current window
		splitright = false, -- force all vertical splits to go to the right of current window
		swapfile = false, -- creates a swapfile
		termguicolors = true, -- set term gui colors (most terminals support this)
		timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
		title = true, -- set the title of window to the value of the titlestring
		-- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
		-- undodir = utils.join_paths(get_cache_dir(), "undo"), -- set an undo directory
		undofile = true, -- enable persistent undo
		updatetime = 300, -- faster completion
		writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
		expandtab = true, -- convert tabs to spaces
		shiftwidth = 2, -- the number of spaces inserted for each indentation
		tabstop = 2, -- insert 2 spaces for a tab
		cursorline = true, -- highlight the current line
		number = true, -- set numbered lines
		relativenumber = false, -- set relative numbered lines
		numberwidth = 4, -- set number column width to 2 {default 4}
		signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
		wrap = false, -- display lines as one long line
		spell = false,
		spelllang = "en",
		scrolloff = 8, -- is one of my fav
		sidescrolloff = 8,
	}

	o.shortmess:append("c")

	for k, v in pairs(default_options) do
		o[k] = v
	end
end

cmd([[colorscheme tokyodark]])

cmd([[filetype plugin indent on]])

cmd([[
    augroup NoAutoComment
      au!
      au FileType * setlocal formatoptions-=cro
    augroup end
]])

cmd([[
  if exists("+termguicolors")
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
]])

-- vim.api.nvim_create_user_command("Format", function(args)
-- 	local range = nil
-- 	if args.count ~= -1 then
-- 		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
-- 		range = {
-- 			start = { args.line1, 0 },
-- 			["end"] = { args.line2, end_line:len() },
-- 		}
-- 	end
-- 	require("conform").format({ async = true, lsp_fallback = true, range = range })
-- end, { range = true })

-- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- cmd([[ au BufRead, BufNewFile *.py set autoindent]])
cmd([[autocmd BufWritePre *.go :silent! lua require('go.format').goimport()]])

cmd([[autocmd BufNewFile,BufRead /dev/shm/gopass* setlocal noswapfile nobackup noundofile shada=""]])

-- cmd([[ autocmd FileType go autocmd BufWritePre <buffer> :silent! GoImport ]])
return M
