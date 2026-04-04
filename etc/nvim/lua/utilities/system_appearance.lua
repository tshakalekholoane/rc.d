--- Utilities for detecting the host operating system's appearance
--- settings.
---
--- @module "system_appearance"
local M = {}

--- Returns whether the host operating system is currently using a dark
--- appearance.
---
--- On **macOS**, this queries `AppleInterfaceStyle` via `defaults(1)`.
--- On all other operating systems `false` is returned unconditionally
--- for now.
---
--- @return boolean `true` if the system is in Dark Mode, `false`
---  otherwise or if the appearance cannot be determined.
function M.is_dark()
  local info = vim.uv.os_uname()
  if info.sysname == "Darwin" then
    local output = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null")
    return vim.trim(output) == "Dark"
  end
  return false
end

return M
