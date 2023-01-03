vim.wo.conceallevel = 2
-- vim.wo.spell = true

-- markdown preview
vim.keymap.set("n", "<leader>m", "<cmd>MarkdownPreview <cr>") -- start preview
vim.keymap.set("n", "<leader>ms", "<cmd>MarkdownPreviewStop <cr>") -- stop preview
vim.keymap.set("n", "<leader>mt", "<cmd>MarkdownPreviewToggle <cr>") -- toggle
vim.g.mkdp_page_title = "${name}"
vim.g.mkdp_theme = "dark"
