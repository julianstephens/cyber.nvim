-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
require("lazy").setup({
	{ "nvim-tree/nvim-web-devicons" },
	-- Syntax Highlighting & Visual
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("core.colorizer")
		end,
		event = "BufRead",
	},
	{
		"hoob3rt/lualine.nvim",
		config = function()
			require("core.lualine")
		end,
		event = "BufWinEnter",
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("core.bufferline")
		end,
	},
	{
		"goolord/alpha-nvim",
		config = function()
			require("core.alpha")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("core.blankline")
		end,
		event = "BufRead",
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
	},
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-github.nvim" },
		config = function()
			require("core.telescope")
		end,
	},
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{ "nvim-telescope/telescope-file-browser.nvim" },
	{ "nvim-telescope/telescope-project.nvim" },

	-- -- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
		config = function()
			require("core.lspconfig")
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("core.conform")
		end,
	},
	{
		"jose-elias-alvarez/nvim-lsp-ts-utils",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	"hrsh7th/cmp-nvim-lsp",
	{ "hrsh7th/cmp-buffer" },
	{ "saadparwaiz1/cmp_luasnip" },
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		dependencies = { "molleweide/LuaSnip-snippets.nvim", "rafamadriz/friendly-snippets" },
		config = function()
			require("core.luasnip")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("core.cmp")
		end,
	},
	{
		"windwp/nvim-autopairs",
		after = { "nvim-cmp" },
		config = function()
			require("core.autopairs")
		end,
	},
	{ "onsails/lspkind-nvim" },
	{
		"folke/trouble.nvim",
		config = function()
			require("core.trouble")
		end,
	},
	{
		"ray-x/go.nvim",
		config = function()
			require("go").setup()
		end,
	},
	"ray-x/guihua.lua", -- recommended if need floating window support

	-- Todo
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"RutaTang/quicknote.nvim",
		config = function()
			-- you must call setup to let quicknote.nvim works correctly
			require("quicknote").setup({
				mode = "resident",
				git_branch_recognizable = false,
			})
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- -- Themes
	"folke/tokyonight.nvim",
	"tiagovla/tokyodark.nvim",

	-- -- TreeSitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufWinEnter",
		run = ":TSUpdate",
		config = function()
			require("core.treesitter")
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		after = "nvim-treesitter",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup()
		end,
		after = "nvim-treesitter",
	},

	-- Writing
	"junegunn/goyo.vim",
	"junegunn/limelight.vim",
	{
		"preservim/vim-pencil",
		config = function()
			require("core.pencil")
		end,
	},
	{
		"gaoDean/autolist.nvim",
		config = function()
			require("autolist").setup({})
		end,
	},
	"allen-mack/nvim-table-md",

	-- Miscellaneous
	{
		"ellisonleao/glow.nvim",
		config = function()
			require("glow").setup({
				width = 120,
			})
		end,
	},

	{
		"gaoDean/autolist.nvim",
		ft = {
			"markdown",
			"text",
			"tex",
			"plaintex",
			"norg",
		},
		config = function()
			require("core.autolist")
		end,
	},
	{
		"terrortylor/nvim-comment",
		cmd = "CommentToggle",
		config = function()
			require("core.comment")
		end,
	},
	{
		"folke/which-key.nvim",
		event = "BufWinEnter",
		config = function()
			require("core.whichkey")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("core.gitsigns")
		end,
	},
	{
		"danymat/neogen",
		config = function()
			require("neogen").setup({
				enabled = true,
				languages = {
					typescript = {
						template = {
							annotation_convention = "tsdoc",
						},
					},
				},
			})
		end,
		after = "nvim-treesitter",
	},
	"tpope/vim-repeat",
	{ "mrjones2014/legendary.nvim" },
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup()
		end,
	},
	{
		"ggandor/lightspeed.nvim",
		config = function()
			require("core.lightspeed")
		end,
	},
	{
		"phaazon/hop.nvim",
		config = function()
			require("hop").setup()
		end,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				window = {
					filesystem = {
						filtered_items = {
							hide_dotfiles = false,
							hide_hidden = false,
							hide_by_name = {
								"node_modules",
							},
						},
					},
				},
			})
		end,
	},
	{
		"s1n7ax/nvim-window-picker",
		name = "window-picker",
		event = "VeryLazy",
		version = "2.*",
		config = function()
			require("window-picker").setup()
		end,
	},
})
