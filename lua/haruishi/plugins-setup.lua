-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

local fn = vim.fn

-- add list of plugins to install
return packer.startup(function(use)
	-- packer can manage itself
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim") -- lua functions that many plugins use
	use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme
	use("christoomey/vim-tmux-navigator") -- tmux & split window navigation
	use("szw/vim-maximizer") -- maximizes and restores current window

	-- essential plugins
	use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
	use("inkarkat/vim-ReplaceWithRegister") -- replace with register contents using motion (gr + motion)

	-- file explorer
	use("nvim-tree/nvim-tree.lua")

	-- theprimeagen's
	use("theprimeagen/harpoon")

	-- vs-code like icons
	use("nvim-tree/nvim-web-devicons")

	-- statusline
	use("nvim-lualine/lualine.nvim")

	-- fuzzy finding w/ telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder
	use("nvim-telescope/telescope-bibtex.nvim")

	-- autocompletion
	use("hrsh7th/nvim-cmp") -- completion plugin
  use({
    -- cmp LSP completion
    "hrsh7th/cmp-nvim-lsp",
    -- cmp Snippet completion
    "hrsh7th/cmp-vsnip",
    -- cmp Path completion
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    after = { "hrsh7th/nvim-cmp" },
    requires = { "hrsh7th/nvim-cmp" },
  })

	-- snippets
  use('hrsh7th/vim-vsnip') -- snippet engine
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

  -- Adds extra functionality over rust analyzer
  use("simrat39/rust-tools.nvim")
  use("rust-lang/rust.vim")

	-- managing & installing lsp servers, linters & formatters
	use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	use("neovim/nvim-lspconfig") -- easily configure language servers
	use({ "nvimdev/lspsaga.nvim", branch = "main" }) -- enhanced lsp uis
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	-- treesitter configuration
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- treesitter playground
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("nvim-treesitter/nvim-treesitter-context")

	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

	-- floating terminal
	use("voldikss/vim-floaterm")

	-- wakatime
	use("wakatime/vim-wakatime")

	-- latex (for macos)
	use({ "lervag/vimtex", cond = fn.has("mac") == 1 })
	use({
		"f3fora/nvim-texlabconfig",
		run = "go build",
		config = [[require('texlabconfig').setup()]],
    cond = fn.has("mac") == 1
	})

	-- neodev
	use("folke/neodev.nvim")

	-- comment out tool
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- aerial
	use("stevearc/aerial.nvim")

	-- vim surround
	use({
		"kylechui/nvim-surround",
		config = [[require('nvim-surround').setup()]],
	})

	-- copilot (experimental)
	-- can't get it to work
	use({
		"zbirenbaum/copilot.lua",
		event = "VimEnter",
		config = function()
			vim.defer_fn(function()
				require("copilot").setup()
			end, 100)
		end,
	})
	use({
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	})

	-- markdown preview (without yarn or npm)
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

  -- rust debug
  use('mfussenegger/nvim-dap')
  use('jay-babu/mason-nvim-dap.nvim')  -- bridge the gap between nvim-dap and mason
  use({ "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}})

  -- odin plugin
  use('Tetralux/odin.vim')

  -- obsidian
  use({
    "epwalsh/obsidian.nvim",
    tag = "*",  -- recommended, use latest release instead of latest commit
    requires = {
      "nvim-lua/plenary.nvim",
    },
    cond = fn.has("mac") == 1,
    config = function()
      require("obsidian").setup({
        workspaces = {
          {
            name = "research",
            path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/research_vault",
          },
          {
            name = "hobby",
            path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/hobby_vault",
          },
        },
        open_app_foreground = true,
        ui = {
          enable = false,
        },
      })
    end,
  })

	if packer_bootstrap then
		require("packer").sync()
	end
end)
