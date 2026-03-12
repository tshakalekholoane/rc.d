local format = require "format"

vim.opt_local.linebreak = true
vim.opt_local.wrap = true

format.set_program("prettier --parser markdown")
