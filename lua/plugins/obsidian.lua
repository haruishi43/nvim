local fn = vim.fn
if fn.has("mac") ~= 1 then
    return {}
end

return {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "research",
                path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/research_vault",
            },
            {
                name = "life",
                path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/life_vault",
            },
        },
        open_app_foreground = true,
        ui = {
            enable = false,
        },
    },
}