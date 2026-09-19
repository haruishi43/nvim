# GitHub Copilot

Copilot runs as a plain LSP server. Neovim 0.12 handles the completion half
itself, so there is no completion plugin in the loop:

- **server**: `copilot-language-server`, installed by mason
  (`lua/plugins/lsp.lua`), configured by the `lsp/copilot.lua` that ships with
  nvim-lspconfig, enabled via `opts.servers.copilot`.
- **ghost text**: `vim.lsp.inline_completion`, enabled on `LspAttach` for any
  client advertising `textDocument/inlineCompletion`.
- **NES** (next edit suggestions, the edits elsewhere in the buffer):
  [copilot-lsp](https://github.com/copilotlsp-nvim/copilot-lsp), which supplies
  the LSP handlers, the `nextEditSuggestions` setting and the preview UI.

All of it lives in `lua/plugins/copilot.lua`.

## Setup

Nothing is gated on credentials — the server is always configured, so the
commands are always there:

1. `:Lazy sync` and let mason install `copilot-language-server`.
2. Open any file, then `:LspCopilotSignIn` and follow the device-code flow.
3. `:checkhealth vim.lsp` should list `copilot` under active clients, and
   `inline_completion` under active features.

Sign out with `:LspCopilotSignOut`. Credentials live in
`~/.config/github-copilot/`, shared with any other editor using the same
server.

## Keymaps

Insert mode:

- `<Tab>`: accept the Copilot suggestion. Falls through to the blink.cmp menu
  item, then `snippet_forward`, then a literal tab
- `<M-]>` / `<M-[>`: cycle to the next/previous Copilot suggestion. Needs
  `macos-option-as-alt` in the Ghostty config; it is set to `right`, so use the
  right Option key
- `<C-j>` / `<C-k>`: move through the blink.cmp menu (nothing to do with
  Copilot)

Normal mode, while a NES suggestion is pending:

- `<Tab>`: jump to the suggested edit, then apply it (plain `<Tab>` otherwise,
  so the jumplist still works)
- `<Esc>`: dismiss it

NES also clears itself after a few cursor moves (`move_count_threshold`,
default 3). Request debounce is `vim.g.copilot_nes_debounce`, set to 500ms.

## Notes

- nvim-lspconfig's config sets `telemetry.telemetryLevel = "all"`; override it
  in `opts.servers.copilot.settings` if you'd rather it were quieter.
- blink.cmp's own ghost text is turned off on purpose — two sets of ghost text
  fight over the same screen space.
