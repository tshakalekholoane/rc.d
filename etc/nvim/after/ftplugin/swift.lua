local format = require "utilities.format"

vim.opt_local.commentstring = "// %s"

format.set_program("swiftformat --quiet --stdin-path " .. vim.fn.expand("%:p"))
