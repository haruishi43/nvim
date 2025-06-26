vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff"

return {
  -- change basedpyright config
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          settings = {
            ["rust-analyzer"] = {},
          },
          keys = {
            {
              "<leader>co",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
          },
        },
        basedpyright = {
          settings = {
            analysis = {
              typeCheckingMode = "basic", -- can be "off", "basic", or "strict"
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      },
    },
  },
}
