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

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
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
        ltex = {
          cmd = { "ltex-ls" },
          filetypes = { "tex", "bib" },
          settings = {
            ltex = {
              disabledRules = {
                ["en-US"] = { "SPELL_CHECKING" },
              },
            },
          },
          flags = { debounce_text_changes = 300 },
        },
      },
    },
  },
}

