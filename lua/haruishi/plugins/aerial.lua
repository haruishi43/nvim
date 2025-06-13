local aerial_setup, aerial = pcall(require, "aerial")
if not aerial_setup then
	return
end

aerial.setup({
	show_guides = true,
})

-- aerial
vim.keymap.set("n", "<leader>ao", "<cmd>AerialToggle!<CR>")
