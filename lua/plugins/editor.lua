-- Show invisible characters
vim.opt.list = true -- enable :list
vim.opt.listchars:append({
  space = "·", -- middle-dot for spaces
  tab = "»·", -- "»" at tab start, then a dot
  trail = "•", -- optional: bullet for trailing whitespace
  extends = "›", -- optional: show line overflow
  precedes = "‹",
})

return {
  { import = "lazyvim.plugins.editor" },
}

