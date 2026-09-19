-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Auto-reload files changed on disk by background agents, git, etc.
local aug = vim.api.nvim_create_augroup("ai_agent_reload", { clear = true })

-- `checktime` does nothing while an autocmd is running, so defer it. Bare
-- `checktime` covers every loaded buffer, not just the focused one, so splits
-- showing other files an agent touched don't go stale until we enter them.
local function check_all_buffers()
  vim.schedule(function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("silent! checktime")
    end
  end)
end

vim.api.nvim_create_autocmd("FocusGained", {
  desc = "Reload files from disk when we focus vim",
  group = aug,
  callback = check_all_buffers,
})

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold" }, {
  desc = "Check every loaded buffer for changes on disk",
  group = aug,
  callback = check_all_buffers,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  desc = "Say which file was reloaded underneath us",
  group = aug,
  callback = function(args)
    vim.notify(vim.fn.fnamemodify(args.file, ":~:."), vim.log.levels.INFO, { title = "Reloaded from disk" })
  end,
})
