local format = require "utilities.format"

vim.opt_local.commentstring = "# %s"

format.set_program("fish_indent")
