-- import nvim-cmp plugin safely
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

-- import luasnip plugin safely
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

-- import lspkind plugin safely
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end

local has_copilot, copilot_cmp = pcall(require, "copilot_cmp.comparators")

-- load vs-code like snippets from plugins (e.g. friendly-snippets)
require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	-- sources for autocompletion
	sources = cmp.config.sources({
		{ name = "path", group_index = 2 }, -- file system paths
		{ name = "nvim_lsp", group_index = 3 }, -- lsp
    { name = 'nvim_lsp_signature_help'}, -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2}, -- complete neovim's Lua runtime API such vim.lsp.*
		{ name = "buffer", group_index = 2 }, -- text within current buffer
		{ name = "luasnip", group_index = 2, option = { show_autosnippets = true } }, -- snippets
    -- { name = 'vsnip', keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
		-- other soruce
		{ name = "copilot", group_index = 2 }, -- copilot
	}),
	-- configure lspkind for vs-code like icons
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
	sorting = {
		priority_weight = 2,
		comparators = {
			cmp.config.compare.exact,
			has_copilot and copilot_cmp.prioritize or nil,
			has_copilot and copilot_cmp.score or nil,
			cmp.config.compare.offset,
			-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.locality,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
})
