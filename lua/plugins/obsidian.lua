local fn = vim.fn
local vault_path = fn.expand("~/writing/Obsidian/research_vault")

if fn.has("mac") ~= 1 or fn.isdirectory(vault_path) ~= 1 then
  return {}
end

return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "research",
        path = vault_path,
      },
    },
    open_app_foreground = true,
    ui = {
      enable = false,
    },
  },
}
