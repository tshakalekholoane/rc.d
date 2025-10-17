vim.cmd.colorscheme("semafor")

-- Override the background to be transparent.
local global = 0
vim.api.nvim_set_hl(global, "Normal",  { bg = "none" })
vim.api.nvim_set_hl(global, "NonText", { bg = "none" })
