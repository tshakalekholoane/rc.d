local system_appearance = require "utilities.system_appearance"

local function apply()
  local is_dark = system_appearance.is_dark()

  vim.cmd.colorscheme(is_dark and "mu_dark" or "mu")
  vim.opt.background = is_dark and "dark" or "light"

  -- Override the background to be transparent.
  local global = 0
  vim.api.nvim_set_hl(global, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(global, "NonText", { bg = "none" })
end

apply()

-- Re-apply when an external program notifies Neovim of an appearance
-- change via a user defined signal.
local signal = vim.uv.new_signal()
vim.uv.signal_start(signal, "sigusr1", function()
  vim.schedule(apply)
end)
