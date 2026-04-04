local mappings = {
  -- Diagnostics.
  {
    lhs = "<Leader>d",
    rhs = function()
      vim.diagnostic.enable(not vim.diagnostic.is_enabled())
      vim.opt.spell = not vim.opt.spell:get()
    end,
    desc = "Toggle [d]iagnostics",
  },
  { lhs = "<space>e",  rhs = vim.diagnostic.open_float, desc = "Open diagnostic floating window" },
  { lhs = "<space>q",  rhs = vim.diagnostic.setloclist, desc = "Open diagnostic [q]uickfix list" },
  { lhs = "[d",        rhs = vim.diagnostic.goto_prev,  desc = "Go to previous diagnostic" },
  { lhs = "]d",        rhs = vim.diagnostic.goto_next,  desc = "Go to next diagnostic" },

  -- Ex.
  { lhs = "<Leader>e", rhs = vim.cmd.Explore,           desc = ":[E]xplore" },
  { lhs = "<Leader>o", rhs = ":only<CR>",               desc = ":[o]nly" },
  { lhs = "<Leader>q", rhs = "<Esc>:q!<CR>",            desc = ":[q]uit" },
  { lhs = "<Leader>r", rhs = "<Esc>:edit<CR>",          desc = ":[e]dit" },
  { lhs = "<Leader>w", rhs = "<Esc>:write<CR>",         desc = ":[w]rite" },
  { lhs = "<Leader>x", rhs = "<Esc>:x!<CR>",            desc = ":[x]!" },

  -- General.
  { lhs = "<Leader>s", rhs = "<Esc>:r! snip ",          desc = "Read snip command output" },
  { lhs = "Q",         rhs = "<Nop>",                   desc = "Suppress repeating last register" },

  -- Language Server.
  { lhs = "gd",        rhs = vim.lsp.buf.definition,    desc = "[G]o to [d]efinition" },
  {
    lhs = "gf",
    rhs = function()
      vim.lsp.buf.format({ async = true })
    end,
    desc = "[F]ormat current buffer",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set("n", mapping.lhs, mapping.rhs, { desc = mapping.desc })
end
