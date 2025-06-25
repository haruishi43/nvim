-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- set keybinds
	keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts) -- show definition, references
	keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
	-- keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	-- keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	-- keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	-- keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
	-- keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local icons = {
  [vim.diagnostic.severity.ERROR] = " ",  -- ERROR
  [vim.diagnostic.severity.WARN]  = " ",  -- WARN
  [vim.diagnostic.severity.HINT]  = "󰌶",  -- HINT
  -- [vim.diagnostic.severity.HINT]  = "ﴞ ",  -- HINT
  [vim.diagnostic.severity.INFO]  = " ",  -- INFO
}
vim.diagnostic.config({
  signs = {
    text  = icons,   -- sign text per-severity
    numhl = {},      -- keep default line-number highlights
  },
})

-- configure html server
lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure css server
lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure typescript server
lspconfig["ts_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure ruff
require('lspconfig').ruff.setup({
  init_options = {
    settings = {
      -- Ruff language server settings go here
    }
  }
})

-- configure python
-- lspconfig["basedpyright"].setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
--   settings = {
--     -- setting
--   }
-- })

-- warning: multiple different client offset_encodings detected for buffer
local clangd_capabilities = vim.lsp.protocol.make_client_capabilities()
clangd_capabilities["offsetEncoding"] = "utf-8"
-- configure clangd
lspconfig["clangd"].setup({
	capabilities = clangd_capabilities,
	on_attach = on_attach,
	filetypes = { "c", "cpp", "cc" },
})

-- configure dockerls
lspconfig["dockerls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

--configure rust
lspconfig["rust_analyzer"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
      cargo = {
        allFeatures = true,
      },
    },
  }
})

--configure odin
lspconfig["ols"].setup({
  capabilities = capabilities,
	on_attach = on_attach,
  filetypes = { "odin" },
})

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

-- LaTeX configuration:
-- local build_executable = 'tectonic'
-- local build_args = {
-- 	'-X',
-- 	'compile',
-- 	'%f',
-- 	'--synctex',
-- 	'--keep-logs',
-- 	'--keep-intermediates',
-- }
local build_executable = "latexmk"
local build_args = {
	"-xelatex",
	-- '-verbose',
	"-synctex=1",
	"-interaction=nonstopmode",
	"%f",
}
local binary_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/nvim-texlabconfig/nvim-texlabconfig"
local cache_root = vim.fn.stdpath("cache")
local forward_executable = "/Applications/sioyek.app/Contents/MacOS/sioyek"
local forward_args = {
	"--inverse-search",
	binary_path .. " -file %1 -line %2 -cache_root " .. cache_root,
	"--reuse-instance",
	"--forward-search-file",
	"%f",
	"--forward-search-line",
	"%l",
	"%p",
}
-- local executable = '/Applications/Skim.app/Contents/SharedSupport/displayline',
-- local args = { '%l', '%p', '%f' },
lspconfig["texlab"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		texlab = {
			build = {
				executable = build_executable,
				args = build_args,
				-- forwardSearchAfter = true,
				onSave = true,
			},
			forwardSearch = {
				executable = forward_executable,
				args = forward_args,
			},
			diagnostics = {
				ignoredPatterns = {
					"^Overfull",
					"^Underfull",
				},
			},
		},
	},
})

-- brew install ltex-ls (need to sim-link!!!)
-- https://stackoverflow.com/questions/65601196/how-to-brew-install-java
lspconfig["ltex"].setup({
	on_attach = on_attach,
	cmd = { "ltex-ls" },
	filetypes = { "plaintex", "tex" },
	settings = {
		ltex = {
			language = "en",
		},
	},
	flags = { debounce_text_changes = 300 },
})
