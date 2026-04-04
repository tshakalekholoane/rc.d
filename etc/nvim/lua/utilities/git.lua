--- Git utilities.
---
--- This module provides lightweight wrappers around state maintained by
--- the lewis6991/gitsigns.nvim plugin.
---
--- Rather than shelling out to git or managing buffer-local variables
--- manually, it reads from variables that gitsigns keeps reactively up
--- to date — meaning they reflect the true current state without any
--- polling or autocmd wiring on my part.
---
--- @module "git"
local M = {}

--- Returns the Git branch name for the current buffer.
---
--- Reads `vim.b.gitsigns_head`, a buffer-local variable that gitsigns
--- populates and updates automatically on branch changes, checkout
--- events, and worktree switches.
---
--- @return string The current branch name, or an empty string if the
--- buffer is not inside a Git repository or gitsigns has not yet
--- attached to it.
function M.branch()
  return vim.b.gitsigns_head or ""
end

return M
