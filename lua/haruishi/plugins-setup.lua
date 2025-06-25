-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = '\\'

local fn = vim.fn

require('lazy').setup({
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use
	-- "bluz71/vim-nightfly-guicolors", -- preferred colorscheme
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  -- },
  -- "folke/tokyonight.nvim",
	"nvim-lualine/lualine.nvim", -- statusline
	"nvim-tree/nvim-web-devicons", -- vs-code like icons
	"nvim-tree/nvim-tree.lua", -- file explorer


	-- essential plugins
	-- "tpope/vim-surround", -- add, delete, change surroundings (it's awesome)
	-- "inkarkat/vim-ReplaceWithRegister", -- replace with register contents using motion (gr + motion)
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation
	"szw/vim-maximizer", -- maximizes and restores current window
	-- {"kylechui/nvim-surround", config = [[require('nvim-surround').setup()]]}, -- vim surround
  { 'echasnovski/mini.surround', version = false },

	-- fuzzy finding w/ telescope
	{
    -- dependency for better sorting performance
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
	{
    "nvim-telescope/telescope.nvim", -- fuzzy finder
    branch = "0.1.x",
  },
	"nvim-telescope/telescope-bibtex.nvim",

	-- autocompletion
  -- completion plugin
	{
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- cmp LSP completion
      "hrsh7th/cmp-vsnip", -- cmp Snippet completion
      "hrsh7th/cmp-path", -- cmp Path completion
      "hrsh7th/cmp-buffer",
    },
  },

	-- snippets
  'hrsh7th/vim-vsnip', -- snippet engine
	"L3MON4D3/LuaSnip", -- snippet engine
	"saadparwaiz1/cmp_luasnip", -- for autocompletion
	"rafamadriz/friendly-snippets", -- useful snippets

  	-- managing & installing lsp servers, linters & formatters
	"williamboman/mason.nvim", -- in charge of managing lsp servers, linters & formatters
	"williamboman/mason-lspconfig.nvim", -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	"neovim/nvim-lspconfig", -- easily configure language servers
	{"nvimdev/lspsaga.nvim", branch = "main" }, -- enhanced lsp uis
	"onsails/lspkind.nvim", -- vs-code like icons for autocompletion

	-- treesitter configuration
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
    dependencies={
      "windwp/nvim-ts-autotag",
    }
	},

	-- treesitter playground
	"nvim-treesitter/nvim-treesitter-textobjects",
	"nvim-treesitter/nvim-treesitter-context",

	-- auto closing
	"windwp/nvim-autopairs", -- autoclose parens, brackets, quotes, etc...

	-- git integration
	"lewis6991/gitsigns.nvim", -- show line modifications on left hand side

	-- terminal
	-- "voldikss/vim-floaterm",
  {'akinsho/toggleterm.nvim', version = "*", config = true},

  -- which-key
  {
    'folke/which-key.nvim',
    lazy = true,
  },


	-- wakatime
	"wakatime/vim-wakatime",

	
	-- neodev
	"folke/neodev.nvim",  -- TODO: udpate to lazydev.nvim

	-- aerial
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
  },

	-- markdown preview (without yarn or npm)
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

  -- rust
  'mfussenegger/nvim-dap',
  'jay-babu/mason-nvim-dap.nvim',  -- bridge the gap between nvim-dap and mason
  { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap"}},
  -- Adds extra functionality over rust analyzer
  "simrat39/rust-tools.nvim",
  "rust-lang/rust.vim",

  -- odin plugin
  "Tetralux/odin.vim",

  -- latex (for macos)
	{ "lervag/vimtex", enabled = fn.has("mac") == 1 },
	{
		"f3fora/nvim-texlabconfig",
		build = "go build",
		config = [[require('texlabconfig').setup()]],
    enabled = fn.has("mac") == 1
	},


  -- obsidian
  {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    enabled = fn.has("mac") == 1,
    opts = {
      workspaces = {
        {
          name = "research",
          path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/research_vault",
        },
        {
          name = "life",
          path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/life_vault",
        },
      },
      open_app_foreground = true,
      ui = {
        enable = false,
      },
    },
  },

  -- other plugins
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

	-- copilot
	{
		"zbirenbaum/copilot.lua",
		event = "VimEnter",
		config = function()
			vim.defer_fn(function()
				require("copilot").setup()
			end, 100)
		end,
    dependencies={
      {
        "zbirenbaum/copilot-cmp",
        config = function()
			    require("copilot_cmp").setup()
		    end,
      },
    }
	},
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- add any opts here
      -- for example
      provider = "copilot",
      auto_suggestions_provider = "copilot",
      providers = {
        copilot = {
	        model = "claude-sonnet-4",
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "stevearc/dressing.nvim", -- for input provider dressing
      "folke/snacks.nvim", -- for input provider snacks
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  -- {
  --   "greggh/claude-code.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim", -- Required for git operations
  --   },
  --   config = function()
  --     require("claude-code").setup()
  --   end
  -- }
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>c", nil, desc = "AI/Claude Code" },
      { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>cs",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil" },
      },
      -- Diff management
      { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  }
})
