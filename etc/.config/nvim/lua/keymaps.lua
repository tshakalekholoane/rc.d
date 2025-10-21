-- Diagnostics.
local function toggle_diagnostics()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  vim.opt.spell = not vim.opt.spell:get()
end

vim.keymap.set("n", "<Leader>d", toggle_diagnostics,        { desc = "Toggle [d]iagnostics"            })
vim.keymap.set("n", "<space>e",  vim.diagnostic.open_float, { desc = "Open diagnostic floating window" })
vim.keymap.set("n", "<space>q",  vim.diagnostic.setloclist, { desc = "Open diagnostic [q]uickfix list" })
vim.keymap.set("n", "[d",        vim.diagnostic.goto_prev,  { desc = "Go to previous diagnostic"       })
vim.keymap.set("n", "]d",        vim.diagnostic.goto_next,  { desc = "Go to next diagnostic"           })

-- Ex.
vim.keymap.set("n", "<Leader>e", vim.cmd.Explore,   { desc = ":[E]xplore" })
vim.keymap.set("n", "<Leader>o", ":only<CR>",       { desc = ":[o]nly"    })
vim.keymap.set("n", "<Leader>q", "<Esc>:q!<CR>",    { desc = ":[q]uit"    })
vim.keymap.set("n", "<Leader>r", "<Esc>:edit<CR>",  { desc = ":[e]dit"    })
vim.keymap.set("n", "<Leader>w", "<Esc>:write<CR>", { desc = ":[write]"   })
vim.keymap.set("n", "<Leader>x", "<Esc>:x!<CR>",    { desc = ":[x]!"      })

-- General.
vim.keymap.set("n", "<Leader>s", "<Esc>:.! snip ", { desc = "Read snip command output"})
vim.keymap.set("n", "Q",         "<Nop>",          { desc = "Suppress repeating last register" })

-- Language Server.
local function async_buf_format()
  vim.lsp.buf.format { async = true }
end

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]o to [d]efinition"    })
vim.keymap.set("n", "gf", async_buf_format,       { desc = "[F]ormat current buffer" })
