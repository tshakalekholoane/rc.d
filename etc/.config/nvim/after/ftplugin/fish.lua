
local function format() 
  vim.cmd("!fish_indent --write %")
end
vim.opt_local.commentstring = "# %s"

vim.keymap.set("n", "<space>f", format, { desc = "Format Fish script" })
