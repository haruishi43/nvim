-- Copilot runs as a plain LSP server (`copilot-language-server`):
-- Neovim's built-in inline completion draws the ghost text, and copilot-lsp
-- adds the next-edit-suggestion (NES) jump-and-apply UX on top.
return {
  {
    "copilotlsp-nvim/copilot-lsp",
    init = function()
      vim.g.copilot_nes_debounce = 500

      -- Ghost text is handled by core, once a server advertises the capability
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("copilot_inline_completion", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client or not client:supports_method("textDocument/inlineCompletion", args.buf) then
            return
          end

          -- <Tab> accepts; it's wired up in lua/plugins/blink.lua
          vim.lsp.inline_completion.enable(true, { bufnr = args.buf })

          vim.keymap.set("i", "<M-]>", function()
            vim.lsp.inline_completion.select()
          end, { buffer = args.buf, desc = "Next Copilot suggestion" })
          vim.keymap.set("i", "<M-[>", function()
            vim.lsp.inline_completion.select({ count = -1 })
          end, { buffer = args.buf, desc = "Previous Copilot suggestion" })
        end,
      })

      -- NES suggestions are normal-mode edits elsewhere in the buffer:
      -- <Tab> walks to them and applies, <Esc> dismisses. Both fall through
      -- to their usual behavior when nothing is pending.
      vim.keymap.set("n", "<Tab>", function()
        if not vim.b.nes_state then
          return "<Tab>"
        end
        local nes = require("copilot-lsp.nes")
        local _ = nes.walk_cursor_start_edit() or (nes.apply_pending_nes() and nes.walk_cursor_end_edit())
      end, { expr = true, desc = "Copilot NES: jump to / apply edit" })

      vim.keymap.set("n", "<Esc>", function()
        if not require("copilot-lsp.nes").clear() then
          return "<Esc>"
        end
      end, { expr = true, desc = "Dismiss Copilot NES suggestion" })
    end,
  },

  -- Enable the server itself, with the NES wiring copilot-lsp needs
  {
    "neovim/nvim-lspconfig",
    dependencies = { "copilotlsp-nvim/copilot-lsp" },
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.copilot = {
        settings = {
          nextEditSuggestions = { enabled = true },
        },
        handlers = require("copilot-lsp.handlers"),
        on_init = function(client)
          local au = vim.api.nvim_create_augroup("copilotlsp.init", { clear = true })
          require("copilot-lsp.nes").lsp_on_init(client, au)
        end,
      }
    end,
  },
}
