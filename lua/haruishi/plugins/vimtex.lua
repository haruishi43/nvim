vim.g.tex_flavor = "latex"
vim.g.tex_comment_nospell = 1

vim.wo.conceallevel = 2

vim.g.vimtex_quickfix_ignore_filters = {
	"Underfull",
	"Overfull",
}

vim.g.vimtex_quickfix_mode = 2
vim.g.vimtex_view_method = "sioyek"
vim.g.vimtex_view_sioyek_exe = "/Applications/sioyek.app/Contents/MacOS/sioyek"
vim.g.vimtex_imaps_enabled = 0
vim.g.vimtex_complete_enabled = 0

vim.keymap.set("n", "<M-b>", "<Cmd>TexlabBuild<CR>", { buffer = true, desc = "Build LaTeX" })
vim.keymap.set("n", "<M-f>", "<Cmd>TexlabForward<CR>", { buffer = true, desc = "Build LaTeX" })

local vim_surround_setup, vim_surround = pcall(require, "nvim-surround")
if not vim_surround_setup then
	return
end

local fn = vim.fn
vim_surround.buffer_setup({
	surrounds = {
		['"'] = {
			add = { "``", "''" },
			find = "``.-''",
			delete = "^(``)().-('')()$",
		},
		["$"] = {
			add = { "\\(", "\\)" },
			find = "\\%(.-\\%)",
			delete = "^(\\%()().-(\\%))()$",
			change = {
				target = "^(\\%()().-(\\%))()}$",
				replacement = function()
					return { { "\\%[\n\t" }, { "\n\\%]" } }
				end,
			},
		},
		["e"] = {
			add = function()
				local env = fn.input({ prompt = "Environment: " })
				return { { "\\begin{" .. env .. "}" }, { "\\end{" .. env .. "}" } }
			end,
			find = "\\begin%b{}\n.-\n\\end%b{}",
			delete = "^(\\begin%b{}\n)().-(\n\\end%b{})()$",
			change = {
				target = "^\\begin%{(.-)()%}.-\\end%{(.-)()%}$",
				replacement = function()
					local env = fn.input({ prompt = "Environment: " })
					return { { env }, { env } }
				end,
			},
		},
	},
})
