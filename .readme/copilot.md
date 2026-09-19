# GitHub Copilot

Copilot is opt-in by credentials: `lua/config/options.lua` sets `vim.g.ai_copilot`
only when `~/.config/github-copilot/apps.json` or `hosts.json` exists. While the
flag is off, both `copilot.lua` and the `blink-cmp-copilot` source are disabled,
so a machine without Copilot pulls neither plugin and stays quiet on startup.

No Node needed: copilot.lua v3 defaults to the bundled `binary` server
(`copilot-language-server`). Only `server = { type = "nodejs" }` needs Node, 22+.

## First-time setup

`copilot.lua` is `enabled = vim.g.ai_copilot`, so on a fresh machine lazy.nvim
never installs it and `:Copilot` doesn't exist yet. Force the flag on for one
session to authenticate:

1. In `lua/config/options.lua`, temporarily replace the `fs_stat` check with
   `vim.g.ai_copilot = true`.
2. `:Lazy sync` to install `copilot.lua`, then `:Copilot auth` and follow the
   device-code flow in the browser.
3. Verify with `:Copilot status` and `:checkhealth copilot` (prints the
   credential path it found).
4. Revert `lua/config/options.lua`.

Note: v3 writes credentials to `~/.config/github-copilot/auth.db` —
`apps.json` / `hosts.json` are from older versions. If step 4 leaves Copilot
disabled, the check in `lua/config/options.lua` needs `auth.db` added.

## Keymaps

With `vim.g.ai_cmp` on (LazyVim default), suggestions come through the
blink.cmp menu as a `copilot` source instead of inline ghost text:

- `<C-j>` / `<C-k>`: cycle items, ghost text previews the selected one
- `<Tab>`: accept the previewed item
- `<CR>`, `<C-y>`: also accept

Set `vim.g.ai_cmp = false` for copilot.lua's own inline suggestions, where
`<M-]>` / `<M-[>` cycle them (see `lua/plugins/copilot.lua`).

Turn it off with `:Copilot disable` for the session, or `:Copilot auth signout`
for good.
