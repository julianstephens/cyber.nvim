-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function()
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Syntax Highlighting & Visual
	use("kyazdani42/nvim-web-devicons")
	use({
		"norcalli/nvim-colorizer.lua",
		config = "require'core.colorizer'",
		event = "BufRead",
	})
	use({
		"hoob3rt/lualine.nvim",
		config = "require'core.lualine'",
		requires = {
			"kyazdani42/nvim-web-devicons",
			opt = true,
		},
		event = "BufWinEnter",
	})
	use({
		"akinsho/bufferline.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = "require'core.bufferline'",
	})
	use({
		"glepnir/dashboard-nvim",
		config = "require'core.dashboard'",
		event = "BufWinEnter",
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = "require'core.blankline'",
		event = "BufRead",
	})

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		config = "require'core.lspconfig'",
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = "require'core.null-ls'",
		requires = { "nvim-lua/plenary.nvim" },
	})
	use({
		"jose-elias-alvarez/nvim-lsp-ts-utils",
		requires = { "nvim-lua/plenary.nvim" },
	})
	-- use {
	--     'glepnir/lspsaga.nvim',
	--     config = "require'core.lspsaga'"
	-- }
	use({
		"hrsh7th/nvim-cmp",
		event = "InsertEnter *",
		config = "require'core.cmp'",
	})
	use("hrsh7th/cmp-nvim-lsp")
	use({
		"hrsh7th/cmp-buffer",
		after = "nvim-cmp",
	})
	use({
		"hrsh7th/cmp-vsnip",
		after = "nvim-cmp",
	})
	use({
		"hrsh7th/vim-vsnip",
		after = "nvim-cmp",
	})
	use({
		"windwp/nvim-autopairs",
		after = "nvim-cmp",
		config = "require'core.autopairs'",
	})
	use({ "onsails/lspkind-nvim" })
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = "require'core.trouble'",
	})

	-- Todo
	-- use("vuciv/vim-bujo")
	use("kvrohit/tasks.nvim")
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	-- Themes
	use("folke/tokyonight.nvim")

	-- Tree-Sitter
	use({
		"nvim-treesitter/nvim-treesitter",
		event = "BufWinEnter",
		run = ":TSUpdate",
		config = "require'core.treesitter'",
	})
	use({
		"p00f/nvim-ts-rainbow",
		after = "nvim-treesitter",
	})
	use({
		"windwp/nvim-ts-autotag",
		after = "nvim-treesitter",
	})
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	})
	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		after = "nvim-treesitter",
	})

	-- Terminal Integration
	use({
		"akinsho/nvim-toggleterm.lua",
		config = "require'core.toggleterm'",
	})

	-- Navigation
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = "require'core.telescope'",
	})
	use({
		"kyazdani42/nvim-tree.lua",
		cmd = "NvimTreeToggle",
		config = "require'core.nvimtree'",
	})

	-- Miscellaneous
	use({
		"terrortylor/nvim-comment",
		cmd = "CommentToggle",
		config = "require'core.comment'",
	})
	use({
		"folke/which-key.nvim",
		event = "BufWinEnter",
		config = "require'core.whichkey'",
	})
	use({
		"phaazon/hop.nvim",
		branch = "v1", -- optional but strongly recommended,
		config = function()
			require("hop").setup()
		end,
	})
	use({ "andweeb/presence.nvim" })
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = "require'core.gitsigns'",
	})
	use({
		"danymat/neogen",
		config = function()
			require("neogen").setup({
				enabled = true,
			})
		end,
		after = "nvim-treesitter",
		-- requires = { "nvim-treesitter/nvim-treesitter" },
	})
end)
