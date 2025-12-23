vim.lsp.config("gopls", {
  -- Override default settings.
  settings = {
    gopls = {
      analyses    = { shadow = true, unusedvariable = true },
      gofumpt     = true,
      staticcheck = true,
      vulncheck   = "Imports",
    },
  },
})

vim.lsp.config("sourcekit", {
  -- Disable SourceKit for C and C++ files.
  filetypes = { 'swift', 'objc', 'objcpp' },
})

vim.lsp.enable({
  "clangd",
  "cssls",
  "golangci_lint_ls",
  "gopls",
  "html",
  "pyright",
  "ruff",
  "rust_analyzer",
  "sourcekit",
})
