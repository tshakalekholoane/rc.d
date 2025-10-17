vim.opt.commentstring = "# %s"

local function format() 
  vim.cmd("!fish_indent --write %")
end

vim.keymap.set("n", "<space>f", format, { desc = "Format Fish script" })
