vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.code_action({
      context = { only = { "source.organizeImports" } },
      apply   = true,
    })
  end,
  desc     = "Organise imports",
  group    = vim.api.nvim_create_augroup("go-organise-imports", { clear = true }),
  pattern  = "*.go",
})

vim.opt_local.expandtab   = false
vim.opt_local.tabstop     = 2
vim.opt_local.shiftwidth  = 2
vim.opt_local.softtabstop = 0
