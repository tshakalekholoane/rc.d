vim.opt.commentstring = "// %s"

local function format()
  vim.cmd(":silent !swiftformat '%'")
end

vim.keymap.set("n", "<space>f", format, { desc = "Format Swift file" })
