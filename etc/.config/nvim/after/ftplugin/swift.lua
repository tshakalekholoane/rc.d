
local function format()
  vim.cmd(":silent !swiftformat '%'")
end
vim.opt_local.commentstring = "// %s"

vim.keymap.set("n", "<space>f", format, { desc = "Format Swift file" })
