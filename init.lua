-- plugin setup
require("haruishi.plugins-setup")

-- core
require("haruishi.core.options")
require("haruishi.core.keymaps")
require("haruishi.core.colorscheme")

-- plugins
require("haruishi.plugins.comment")
require("haruishi.plugins.nvim-tree")
require("haruishi.plugins.lualine")
require("haruishi.plugins.telescope")
require("haruishi.plugins.nvim-cmp")
require("haruishi.plugins.lsp.mason")
require("haruishi.plugins.lsp.lspsaga")
require("haruishi.plugins.lsp.lspconfig")
require("haruishi.plugins.lsp.null-ls")
require("haruishi.plugins.autopairs")
require("haruishi.plugins.treesitter")
require("haruishi.plugins.gitsigns")
require("haruishi.plugins.surround")
require("haruishi.plugins.vimtex")
require("haruishi.plugins.luasnip")

-- experimental
require("haruishi.plugins.copilot")

-- FIXME: libuv bug???
vim.api.nvim_create_autocmd({ "VimLeave" }, {
	callback = function()
		vim.cmd("sleep 10m")
	end,
})
