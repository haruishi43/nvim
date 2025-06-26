vim.g.lazyvim_python_lsp = "basedpyright"
-- vim.g.lazyvim_python_ruff = "ruff"

return {
  { import = "lazyvim.plugins.extras.lang.python" },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       ruff = {
  --         keys = {
  --           {
  --             "<leader>co",
  --             LazyVim.lsp.action["source.organizeImports"],
  --             desc = "Organize Imports",
  --             mode = { "n" },
  --           },
  --         },
  --       },
  --       -- change basedpyright config
  --       basedpyright = {
  --         settings = {
  --           analysis = {
  --             typeCheckingMode = "basic", -- can be "off", "basic", or "strict"
  --             autoSearchPaths = true,
  --             useLibraryCodeForTypes = true,
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
}
