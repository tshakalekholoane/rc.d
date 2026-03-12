--- Configure an external formatter and bind it to `gf`.
local M = {}

local function format()
  local position = vim.api.nvim_win_get_cursor(0)
  vim.cmd("normal! gggqG")
  vim.api.nvim_win_set_cursor(0, position)
end

--- Set `formatprg` for the current buffer and bind `gf` to format the
--- current buffer.
---
--- @param program string The formatter command. Must read from stdin
--- and write to stdout.
function M.set_program(program)
  vim.opt_local.formatprg = program
  vim.keymap.set("n", "gf", format, { buffer = true, desc = "Format file" })
end

return M
