
local status_ok, wk = pcall(require, "which-key")
if not status_ok then
    return
end

wk.setup()
wk.add({
  { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer", mode = "n" },
  { "<leader>m", "<cmd>Mason<cr>", desc = "Mason", mode = "n" },
  { "<leader>p", "<cmd>Lazy<CR>", desc = "Plugin Manager", mode = "n" },
  { "<leader>+", "<C-a>", desc = "Increment Number", mode = "n" },
  { "<leader>-", "<C-x>", desc = "Decrement Number", mode = "n" },
  { "<leader>hs", "<cmd>set hlsearch!<cr>", desc = "Highlight Search", mode = "n" },
  { "<leader>hn", "<cmd>nohl<cr>", desc = "Clear Search Highlight" },
  { "<leader>rel", "<cmd>e $NVIM_LOG_FILE<cr>", desc = "View Error Log for NVIM" },

  -- Telescope
  { "<leader>f", group = "file" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files", mode = "n" },
  { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Search String", mode = "n" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "List Opened Buffers", mode = "n" },
  { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands", mode = "n"},
  { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "List Available Help Tags", mode = "n" },
  { "<leader>fr", "<cmd>Telescope registers<cr>", desc = "Registers", mode = "n" },
  { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", mode = "n" },
  { "<leader>ft", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", mode = "n" },

  -- Language Server
  { "<leader>l", group = "LSP" },
  { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info", mode = "n" },
  { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", mode = "n" },
  { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols", mode = "n" },
  {
    "<leader>lS",
    "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
    desc = "Workspace Symbols",
    mode = "n",
  },
  { "<leader>lR", "<cmd>LspRestart<cr>", desc = "Restart Lsp", mode = "n"},
  { "<leader>la", "<cmd>Lspsaga code_action<cr>", desc = "See Available Code Actions", mode = "n" },
  { "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "Show Diagnostics For Line", mode = "n" },
  { "<leader>lo", "<cmd>LSoutlineToggle<cr>", desc = "See Outline on Right Hand Side", mode = "n" },

  -- git
  { "<leader>glc", "<cmd>Telescope git_commits<cr>", desc = "List Commits", mode = "n" },
  { "<leader>gbc", "<cmd>Telescope git_bcommits<cr>", desc = "List Commits For Current File/Buffer", mode = "n" },
  { "<leader>glb", "<cmd>Telescope git_branches<cr>", desc = "List Branches", mode = "n" },
  { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "List Current Changes Per File With Diff Preview", mode = "n" },

  --Toggle Term
  { "<leader>tn", "<cmd>lua _NODE_TOGGLE()<cr>", desc = "Node", mode = "n" },
  { "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", desc = "Python", mode = "n" },
  { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float", mode = "n" },
  { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal", mode = "n" },
  { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical", mode = "n" },

  -- window
  { "<leader>sv", "<C-w>v", desc = "Split Window Vertically", mode = "n" },
  { "<leader>sh", "<C-w>s", desc = "Split Window Horizontally", mode = "n" },
  { "<leader>se", "<C-w>=", desc = "Make Split Windows Equal Width/Height", mode = "n" },
  { "<leader>sx", "<cmd>close<cr>", desc = "Close Current Split Window", mode = "n" },
  { "<leader>sm", "<cmd>MaximizerToggle<cr>", desc = "Split Window Maximization", mode = "n" },

  -- obsidian
  { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open in Obsidian App", mode = "n" },
  { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Show Obsidian BackLinks", mode = "n" },
  { "<leader>ol", "<cmd>ObsidianLinks<cr>",  desc = "Show Obsidian Links", mode = "n" },
  { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "Create New Note", mode = "n" },
  { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search Obsidian", mode = "n" },
  { "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick Switch", mode = "n" },

})

