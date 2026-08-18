local system_appearance     = require "utilities.system_appearance"

local namespace_global      = 0
local namespace_xcode_marks = vim.api.nvim_create_namespace("XcodeMarks")

vim.api.nvim_set_hl(namespace_global, "XcodeMarkLine", { link = "CursorLine", bold = true })
vim.api.nvim_set_hl(namespace_global, "XcodeMarkLineNr", { link = "CursorLine" })

vim.api.nvim_create_autocmd({ "BufWinEnter", "TextChanged", "InsertLeave" }, {
  group    = vim.api.nvim_create_augroup("XcodeMarksGroup", { clear = true }),
  callback = function(args)
    local bufnr = args.buf or vim.api.nvim_get_current_buf()
    if not vim.api.nvim_buf_is_valid(bufnr) then
      return
    end
    vim.api.nvim_buf_clear_namespace(bufnr, namespace_xcode_marks, 0, -1)
    for i, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
      if line:find(" MARK: - ") or line:find("#pragma mark ") then
        vim.api.nvim_buf_set_extmark(bufnr, namespace_xcode_marks, i - 1, 0, {
          line_hl_group   = "XcodeMarkLine",
          number_hl_group = "XcodeMarkLineNr",
        })
      end
    end
  end,
})

local function apply()
  local is_dark = system_appearance.is_dark()

  vim.cmd.colorscheme(is_dark and "mu_dark" or "mu")
  vim.opt.background = is_dark and "dark" or "light"

  -- Override the background to be transparent.
  vim.api.nvim_set_hl(namespace_global, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(namespace_global, "NonText", { bg = "none" })
end

apply()

-- Re-apply when an external program notifies Neovim of an appearance
-- change via a user defined signal.
vim.uv.signal_start(vim.uv.new_signal(), "sigusr1", function()
  vim.schedule(apply)
end)
