local fn = vim.fn

if fn.has("mac") ~= 1 then
  return {}
end

vim.g.tex_flavor = "latex"
vim.g.tex_comment_nospell = 1

vim.g.vimtex_quickfix_ignore_filters = {
  "Underfull",
  "Overfull",
}

vim.g.vimtex_quickfix_mode = 2
vim.g.vimtex_view_method = "sioyek"
vim.g.vimtex_view_sioyek_exe = "/Applications/sioyek.app/Contents/MacOS/sioyek"
vim.g.vimtex_imaps_enabled = 0
vim.g.vimtex_complete_enabled = 0

return {
  { "lervag/vimtex" },
  {
    "f3fora/nvim-texlabconfig",
    build = "go build",
    config = [[require('texlabconfig').setup()]],
  },
  { "nvim-telescope/telescope-bibtex.nvim" },
}