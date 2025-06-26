return {
  {
    "EdenEast/nightfox.nvim",
    -- config = function()
    --   require("nightfox").setup({
    --     options = {
    --       dim_inactive = true, -- dim inactive windows
    --     }
    --   })
    -- end,
    opts = {
      options = {
        dim_inactive = true, -- dim inactive windows
      },
    },
  },
  -- Configure LazyVim to load carbonfox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "carbonfox",
      -- colorscheme = "nightfox",
    },
  },
}

