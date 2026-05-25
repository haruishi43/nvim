-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_picker = "telescope"

-- Enable Copilot only when it has been authenticated (`:Copilot auth`).
-- copilot.lua reads its OAuth token from this dir; when it's absent (e.g. a
-- machine where Copilot isn't set up yet) we skip the plugin entirely to avoid
-- "not authenticated" warnings on startup. It turns on automatically once the
-- file appears, no config changes needed.
local copilot_dir = (vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")) .. "/github-copilot"
vim.g.ai_copilot = vim.uv.fs_stat(copilot_dir .. "/apps.json") ~= nil
  or vim.uv.fs_stat(copilot_dir .. "/hosts.json") ~= nil

-- setting lsp log off for now because it's stable, but should
-- be "debug" when debugging
vim.lsp.log.set_level("off")
vim.api.nvim_create_user_command("LspLogClear", function()
  vim.fn.writefile({}, vim.lsp.log.get_filename()) -- overwrite with an empty file
end, {})

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

-- auto-load files changed outside of nvim
opt.autoread = true

-- lagggggg
-- vim.opt.updatetime = 50
opt.updatetime = 200 -- lazy default

-- backspace
opt.backspace = "indent,eol,start"

-- moved from unnamedplus
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard

-- split windows
opt.splitright = true
opt.splitbelow = true
