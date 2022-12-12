return {
	config = function()
		require("plugins.luasnip.mappings")
		require("plugins.luasnip.settings")
		-- require("plugins.luasnip.snips.lua")
		-- require("plugins.luasnip.snips.cmake")
		-- require("plugins.luasnip.snips.python")
		require("plugins.luasnip.snips.tex")
		require("plugins.luasnip.snips.tex_math")
		-- require("plugins.luasnip.snips.cpp")
	end,
}
