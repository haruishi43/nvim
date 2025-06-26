-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

-- movements and retain middle of the screen
keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- move highlighted texts up and down (even indent inside `if`s)
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- dont' press Q
keymap.set("n", "Q", "<nop>")

-- tabbing
keymap.set("n", "to", ":tabnew<CR>") -- open new tab
keymap.set("n", "tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "tp", ":tabp<CR>") --  go to previous tab

-- file
keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find Keymaps" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Search String" })

-- ui
keymap.set("n", "<leader>uH", "<cmd>set hlsearch!<cr>", { desc = "Toggle Highlight Search" })
keymap.set("n", "<leader>uN", "<cmd>nohl<cr>", { desc = "Clear Search Highlight" })

-- obsidian
keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<cr>", { desc = "Open Obsidian" })
keymap.set("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "New Obsidian Note" })
keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<cr>", { desc = "Obsidian Backlinks" })
keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<cr>", { desc = "Obsidian Links" })
keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<cr>", { desc = "Obsidian Search" })
keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Obsidian Quick Switch" })
