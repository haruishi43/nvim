-- import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

-- import mason-dap plugin
local mason_dap_status, mason_dap = pcall(require, "mason-nvim-dap")
if not mason_dap_status then
  return
end

-- enable mason
mason.setup()

mason_lspconfig.setup({
	-- list of servers for mason to install
	ensure_installed = {
		"html",
		"cssls",
		"ts_ls", -- typescript/javascript
		-- "pyright", -- python
    -- "basedpyright", -- python
    "ruff", -- python
		"clangd", -- c/c++
		"dockerls", -- docker
		"lua_ls", -- lua
		"rust_analyzer", -- rust
		"ltex", -- latex
    "ols", -- odin
	},
	-- auto-install configured servers (with lspconfig)
	automatic_installation = true, -- not the same as ensure_installed
})

mason_dap.setup({
  ensure_installed = {
    "codelldb",
  },
  automatic_installation = true,
})
