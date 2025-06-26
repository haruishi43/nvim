-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_picker = "telescope"

local opt = vim.opt

-- This file is automatically loaded by plugins.core
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- want to use the current working directory as the root
vim.g.root_spec = { "cwd" }

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search setting
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true
-- opt.iskeyword:append("-")

-- cursor line
opt.cursorline = true

-- apperaance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.colorcolumn = "80"

-- lagggggg
-- vim.opt.updatetime = 50
opt.updatetime = 200  -- lazy default

-- backspace
opt.backspace = "indent,eol,start"

-- moved from unnamedplus
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard

-- split windows
opt.splitright = true
opt.splitbelow = true
